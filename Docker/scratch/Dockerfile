FROM scratch


#environment
ENV GOHOME=
ENV GOPATH=$GOHOME/go
ENV PATH=$PATH:$GOPATH/bin

COPY ./mongers-adstxt-crawler /mongers-adstxt-crawler

ENTRYPOINT [ "/mongers-adstxt-crawler" ]

