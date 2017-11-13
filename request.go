package main

import (
	"bufio"
	"io/ioutil"
	"log"
	"net"
	"net/http"
	"net/url"
	"os"
	"runtime"
	"strings"
	"sync"
	"time"

	"github.com/asaskevich/govalidator"
	_ "github.com/go-sql-driver/mysql"
)

func doIt() {
	//waiters
	uFlag := make(chan bool)
	uwg := new(sync.WaitGroup)

	vFlag := make(chan bool)
	vwg := new(sync.WaitGroup)

	wFlag := make(chan bool)
	wwg := new(sync.WaitGroup)

	//get remote ads.txt
	uwg.Add(1)
	go asyncProcRequest(uFlag, uwg)

	//parse the params file
	vwg.Add(1)
	go asyncParseFile(vFlag, vwg)

	//insert db rows
	wwg.Add(1)
	go asyncProcDbTrans(wFlag, wwg)

	//wait the last db trans
	wwg.Wait()
	//wait the get remote ads.txt
	uwg.Wait()
	//wait the parsefile
	vwg.Wait()

	//free up flags
	close(uFlag)
	close(vFlag)
	close(wFlag)
}

func asyncProcRequest(doneFlg chan bool, wg *sync.WaitGroup) {
	log.Println("asyncProcRequest: Start")
	go func() {
		for {
			select {
			//wait till doneFlag has value ;-)
			case <-doneFlg:
				//done already ;-)
				wg.Done()
				return
			}
		}
	}()

	for remotehost := range urlList {
		//sig-check
		if !pStillRunning {
			log.Println("Signal detected ...")
			doneFlg <- true
			return
		}
		siteDomain := strings.TrimSpace(strings.Replace(
			strings.Replace(strings.Replace(remotehost, "/ads.txt", "", -1), "https://", "", -1),
			"http://", "", -1))
		// Minimum length of a domain name is 1 character, not including extensions.
		// Domain Name Rules - Nic AG
		// www.nic.ag/rules.htm
		if len(siteDomain) < 3 {
			log.Println("Invalid URL: ", siteDomain)
			continue
		}

		//get remote data
		urlAds, err := asynGetURL(remotehost)
		if err != nil {
			log.Println("FAILED proc: ", remotehost, err)
			continue
		}
		if strings.Contains(urlAds, "<html") || strings.Contains(urlAds, "<body") || strings.Contains(urlAds, "<div") || strings.Contains(urlAds, "<a ") {
			log.Println("Ignoring not a valid txt file format: ", remotehost)
			continue
		}
		log.Println("SUCCESS proc: ", remotehost)
		adLines := strings.Split(urlAds, "\n")
		for _, ad := range adLines {
			ad = strings.TrimSpace(ad)
			if strings.HasPrefix(ad, "#") {
				//ignore comment
				continue
			}
			//check if have comments
			crows := strings.Split(ad, "#")
			comments := ""
			if len(crows) > 1 && len(crows[1]) > 0 {
				comments = strings.TrimSpace(crows[1])
				ad = crows[0]
			}

			//check sep
			sep := " "
			if strings.Contains(ad, ",") {
				sep = ","
			} else if strings.Contains(ad, "\t") {
				sep = "\t"
			}
			//break it into pieces
			recrows := strings.Split(ad, sep)

			exchangeHost := ""
			sellerAccountID := ""
			accountType := ""
			tagID := ""

			//must be 3 fields
			if len(recrows) < 3 {
				continue
			}

			if len(recrows) >= 3 {
				exchangeHost = strings.TrimSpace(strings.ToLower(recrows[0]))
				sellerAccountID = strings.TrimSpace(strings.ToLower(recrows[1]))
				accountType = strings.TrimSpace(strings.ToLower(recrows[2]))
			}

			if len(recrows) >= 4 {
				tagID = strings.TrimSpace(strings.ToLower(recrows[3]))
			}

			//sanity check
			if len(exchangeHost) < 3 {
				log.Println("Invalid exchangeHost: ", recrows, siteDomain)
				continue
			}
			//could be single digit integers
			if len(sellerAccountID) < 1 {
				log.Println("Invalid sellerAccountID: ", recrows, siteDomain)
				continue
			}
			//ads.txt supports 'DIRECT' and 'RESELLER'
			if len(accountType) < 6 {
				log.Println("Invalid accountType: ", recrows, siteDomain)
				continue
			}

			//save to channel
			adsTxt <- AdsTxt{
				SiteDomain:      siteDomain,
				ExchangeDomain:  exchangeHost,
				SellerAccountID: sellerAccountID,
				AccountType:     accountType,
				TagID:           tagID,
				EntryComment:    comments,
			}
		}
		//process the url here
		runtime.Gosched()
	}
	close(adsTxt)
	//send signal -> DONE
	doneFlg <- true
	log.Println("asyncProcRequest: Done")
}

