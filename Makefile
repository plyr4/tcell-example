up: run-build-docker

run: build run-binary

run-build-docker: linux run-docker

clean:
	@echo "### Cleaning up"
	@go mod tidy
	@go vet ./...
	@go fmt ./...

build:
	@echo
	@echo "### Building static release/deepspace binary"
	go build -o release/deepspace github.com/davidvader/deep-space-go/cmd/deepspace

build-static-ci:
	@echo
	@echo "### Building CI static release/deepspace binary"
	@go build -a \
		-ldflags '-s -w -extldflags "-static" ${LD_FLAGS}' \
		-o release/deepspace \
		github.com/davidvader/deep-space-go/cmd/deepspace

linux:
	@echo
	@echo "### Building static release/deepspace binary for linux"
	GOOS=linux CGO_ENABLED=0 \
		go build -o release/deepspace github.com/davidvader/deep-space-go/cmd/deepspace

docker:
	@echo "### Building Docker image"
	docker build .

run-binary:
	@echo
	@echo "### Running deepspace server"
	./release/deepspace server

run-docker:
	@echo
	@echo "### Rebuilding and running deepspace docker"
	docker-compose up --build -d