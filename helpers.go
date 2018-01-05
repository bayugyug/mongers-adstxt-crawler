package main

import (
	"crypto/md5"
	"crypto/rand"
	"fmt"
	"log"
	mt "math/rand"
	"runtime"
	"sort"
	"strconv"
	"strings"
	"time"
)

const randChars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"

//memDmp dump the current Mem in MBytes
func memDmp() {
	var mem runtime.MemStats
	runtime.ReadMemStats(&mem)
	m, _ := strconv.Atoi(strconv.FormatUint(mem.Alloc, 10))
	log.Println("Mem", fmt.Sprintf("%.04f", float64(m)/(1024*1024)), " MB")
}

//createTempStr uniq uuid generator
func createTempStr(pfx string) string {

	var uniqid string

	if len(pfx) > 0 {
		uniqid = fmt.Sprintf("%s%04X%04X%16X", pfx, mt.Intn(9999), mt.Intn(9999), time.Now().UTC().UnixNano())
	} else {
		uniqid = fmt.Sprintf("%s%04X%04X%16X", "tmf", mt.Intn(9999), mt.Intn(9999), time.Now().UTC().UnixNano())
	}

	return strings.ToUpper(uniqid + randStr(8))
}

//randStr more than 1 way to do random chars
func randStr(strSize int) string {
	var bytes = make([]byte, strSize)
	rand.Read(bytes)
	for k, v := range bytes {
		bytes[k] = randChars[v%byte(len(randChars))]
	}
	return string(bytes)
}

//timeElapsed display the time elapsed since t0
func timeElapsed(start time.Time, name string) {
	elapsed := time.Since(start)
	fmt.Println(fmt.Sprintf("%s took %d ms", name, elapsed.Nanoseconds()/1000000))
}

//hashmd5 calc the md5 sum of the string
func md5hash(s string) string {
	return fmt.Sprintf("%x", md5.Sum([]byte(s)))
}

//statsDmp dump all the stats summary
func statsDmp() {
	slist := pStats.getStatsList()
	log.Println("===============")
	log.Println("Stats Summary")
	log.Println("===============")
	skeys := mapSortByKey(slist)
	for _, v := range skeys {
		log.Println(v, " -> ", slist[v])
	}
	log.Println("===============")
}

//mapSortByKey try to sort the stats details
func mapSortByKey(statz map[string]int) []string {
	srtkeys := []string{}
	for k, _ := range statz {
		srtkeys = append(srtkeys, k)
	}
	sort.Strings(srtkeys)
	return srtkeys
}
