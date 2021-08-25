up: run-build-docker

run-build-docker: linux run-docker

clean:
	#################################
	######      Go clean       ######
	#################################

	@go mod tidy
	@go vet ./...
	@go fmt ./...
	@echo "cleaning up"

build:
	#################################
	######    Build Binary     ######
	#################################
	@echo
	@echo "### Building static release/deepspace binary"
	go build -o release/deepspace github.com/davidvader/deep-space-go/cmd/deepspace

.PHONY: build-static-ci
build-static-ci:
	#################################
	######   Build CI Binary   ######
	#################################
	@echo
	@echo "### Building CI static release/deepspace binary"
	@go build -a \
		-ldflags '-s -w -extldflags "-static" ${LD_FLAGS}' \
		-o release/deepspace \
		github.com/davidvader/deep-space-go/cmd/deepspace

linux:
	#################################
	######  Build Linux Binary ######
	#################################
	@echo
	@echo "### Building static release/deepspace binary for linux"
	GOOS=linux CGO_ENABLED=0 \
		go build -o release/deepspace github.com/davidvader/deep-space-go/cmd/deepspace

docker:
	#################################
	######    Build Docker     ######
	#################################
	@echo "### Building Docker image"
	docker build .

run:
	#################################
	######    Run DeepSpace    ######
	#################################
	@echo
	@echo "### Running deepspace server"
	./release/deepspace server

run-docker:
	#################################
	######    Run DS Docker    ######
	#################################
	@echo
	@echo "### Rebuilding and running deepspace docker"
	docker-compose up --build -d