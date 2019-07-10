all:
	rm -rf /tmp/foxint-git workdir
	git clone https://github.com/Misterfoxapp/devops-test-foxintelligence.git /tmp/foxint-git
	mv /tmp/foxint-git/backend workdir
	cp Gopkg.toml workdir/
	docker build -f ../Dockerfile.backend --tag devops-test-foxintelligence-backend:latest workdir
	rm -rf workdir
