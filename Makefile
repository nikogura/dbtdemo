GOMASON := $(shell which gomason)

# ensure `gomason` is installed
.PHONY: check-gomason
check-gomason:
	@if [ -z "${GOMASON}" ]; then echo "gomason not installed. You can fix this by running: go install github.com/nikogura/gomason@latest"; exit $1; fi

# Build the demo via 'go build'
gobuild: check-gomason
	go build

# test via gomason
gomason-test: check-gomason
	gomason test -v

# build the demo via 'gomason'
gomason-build: check-gomason
	gomason build -v

# publish via gomason - tests, builds, signs, and uploads to repo in ./metadata.json under the 'repository' key.  You are assumed to have access to this location.
gomason-publish: check-gomason
	gomason publish -v

# publish via gomason w/o doing a download into a clean GOPATH - just use the code here in $(pwd)
gomason-publish-local: check-gomason
	gomason publish -vl

# publish via gomason w/o doing a download into a clean GOPATH - just use the code here in $(pwd), and don't bother running any tests.
gomason-publish-local-no-tests: check-gomason
	gomason publish -vsl

