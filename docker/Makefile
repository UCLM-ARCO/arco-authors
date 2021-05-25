MAKEFLAGS += --warn-undefined-variables
HOW_TO_LOGIN=https://docs.github.com/es/packages/using-github-packages-with-your-projects-ecosystem/configuring-docker-for-use-with-github-packages
GITHUB_TOKEN=~/.github-token-packages

HUB=docker.pkg.github.com
VERSION=latest
NAME=arco-authors
IMAGE=${HUB}/uclm-arco/arco-authors/${NAME}:${VERSION}

login:
	@test ! -z "${GITHUB_USERNAME}" || (echo "ERROR: Define var GITHUB_USERNAME"; false)
	@test ! -f "${GITHUB_TOKEN}" || (echo "ERROR: Need a token. See $${HOW_TO_LOGIN}"; false)
	@cat ${GITHUB_TOKEN} | docker login ${HUB} -u ${GITHUB_USERNAME} --password-stdin

build:
	docker build . -t ${NAME}

push: build login
	docker tag ${NAME} ${IMAGE}
	docker push ${IMAGE}

version:
	docker run -v $(shell dirname $$PWD):/github/workspace arco-authors dpkg -l arco-authors
	docker run -v $(shell dirname $$PWD):/github/workspace arco-authors dpkg -l xelatex
