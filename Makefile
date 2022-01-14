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
	@echo "### Building static release/tcellexample binary"
	go build -o release/tcellexample github.com/davidvader/tcell-example/cmd/tcellexample

build-static-ci:
	@echo
	@echo "### Building CI static release/tcellexample binary"
	@go build -a \
		-ldflags '-s -w -extldflags "-static" ${LD_FLAGS}' \
		-o release/tcellexample \
		github.com/davidvader/tcell-example/cmd/tcellexample

linux:
	@echo
	@echo "### Building static release/tcellexample binary for linux"
	GOOS=linux CGO_ENABLED=0 \
		go build -o release/tcellexample github.com/davidvader/tcell-example/cmd/tcellexample

docker:
	@echo "### Building Docker image"
	docker build .

run-binary:
	@echo
	@echo "### Running tcellexample server"
	./release/tcellexample server

run-docker:
	@echo
	@echo "### Rebuilding and running tcellexample docker"
	docker-compose up --build -d