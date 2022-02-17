help:
	cat Makefile

test:
	nbdoc_test

watch:
	watchmedo shell-command --command nbdoc_build --pattern="*.ipynb" --recursive --drop

docs: .FORCE
	docker-compose down --remove-orphans || true;
	docker-compose up

nb: .FORCE
	jupyter lab docs

install: .FORCE
	npm install --global yarn
	yarn
	pip install -r requirements.txt

readme: .FORCE
	cp docs/intro.md README.md

.FORCE: