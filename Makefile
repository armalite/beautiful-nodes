SHELL=/bin/bash -e -o pipefail
bold := $(shell tput bold)
sgr0 := $(shell tput sgr0)

.PHONY: help install check test 
.SILENT:

output_location = "output"
dbt_runner_image:="dbt-runner:latest"

MAKEFLAGS += --warn-undefined-variables
.DEFAULT_GOAL := help

## display help message
help:
	@awk '/^##.*$$/,/^[~\/\.0-9a-zA-Z_-]+:/' $(MAKEFILE_LIST) | awk '!(NR%2){print $$0p}{p=$$0}' | awk 'BEGIN {FS = ":.*?##"}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' | sort




###############################################################################
# Local Development Targets
#
###############################################################################

init: 
	terraform init

plan: init
	terraform plan -var-file beautiful-nodes.tfvars

apply: init
	terraform apply -var-file beautiful-nodes.tfvars --auto-approve
