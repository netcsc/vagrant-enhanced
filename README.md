[//]: # ( -*- mode: auto-fill; mode: markdown; -*- )
[//]: # ( vim: set ai syntax=markdown tw=75: )

# Vagrant Sandbox 

Vagrant is used to create an environment configured with Ansible and 
Git to provide you with a sandbox environment to test Ansible for instance.

The setup includes 2 VMs set up to communicate through SSH with one another
through a virtual interface. The VMs are named `ctrlvm` and `targetvm` and
come pre-installed with:
- ansible 2.4.3.0
- git 1.8.3.1

The `ctrlvm` and `targetvm` VM's are also configured to have access to the
`ctrl_share` and `target_share` subfolders on your local filesystem. These are
the folders that you can use as your workspace for the files you'd like to
read/write from both the host (your machine) as well as the guest (`ctrlvm` or
`targetvm`).

## Notes On git version differences

*BEWARE*: The git version installed on this sandbox is `1.8.3.1`, which
differs from the current GA release (2.x).  This version is the default
version available on CentOS via yum and is likely the version you will come
across on Red Hat Linux server environments.

For the most part, differences are around how defaults are treated and git
otherwise functions as intended.  The most relevant differences are:

* In git 2.x, `git push` run without arguments defaults to the current branch
  you're working with, assuming it has been linked with an up-stream branch.
* In git 2.x, `git add path` now equates to `git add -A path`

See https://www.atlassian.com/blog/archives/happened-git-2-0-full-goodies for
a more detailed explanation of changes introduced as part of the 2.0 release.

## Installation and Setup 
### Software requirements

1. [Git Bash](https://git-scm.com/download/win).
2. [Vagrant >= 2.0.0](https://releases.hashicorp.com/vagrant/).
3. [VirtualBox 5.2.0 or later](https://www.virtualbox.org/wiki/Downloads).

### Initial setup

1. Go to directory and run `vagrant up` to boot up your machine.
3. After the box is booted, run `vagrant ssh` to ssh into ctrlvm (the control
   machine)

### Upgrading

1. Run `vagrant destroy -f`
    - This destroys your box, but not the contents of the shared folders 
2. Run `git pull`
3. Run `vagrant box update`
4. Run `vagrant box prune`
5. Run `vagrant up`

## Usage Notes

* When creating your Ansible inventory, you can refer to the targetvm simply
  as "targetvm".  Inside of the control VM (ctrlvm) this will resolve properly
  to the second machine.
* The `ctrl_share` folder is shared inside of ctrlvm as `/home/vagrant/share`
* The `target_share` folder is shared inside of targetvm as
  `/home/vagrant/share`

## Extras

### Proxy

To set that proxy up, run the following commands as the `vagrant` user once
you log in:

```
~/tools/enable_proxy.sh
source ~/.bashrc
```

### Websphere

To install websphere 8.5.5.5

```
~/tools/install_websphere.sh
``` 

### Ansible

On the `ctrlvm` box, you may want to pin ansible to a specific version.

```
Usage: ~/tools/install_ansible.sh [ansible_version]

Examples:
# Latest version of Ansible:
~/tools/install_ansible.sh

# Install 2.2.1.0, specifically.
~/tools/install_ansible.sh 2.2.1.0

```
