# dbtdemo

Demo project for Gomason and DBT

Gomason was written before Go Modules was a thing.  

Back in the day, you basically had to check in all your dependencies.  If you didn't, you ran the risk of building with dependencies of who-knows-what version based on whatever system you were building on.  This caused unreliable builds, and stuff that would work when build on one person's laptop, but not in any other environment.

Gomason's default behavior is to make a new GOPATH, and clone your repo into it, then do all it's building and testing there, cleaning up after it's done.  By design, if you made local edits and did not check them in they would never be seen, since gomason clones the code as it's first step.

Nowadays, that's not as useful as it used to be.  However, the ability to build, sign, and upload for multiple architectures based on the `metadata.json` file is still often quite useful.

The author has solved many problems - such as compiling golang tools with CGO with particular options so that they work under VPN's on Macs and such.  It has been useful to take verbatim code from github, and build/sign/publish it internally for internal tools.  Sure, you can do this with a Makefile, but I wrote the individual steps so many times over and over I got sick of it and automated it.

## Makefile Targets

This example repo contains a Makefile with a few targets for your pleasure.

### gobuild

Just runs `go build`, but does it in a temporary 'clean room' GOPATH.  Less useful now that Go Modules exist.

### gomason-test

Just runs `go test -v ./...` in a temporary 'clean room' GOPATH.  Less useful now that Go Modules exist.

### gomason-build

Runs [https://github.com/mitchellh/gox](gox) with just the targets listed in `metadata.json`.  Does it in a temporary 'clean room' GOPATH by default.

### gomason-publish

Tests, builds, signs, and uploads artifacts, checksums, and detatched signature files to a remote server.  Signing keys must be available in the run environment.  Run environment must also be able to access the repository.  Works with Artifactory, S3, the DBT Reposerver, and should work with any WebDAV enabled HTTP server. 

### gomason-publish-local

Does the same thing as [gomason-publish](#gomason-publish), but does it using the code currently on disk at $(pwd).  Now that Go Modules exist, this is, arguably, the more useful usage of `gomason`, since any CI system probably already handles checkouts.

### gomason-publish-local-no-tests

Does the same thing as [gomason-publish-local](#gomason-publish-local), but doesn't run the tests.  

Why would you do this?  Sometimes you need to build/publish a third-party tool with some 'special sauce' for use in your organization or environment.  A good example is Hashicorp Vault, compiled with CGO so that it will transparently work with MacOS DNS while under a VPN.

There are more than a few golang tools that can be used straight from Homebrew, but Homebrew decided to never use CGO, and automatic support of things like the MacOS DNS resolver setup has been slow to roll out.  

Last the author heard, this was supposed to be seamless in modern versions of Golang, but I am an engineer, and I will not believe it until I see it working.
