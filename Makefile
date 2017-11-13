all: build

build :
	go get -v
	CGO_ENABLED=0 GOOS=linux go build -a -tags netgo -installsuffix netgo -installsuffix cgo -v -ldflags "-s -w -X main.pBuildTime=`date -u +%Y%m%d.%H%M%S`" .

test : build
	go test *.go > testrun.txt
	golint > lint.txt
	go tool vet -v . > vet.txt
	gocov test github.com/bayugyug/mongers-adstxt-crawler | gocov-xml > coverage.xml
	go test *.go -bench=. -test.benchmem -v 2>/dev/null | gobench2plot > benchmarks.xml

testrun : clean test
	time go test -v -bench=. -benchmem -dummy >> testrun.txt 2>&1

clean:
	rm -f mongers-adstxt-crawler
	rm -f benchmarks.xml coverage.xml vet.txt lint.txt testrun.txt

re: clean all

