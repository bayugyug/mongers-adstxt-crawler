package main

import (
	"database/sql"
	"flag"
	"fmt"
	"log"
	"math/rand"
	"net/http"
	"os"
	"runtime"
	"time"

	_ "github.com/go-sql-driver/mysql"
)

//AdsTxt holder for the adstxt info
type AdsTxt struct {
	SiteDomain      string `json:"site_domain"`
	ExchangeDomain  string `json:"exchange_domain"`
	SellerAccountID string `json:"seller_account_id"`
	AdsystemDomain  string `json:"adsystem_domain"`
	AccountType     string `json:"account_type"`
	TagID           string `json:"tag_id"`
	EntryComment    string `json:"entry_comment"`
}

const (
	usageTargetFile = "Target file to parse"
)

var (
	pBuildTime  = ""
	adsTxt      chan AdsTxt
	urlList     chan string
	sqlDb       *sql.DB
	pTargetFile = ""
	pTargetMax  = 1000
	//signal flag
	pStillRunning     = true
	adsystemDomainMap map[string]int

	pDbConnectStr = "root:@tcp(127.0.0.1:3306)/adstxtcrawler"

	// envt vars
	parameters = map[string]*string{
		"ADSTXTCRAWLER_TARGET": &pTargetFile,
		"ADSTXTCRAWLER_DBCONN": &pDbConnectStr,
	}
	pVersion = "0.01" + "-" + pBuildTime
	pStats   *StatsHelper
)

func init() {
	//uniqueness
	rand.Seed(time.Now().UnixNano())

	adsystemDomainMap = make(map[string]int)
	pStats = StatsHelperNew()

	getPrametersFromEnv()

	initEnvParams()

	initSQLDb()

	//more
	runtime.GOMAXPROCS(runtime.NumCPU())
	http.DefaultTransport.(*http.Transport).MaxIdleConnsPerHost = 1000

	urlList = make(chan string, pTargetMax)
	adsTxt = make(chan AdsTxt, 500)
}

//initRecov is for dumpIng segv in
func initRecov() {
	//might help u
	defer func() {
		recvr := recover()
		if recvr != nil {
			log.Println("MAIN-RECOV-INIT: ", recvr)
		}
	}()
}

func initSQLDb() {
	var err error
	sqlDb, err = sql.Open("mysql", "root:@tcp(127.0.0.1:3306)/adstxtcrawler")
	if err != nil {
		log.Fatal("SQL:", err)
	}
	log.Println("DB Connected")

	//load the mappings here
	r := `SELECT domain, domain_id FROM  adsystem_domain`
	rows, err := sqlDb.Query(r)
	if err != nil {
		log.Println("Error in sql:", err)
	} else {
		defer rows.Close()
		for rows.Next() {
			var name string
			var did int
			if err := rows.Scan(&name, &did); err != nil {
				log.Panicln(err)
				continue
			}
			if len(name) > 0 && did > 0 {
				adsystemDomainMap[name] = did
			}
		}
	}

}

//initEnvParams enable all OS envt vars to reload internally
func initEnvParams() {
	//fmt
	flag.StringVar(&pTargetFile, "t", pTargetFile, usageTargetFile+" (short form) ")
	flag.StringVar(&pTargetFile, "target", pTargetFile, usageTargetFile)
	flag.Parse()
	if len(os.Args) < 2 || pTargetFile == "" {
		showMessage()
	}

	if _, err := os.Stat(pTargetFile); os.IsNotExist(err) {
		fmt.Println()
		fmt.Println("Oops, target file not found!", pTargetFile)
		fmt.Println()
		os.Exit(0)
		return
	}

}

func showMessage() {

	msg := `
Usage: mongers-adstxt-crawler [options]

     Options are:

`
	fmt.Println()
	fmt.Println()
	fmt.Println(msg)
	flag.PrintDefaults()
	fmt.Println()
	os.Exit(0)
}

//getPrametersFromEnv parse envt vars
func getPrametersFromEnv() {
	for k, v := range parameters {
		if os.Getenv(k) != "" {
			*v = os.Getenv(k)
		}
	}

}
