SHELL:=/bin/bash

.PHONY: config

config: git config --global --add safe.directory /workspaces/Networking

.PHONY: init
init:
	@terraform init


.PHONY: fmt
fmt:
	@terraform fmt

.PHONY: plan

plan: 
	@terraform plan -out main.tfplan

.PHONY: apply
apply:
	@terraform apply 