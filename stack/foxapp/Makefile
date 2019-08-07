back:
	$(MAKE) -C backend

front:
	$(MAKE) -C frontend

bundle:
	docker-compose bundle
	cp foxapp.dab ../stacks/

all: front back bundle
