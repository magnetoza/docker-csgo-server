.PHONY: build
build:
	docker build -t gonzih/cs2-server .

.PHONY: push
push: build
	docker push gonzih/cs2-server
