# Commands: ansible-playbook
 
ansible-playbook install.yml -i hosts/all -l aws -u ubuntu -t base,kibana --private-key=/Users/carles/.ssh/elk.pem

ansible-playbook install.yml -i hosts/aws -l aws-jenkins-ci -u ubuntu -t logstash-forwarder --private-key=/Users/carles/.ssh/jenkins-ci.pem

# Review Options

--list-tasks --list-hosts -vvvv

# Security Options

--ask-vault-pass
