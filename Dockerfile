## Dockerfile for a haskell environment
FROM ubuntu:16.04

## ensure locale is set during build
ENV LANG C.UTF-8

RUN apt-get update && \
    apt-get install -y --no-install-recommends software-properties-common wget && \
    add-apt-repository -y ppa:hvr/ghc && \
    apt-get update && \
    apt-get install -y cabal-install-1.16 ghc-7.4.2 happy-1.19.3 alex-3.1.3 && \
    rm -rf /var/lib/apt/lists/*

ENV PATH /root/.cabal/bin:/opt/cabal/1.14/bin:/opt/ghc/7.4.2/bin:/opt/happy/1.19.3/bin:/opt/alex/3.1.3/bin:$PATH

RUN wget -q http://www.grammaticalframework.org/download/gf_3.9-1_amd64.deb && \
    dpkg -i gf_3.9-1_amd64.deb

## run ghci by default unless a command is specified
CMD ["ghci"]
