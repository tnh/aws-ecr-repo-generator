.PHONY: clean validate deploy
all: clean validate deploy

export BUILDKITE_BRANCH ?= local
export STACK_NAME ?= aws-ecr-repo-generator-$(BUILDKITE_BRANCH)

clean:
	-rf cloudformation/deploy.yaml

validate:
	scripts/generate_cfn_template.sh repo-name
	aws cloudformation validate-template --region ap-southeast-2 --template-body file://cloudformation/deploy.yaml

deploy:
	scripts/create_or_update_stack.sh $(STACK_NAME) cloudformation/deploy.yaml cloudformation/params.json
