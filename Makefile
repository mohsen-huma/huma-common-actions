# Test Operations Makefile

SHELL := bash
# Update this value when you upgrade the version of your project.
VERSION ?= 1.3.0

.PHONY: changelog
GIT_CHGLOG=git-chglog
JIRA_TASK_PATH:=https://medopadteam.atlassian.net/browse/
JIRA_PROJECT=HCB
changelog: ## Generate a Changelog for versions read from the Git tags. Comment with "chore(CHANGE): update changelog"
	$(call go-get-tool,$(GIT_CHGLOG),github.com/git-chglog/git-chglog/cmd/git-chglog@latest)
	tools/scripts/generate-changelog.sh ${VERSION} ${JIRA_TASK_PATH} ${JIRA_PROJECT}

# go-get-tool installs package $2 to the $GOPATH/bin/$1 if not exist.
define go-get-tool
@[ -f $(GOPATH)/bin/$(1) ] || go install $(2)
endef

.PHONY: help all
help:
	@grep -hE '^[a-zA-Z0-9\._/-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-40s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
