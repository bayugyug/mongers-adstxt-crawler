package main

import (
	"log"
	"time"
)

func main() {
	start := time.Now()
	log.Println("Start")
	log.Println("App", pVersion)
	doIt()
	statsDmp()
	memDmp()
	elapsed := time.Since(start)
	log.Println("Takes about: ", elapsed)
	log.Println("Done")
}
