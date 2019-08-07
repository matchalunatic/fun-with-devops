all:
	rm -rf workdir
	rm -rf /tmp/foxint-git
	git clone https://github.com/Misterfoxapp/devops-test-foxintelligence.git /tmp/foxint-git
	mv /tmp/foxint-git/frontend workdir
	docker build -f ../Dockerfile.frontend --tag ${FOXAPP_FRONT_TAG} workdir
	docker push ${FOXAPP_FRONT_TAG}
	rm -rf workdir
