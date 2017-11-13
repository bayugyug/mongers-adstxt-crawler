## mongers-adstxt-crawler


- [x] An example crawler for ads.txt files given a list of URLs or domains etc and saves them to a Mysql DB table.


- [x] Load the db.schema.sql into a mysql db



## Usage

```sh


$ ./mongers-adstxt-crawler



Usage: mongers-adstxt-crawler [options]

     Options are:


  -t string
        Target file to parse (short form)
  -target string
        Target file to parse

```

### Warnings

This is an example prototype crawler and would be suitable only for a very modest production usage.

## Compile

- [x] In order to produce the binary


``` sh


    cd mongers-adstxt-crawler && go build


```

### License

[MIT](https://bayugyug.mit-license.org/)
