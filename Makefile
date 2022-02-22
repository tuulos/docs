help:
	cat Makefile

test:
	nbdoc_test

watch:
	watchmedo shell-command --command nbdoc_build --pattern="*.ipynb" --recursive --drop

docs: .FORCE
	npm run start

nb: .FORCE
	jupyter lab docs

install: .FORCE
	npm install -g npm@">=8.4.1"
	npm install --global yarn
	yarn
	pip install -Ur requirements.txt

readme: .FORCE
	cp docs/intro.md README.md

.FORCE: