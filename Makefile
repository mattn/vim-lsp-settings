.PHONY: shellcheck
shellcheck:
	find ./installer -name "*.sh" -type f -print0 | xargs -0 shellcheck

.PHONY: shellcheck-docker
shellcheck-docker:
	find ./installer -name "*.sh" -type f -print0 | xargs -0 docker run -t --rm -v "${PWD}:/mnt" koalaman/shellcheck:stable

.PHONY: shfmt
shfmt:
	find ./installer -name "*.sh" -type f -print0 | xargs -0 shfmt -w
