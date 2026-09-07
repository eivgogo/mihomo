NAME=mihomo
BINDIR=bin
BRANCH=$(shell git branch --show-current)
ifeq ($(BRANCH),Alpha)
VERSION=alpha-$(shell git rev-parse --short HEAD)
else ifeq ($(BRANCH),Beta)
VERSION=beta-$(shell git rev-parse --short HEAD)
else ifeq ($(BRANCH),me)
VERSION=$(shell git describe --tags)
else
VERSION=$(shell git rev-parse --short HEAD)
endif

BUILDTIME=$(shell date -u)
GOBUILD=CGO_ENABLED=0 go build -tags with_gvisor -trimpath -ldflags '-X "github.com/metacubex/mihomo/constant.Version=$(VERSION)" \
		-X "github.com/metacubex/mihomo/constant.BuildTime=$(BUILDTIME)" \
		-w -s -buildid='

# Output binary name includes the version, e.g. mihomo-darwin-arm64-1.19.32
BINNAME=$(NAME)-$@-$(VERSION)

PLATFORM_LIST = \
	darwin-386 \
	darwin-amd64-compatible \
	darwin-amd64 \
	darwin-amd64-v1 \
	darwin-amd64-v2 \
	darwin-amd64-v3 \
	darwin-arm64 \
	linux-386 \
	linux-amd64-compatible \
	linux-amd64 \
	linux-amd64-v1 \
	linux-amd64-v2 \
	linux-amd64-v3 \
	linux-armv5 \
	linux-armv6 \
	linux-armv7 \
	linux-arm64 \
	linux-mips64 \
	linux-mips64le \
	linux-mips-softfloat \
	linux-mips-hardfloat \
	linux-mipsle-softfloat \
	linux-mipsle-hardfloat \
	linux-riscv64 \
	linux-loong64 \
	android-arm64 \
	freebsd-386 \
	freebsd-amd64 \
	freebsd-arm64

WINDOWS_ARCH_LIST = \
	windows-386 \
	windows-amd64-compatible \
	windows-amd64 \
	windows-amd64-v1 \
	windows-amd64-v2 \
	windows-amd64-v3 \
	windows-arm64 \
    windows-arm32v7

all:linux-amd64-v3 linux-arm64\
	darwin-amd64-v3 darwin-arm64\
 	windows-amd64-v3 windows-arm64\


darwin-all: darwin-amd64-v3 darwin-arm64

docker:
	GOAMD64=v1 $(GOBUILD) -o $(BINDIR)/$(BINNAME)

darwin-386:
	GOARCH=386 GOOS=darwin $(GOBUILD) -o $(BINDIR)/$(BINNAME)

darwin-amd64-compatible:
	GOARCH=amd64 GOOS=darwin GOAMD64=v1 $(GOBUILD) -o $(BINDIR)/$(BINNAME)

darwin-amd64:
	GOARCH=amd64 GOOS=darwin GOAMD64=v3 $(GOBUILD) -o $(BINDIR)/$(BINNAME)

darwin-amd64-v1:
	GOARCH=amd64 GOOS=darwin GOAMD64=v1 $(GOBUILD) -o $(BINDIR)/$(BINNAME)

darwin-amd64-v2:
	GOARCH=amd64 GOOS=darwin GOAMD64=v2 $(GOBUILD) -o $(BINDIR)/$(BINNAME)

darwin-amd64-v3:
	GOARCH=amd64 GOOS=darwin GOAMD64=v3 $(GOBUILD) -o $(BINDIR)/$(BINNAME)

darwin-arm64:
	GOARCH=arm64 GOOS=darwin $(GOBUILD) -o $(BINDIR)/$(BINNAME)

linux-386:
	GOARCH=386 GOOS=linux $(GOBUILD) -o $(BINDIR)/$(BINNAME)

linux-amd64-compatible:
	GOARCH=amd64 GOOS=linux GOAMD64=v1 $(GOBUILD) -o $(BINDIR)/$(BINNAME)

linux-amd64:
	GOARCH=amd64 GOOS=linux GOAMD64=v3 $(GOBUILD) -o $(BINDIR)/$(BINNAME)

linux-amd64-v1:
	GOARCH=amd64 GOOS=linux GOAMD64=v1 $(GOBUILD) -o $(BINDIR)/$(BINNAME)

linux-amd64-v2:
	GOARCH=amd64 GOOS=linux GOAMD64=v2 $(GOBUILD) -o $(BINDIR)/$(BINNAME)

linux-amd64-v3:
	GOARCH=amd64 GOOS=linux GOAMD64=v3 $(GOBUILD) -o $(BINDIR)/$(BINNAME)

linux-arm64:
	GOARCH=arm64 GOOS=linux $(GOBUILD) -o $(BINDIR)/$(BINNAME)

