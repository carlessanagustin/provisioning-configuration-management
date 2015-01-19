ansible-best-practices
======================

Ansible default folder structure from http://docs.ansible.com/playbooks_best_practices.html

Examples:

Now what sort of use cases does this layout enable? Lots! If I want to reconfigure my whole infrastructure, it’s just:

* ansible-playbook -i production site.yml

What about just reconfiguring NTP on everything? Easy.:

* ansible-playbook -i production site.yml --tags ntp

What about just reconfiguring my webservers?:

* ansible-playbook -i production webservers.yml

What about just my webservers in Boston?:

* ansible-playbook -i production webservers.yml --limit boston

What about just the first 10, and then the next 10?:

* ansible-playbook -i production webservers.yml --limit boston[0-10]
* ansible-playbook -i production webservers.yml --limit boston[10-20]

And of course just basic ad-hoc stuff is also possible.:

* ansible boston -i production -m ping
* ansible boston -i production -m command -a '/sbin/reboot'

Continue: https://github.com/ansible/ansible-examples
