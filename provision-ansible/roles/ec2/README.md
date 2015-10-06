# Role Name

This role creates, terminates, starts or stops instances in Amazon Web Services EC2.

## Requirements

* python >= 2.6
* ansible
* boto
* awscli

        $ pip install ____

## Role Variables

Change if needed:

* playbook.yml
* defaults/main.yml
* vars/main.yml vars.

## Dependencies

No dependencies at present.

## Example ansible-playbook command

### CREATE
    $ ansible-playbook ec2-instance.yml -i hosts/ec2-aws --ask-vault-pass --tags=C -vvvv --list-tasks --list-hosts
    $ ansible-playbook ec2-create-instance.yml -i hosts/ec2-aws --ask-vault-pass --tags=C -vvvv --list-tasks --list-hosts

### READ
    $ ansible-playbook ec2-instance.yml -i hosts/ec2-aws --ask-vault-pass --tags=R -vvvv --list-tasks --list-hosts
    $ ansible-playbook ec2-get_info.yml -i hosts/ec2-aws --ask-vault-pass  -vvvv
    $ ansible-playbook ec2-role.yml -i hosts/ec2-aws --ask-vault-pass --tags=R
    
### DELETE
    $ ansible-playbook ec2-instance.yml -i hosts/ec2-aws --ask-vault-pass --tags=D --extra-vars "var_instance_ids=i-628470b6,i-638470b7" -vvvv --list-tasks --list-hosts

### STOP
    $ ansible-playbook ec2-instance.yml -i hosts/ec2-aws --ask-vault-pass --tags=Ustop -vvvv --list-tasks --list-hosts
    
### START
    $ ansible-playbook ec2-instance.yml -i hosts/ec2-aws --ask-vault-pass --tags=Ustart -vvvv --list-tasks --list-hosts

> extra:
> --list-tasks --list-hosts
> --tags=C
> --skip-tags=vagrant
> --private-key=/Users/carles/.ssh/testing-env.pem
> --extra-vars "var_instance_ids=i-b949636c"
> --syntax-check

## Example Playbook

    - name: Create a sandbox instance
      hosts: localhost
      gather_facts: False
      vars:
        key_name: my_keypair
        instance_type: m1.small
        security_group: my_securitygroup
        image: my_ami_id
        region: us-east-1
      tasks:
        - name: Launch instance
          ec2:
            key_name: "{{ keypair }}"
            group: "{{ security_group }}"
            instance_type: "{{ instance_type }}"
            image: "{{ image }}"
            wait: true
            region: "{{ region }}"
            vpc_subnet_id: subnet-29e63245
            assign_public_ip: yes
            register: ec2
        - name: Add new instance to host group
          add_host: hostname={{ item.public_ip }} groupname=launched
          with_items: ec2.instances
        - name: Wait for SSH to come up
          wait_for: host={{ item.public_dns_name }} port=22 delay=60 timeout=320 state=started
          with_items: ec2.instances

[ec2 - create, terminate, start or stop an instance in ec2](http://docs.ansible.com/ansible/ec2_module.html)

## Example Dynamic Inventory

    $ ansible all -i ec2.py --private-key=/Users/carles/.ssh/testing-env.pem -u ubuntu -m ping
    $ ansible all -i ec2.py --private-key=/Users/carles/.ssh/testing-env.pem -u ubuntu -m ec2_facts 
    
    $ ansible my_target_machine -i ec2.py --private-key=/Users/carles/.ssh/testing-env.pem -u ubuntu -m ec2_facts 

    $ ./ec2.py --refresh-cache
    $ ./ec2.py --host HOST
    
[Dynamic Inventory](http://docs.ansible.com/ansible/intro_dynamic_inventory.html)

## License

BSD

## Author Information

Carles San Agustin <info@carlessanagustin.com>