func asyncParseFile(doneFlg chan bool, wg *sync.WaitGroup) {
	log.Println("asyncParseFile: Start")
	go func() {
		for {
			select {
			//wait till doneFlag has value ;-)
			case <-doneFlg:
				//done already ;-)
				wg.Done()
				return
			}
		}
	}()

	log.Println("parseFile:", pTargetFile)
	fh, err := os.Open(pTargetFile)
	if err != nil {
		pStillRunning = false
		log.Println("asyncParseFile failed:", err)
		doneFlg <- true
		return
	}

	defer fh.Close()
	scanner := bufio.NewScanner(fh)
	for scanner.Scan() {
		line := strings.TrimSpace(scanner.Text())
		if strings.HasPrefix(line, "#") || len(strings.TrimSpace(line)) <= 0 {
			continue
		} else if !strings.HasPrefix(line, "http") {
			line = "http://" + line
		}

		if !govalidator.IsURL(line) {
			log.Println("asyncParseFile ignore invalid URL:", line)
			continue
		}

		u, err := url.Parse(line)
		if err != nil {
			log.Println("asyncParseFile ignore invalid URL format:", err)
			continue

		}
		host, _, _ := net.SplitHostPort(u.Host)
		if len(host) <= 0 {
			host = u.Host
		}
		host = strings.TrimSpace(host)
		if len(host) <= 0 {
			log.Println("asyncParseFile ignore invalid URL:", host, line)
			continue
		}
		urlList <- u.Scheme + "://" + host + "/ads.txt"
	}
	if err := scanner.Err(); err != nil {
		log.Println("asyncParseFile scan failed:", err)
		pStillRunning = false
		doneFlg <- true
		return
	}
	//close channel after parsefile
	close(urlList)

	//send signal -> DONE
	doneFlg <- true
	log.Println("asyncParseFile: Done")
}

func asynGetURL(url string) (string, error) {
	response := ""
	nextURL := url
	client := &http.Client{
		Timeout: time.Duration(10 * time.Second),
	}
	for i := 0; i < 5; i++ {
		if !govalidator.IsURL(nextURL) {
			log.Println("asynGetURL: Ignoring the invalid URL>", nextURL)
			continue
		}
		resp, err := client.Get(nextURL)
		if err != nil || resp == nil {
			log.Println("asynGetURL: failed", err, nextURL)
			continue
		}
		if resp.StatusCode == 200 {
			defer resp.Body.Close()
			contents, err := ioutil.ReadAll(resp.Body)
			if err != nil {
				return "", err
			}
			response = string(contents)
			break
		} else {
			nextURL = resp.Header.Get("Location")
		}
	} //for
	return response, nil
}

func asyncProcDbTrans(doneFlg chan bool, wg *sync.WaitGroup) {
	log.Println("asyncProcDbTrans: Start")
	go func() {
		for {
			select {
			//wait till doneFlag has value ;-)
			case <-doneFlg:
				//done already ;-)
				wg.Done()
				return
			}
		}
	}()

	r := `
		INSERT INTO adstxt (site_domain, exchange_domain, seller_account_id, account_type, tag_id, entry_comment, adsystem_domain,create_dt) 
			VALUES (?, ?, ?, ?, ?, ? , ?, Now() )
			ON DUPLICATE KEY UPDATE
			account_type     = ?,
			tag_id           = ?,
			entry_comment    = ?,
			adsystem_domain  = ?,
			update_dt        = Now();
		`
	// ? = placeholder
	stmtIns, err := sqlDb.Prepare(r)
	if err != nil {
		pStillRunning = false
		log.Println("Error in sql: prepare>", err)
		doneFlg <- true
		return

	}
	defer stmtIns.Close()

	for vAd := range adsTxt {
		//sig-check
		if !pStillRunning {
			log.Println("Signal detected ...")
			doneFlg <- true
			return
		}
		domainID, _ := adsystemDomainMap[vAd.ExchangeDomain]
		_, err := stmtIns.Exec(vAd.SiteDomain,
			vAd.ExchangeDomain,
			vAd.SellerAccountID,
			vAd.AccountType,
			vAd.TagID,
			vAd.EntryComment,
			domainID,
			vAd.AccountType,
			vAd.TagID,
			vAd.EntryComment,
			domainID,
		)
		if err != nil {
			log.Println("Error in sql: exec>", err)
			continue
		}
		log.Println("Success DB exec >>> ", vAd)
		runtime.Gosched()
	}
	//send signal -> DONE
	doneFlg <- true
	log.Println("asyncProcDbTrans: Done")
}
