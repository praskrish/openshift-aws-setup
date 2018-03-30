#!/usr/bin/env bash
export ANSIBLE_HOST_KEY_CHECKING=False
if [ $1 = "origin" ]; then
    # Origin
    ansible-playbook -i ~{{amazon_user}}/openshift_inventory.cfg ~{{amazon_user}}/openshift-ansible/playbooks/byo/config.yml
else
    # Enterprise
{% if ocp_version|float <= 3.7  %}
    ansible-playbook -i ~{{amazon_user}}/openshift_inventory.cfg /usr/share/ansible/openshift-ansible/playbooks/byo/config.yml
{% else %}
    ansible-playbook -i ~{{amazon_user}}/openshift_inventory.cfg /usr/share/ansible/openshift-ansible/playbooks/prerequisites.yml
    ansible-playbook -i ~{{amazon_user}}/openshift_inventory.cfg /usr/share/ansible/openshift-ansible/playbooks/deploy_cluster.yml
{% endif %}
fi