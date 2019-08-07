all:
	rm -rf /tmp/foxint-git workdir
	git clone https://github.com/Misterfoxapp/devops-test-foxintelligence.git /tmp/foxint-git
	mv /tmp/foxint-git/backend workdir
	cp Gopkg.toml workdir/
	docker build -f ../Dockerfile.backend --tag ${FOXAPP_BACK_TAG} workdir
	docker push ${FOXAPP_BACK_TAG}
	rm -rf workdir
