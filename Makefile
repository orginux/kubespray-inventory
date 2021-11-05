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

vagrant-up:
	@source venv/bin/activate && vagrant up
	@mv -f ${HOME}/.kube/config ${HOME}/.kube/config-old || true
	cp -v inventory/lab/artifacts/admin.conf ${HOME}/.kube/config

vagrant-upgrade:
	ansible-playbook -i .vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory --become cluster.yml

vagrant-reinstall: vagrant-destroy vagrant-up
