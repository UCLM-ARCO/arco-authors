MAKEFLAGS += --warn-undefined-variables
HOW_TO_LOGIN=https://docs.github.com/es/packages/using-github-packages-with-your-projects-ecosystem/configuring-docker-for-use-with-github-packages
export GITHUB_TOKEN_FILE

HUB=docker.pkg.github.com
HUB=ghcr.io
VERSION=latest
NAME=arco-authors
IMAGE=${HUB}/uclm-arco/arco-authors/${NAME}:${VERSION}
API=https://api.github.com/orgs/uclm-arco/packages/container


login:
	@test ! -z "${GITHUB_USERNAME}" || (echo "ERROR: Define var GITHUB_USERNAME"; false)
	@test -f $(GITHUB_TOKEN_FILE) || (echo "ERROR: Need a token. See ${HOW_TO_LOGIN}"; false)
	@cat "$(GITHUB_TOKEN_FILE)" | docker login ${HUB} -u ${GITHUB_USERNAME} --password-stdin

build:
	docker build . -t uclm-arco/${NAME}:${VERSION}

push: login
	docker tag uclm-arco/${NAME}:${VERSION} ${IMAGE}
	docker push ${IMAGE}

versions:
	docker run -v $(shell dirname $$PWD):/github/workspace arco-authors \
		dpkg -l arco-authors texlive-xetex

list-images:
	curl -s -H "Authorization: token $$(cat $$GITHUB_TOKEN_FILE)" \
		-H "Accept: application/vnd.github.v3+json" \
		"$(API)/arco-authors%2Farco-authors/versions"

rm-image:
	curl -X DELETE -H "Authorization: token $$(cat $$GITHUB_TOKEN_FILE)" \
		-H "Accept: application/vnd.github.v3+json" \
		"$(API)/arco-authors%2Farco-authors/versions/$(ID)"
