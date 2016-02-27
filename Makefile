# Add new repositories in REPOS variable

IOTLAB_REPOS = iot-lab.wiki contiki wsn430 openlab cli-tools aggregation-tools
IOTLAB_REPOS += contiki-upstream-unstable
IOTLAB_REPOS += oml-plot-tools
EXTERN_REPOS = riot
EXTERN_REPOS += contiki-dinas-iotlab
REPOS = $(IOTLAB_REPOS) $(EXTERN_REPOS)

SETUP_REPOS = $(sort $(addprefix setup-, $(REPOS)))

help:
	@printf "\nWelcome to the IoT-LAB development environment setup.\n\n"
	@printf "targets:\n"
	@for setup_cmd in $(SETUP_REPOS); do \
		printf "\t$${setup_cmd}\n";    \
	done
	@echo  ""
	@printf "\tpull\n"
	@echo  ""
all: $(addprefix setup-, $(REPOS))



ifdef GITHUB_GIT
GITHUB_URL = git@github.com:
else
GITHUB_URL = https://github.com/
endif


# External repositories
setup-riot: parts/RIOT
parts/RIOT:
	git clone $(GITHUB_URL)RIOT-OS/RIOT.git $@

setup-contiki-dinas-iotlab: parts/contiki-dinas-iotlab
parts/contiki-dinas-iotlab:
   git clone $(GITHUB_URL)bobib22/contiki-dinas-iotlab $@ 
   cd $@;\




# IoT-Lab repositories
$(addprefix setup-, $(IOTLAB_REPOS)): setup-%: parts/%
parts/%:
	git clone $(GITHUB_URL)iot-lab/$*.git $@


# print documentation on release
setup-wsn430: parts/wsn430
	cat parts/wsn430/README.md
setup-openlab: parts/openlab
	cat parts/openlab/README-IoT-LAB.md
setup-contiki: parts/contiki parts/openlab
	cat parts/contiki/README-IoT-LAB.md



# Pull in new changes
pull: $(subst parts/,pull-,$(wildcard parts/*))
	git pull
pull-%: parts/%
	cd $^; git pull; cd -


#
# Run tests
#
tests: openlab-tests contiki-tests wsn430-tests tools_and_scripts__tests
tools_and_scripts__tests:
	bash tools_and_scripts/tests/run_tests.sh
%-tests: parts/%
	make -C $^ -f iotlab.makefile tests

tests-clean: openlab-tests-clean contiki-tests-clean wsn430-tests
%-tests-clean: parts/%
	make -C $^ -f iotlab.makefile clean




.PHONY: help setup-% pull pull-% tests tests-%
.PRECIOUS: parts/%