linux-armv5:
	GOARCH=arm GOOS=linux GOARM=5 $(GOBUILD) -o $(BINDIR)/$(BINNAME)

linux-armv6:
	GOARCH=arm GOOS=linux GOARM=6 $(GOBUILD) -o $(BINDIR)/$(BINNAME)

linux-armv7:
	GOARCH=arm GOOS=linux GOARM=7 $(GOBUILD) -o $(BINDIR)/$(BINNAME)

linux-mips-softfloat:
	GOARCH=mips GOMIPS=softfloat GOOS=linux $(GOBUILD) -o $(BINDIR)/$(BINNAME)

linux-mips-hardfloat:
	GOARCH=mips GOMIPS=hardfloat GOOS=linux $(GOBUILD) -o $(BINDIR)/$(BINNAME)

linux-mipsle-softfloat:
	GOARCH=mipsle GOMIPS=softfloat GOOS=linux $(GOBUILD) -o $(BINDIR)/$(BINNAME)

linux-mipsle-hardfloat:
	GOARCH=mipsle GOMIPS=hardfloat GOOS=linux $(GOBUILD) -o $(BINDIR)/$(BINNAME)

linux-mips64:
	GOARCH=mips64 GOOS=linux $(GOBUILD) -o $(BINDIR)/$(BINNAME)

linux-mips64le:
	GOARCH=mips64le GOOS=linux $(GOBUILD) -o $(BINDIR)/$(BINNAME)

linux-riscv64:
	GOARCH=riscv64 GOOS=linux $(GOBUILD) -o $(BINDIR)/$(BINNAME)
	
linux-loong64:
	GOARCH=loong64 GOOS=linux $(GOBUILD) -o $(BINDIR)/$(BINNAME)

android-arm64:
	GOARCH=arm64 GOOS=android $(GOBUILD) -o $(BINDIR)/$(BINNAME)

freebsd-386:
	GOARCH=386 GOOS=freebsd $(GOBUILD) -o $(BINDIR)/$(BINNAME)

freebsd-amd64:
	GOARCH=amd64 GOOS=freebsd GOAMD64=v3 $(GOBUILD) -o $(BINDIR)/$(BINNAME)

freebsd-arm64:
	GOARCH=arm64 GOOS=freebsd $(GOBUILD) -o $(BINDIR)/$(BINNAME)

windows-386:
	GOARCH=386 GOOS=windows $(GOBUILD) -o $(BINDIR)/$(BINNAME).exe

windows-amd64-compatible:
	GOARCH=amd64 GOOS=windows GOAMD64=v1 $(GOBUILD) -o $(BINDIR)/$(BINNAME).exe

windows-amd64:
	GOARCH=amd64 GOOS=windows GOAMD64=v3 $(GOBUILD) -o $(BINDIR)/$(BINNAME).exe

windows-amd64-v1:
	GOARCH=amd64 GOOS=windows GOAMD64=v1 $(GOBUILD) -o $(BINDIR)/$(BINNAME).exe

windows-amd64-v2:
	GOARCH=amd64 GOOS=windows GOAMD64=v2 $(GOBUILD) -o $(BINDIR)/$(BINNAME).exe

windows-amd64-v3:
	GOARCH=amd64 GOOS=windows GOAMD64=v3 $(GOBUILD) -o $(BINDIR)/$(BINNAME).exe

windows-arm64:
	GOARCH=arm64 GOOS=windows $(GOBUILD) -o $(BINDIR)/$(BINNAME).exe

windows-arm32v7:
	GOARCH=arm GOOS=windows GOARM=7 $(GOBUILD) -o $(BINDIR)/$(BINNAME).exe

gz_releases=$(addsuffix .gz, $(PLATFORM_LIST))
zip_releases=$(addsuffix .zip, $(WINDOWS_ARCH_LIST))

$(gz_releases): %.gz : %
	chmod +x $(BINDIR)/$(NAME)-$(basename $@)-$(VERSION)
	gzip -f -S -$(VERSION).gz $(BINDIR)/$(NAME)-$(basename $@)-$(VERSION)

$(zip_releases): %.zip : %
	zip -m -j $(BINDIR)/$(NAME)-$(basename $@)-$(VERSION).zip $(BINDIR)/$(NAME)-$(basename $@)-$(VERSION).exe

all-arch: $(PLATFORM_LIST) $(WINDOWS_ARCH_LIST)

releases: $(gz_releases) $(zip_releases)

vet:
	go test ./...

lint:
	golangci-lint run ./...

clean:
	rm $(BINDIR)/*

CLANG ?= clang-14
CFLAGS := -O2 -g -Wall -Werror $(CFLAGS)

