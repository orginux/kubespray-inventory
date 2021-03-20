mitogen:
	ansible-playbook -c local mitogen.yml -vv
clean:
	rm -rf dist/
	rm *.retry

venv:
	@virtualenv venv
	@venv/bin/pip install -r requirements.txt

vagrant-destroy:
	@vagrant destroy -f
	@rm -rf .vagrant/

vagrant-reinstall: vagrant-destroy vagrant-up
	@mv -f ${HOME}/.kube/config ${HOME}/.kube/config-old
	cp -v inventory/my_lab/artifacts/admin.conf ${HOME}/.kube/config

vagrant-up:
	@source venv/bin/activate && vagrant up
