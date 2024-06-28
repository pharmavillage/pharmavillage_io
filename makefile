TEST_FILES=$(shell find test -name '*.rb')

test:
	test -x pharmavillage-doc || git clone https://github.com/pharmavillage/documentation
	cutest $(TEST_FILES)

deploy:
	cd /srv/pharmavillage-doc && git pull
	cd /srv/pharmavillage-io  && git stash && git pull
	# bash --login -c "cd /srv/pharmavillage-io && rvm use 2.7.0 &&PHARMAVILLAGE_DOC=/srv/pharmavillage-doc /srv/pharmavillage-io/scripts/generate_interactive_commands.rb > /srv/pharmavillage-io/lib/interactive/commands.rb"
	service pharmavillage-io-app restart

.PHONY: deploy test
