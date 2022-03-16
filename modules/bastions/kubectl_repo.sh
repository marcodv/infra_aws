#!/bin/bash
cat <<YUM_REPO | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
YUM_REPO
sudo yum install -y kubectl gcc
wget http://download.redis.io/redis-stable.tar.gz && tar xvzf redis-stable.tar.gz && cd redis-stable && make
sudo cp src/redis-cli /usr/bin/
sudo amazon-linux-extras install postgresql10 -y
pip3 install ansible psycopg2-binary

cat > /home/ec2-user/create_postgres_users_db.yaml << __EOF__
---
- hosts: "add_db_endpoint"
  remote_user: db_creation_user
  become: yes
  gather_facts: false

  tasks:
  - name: Make sure psycopg2-binary is installed
    pip:
      name: psycopg2-binary
      state: present
    delegate_to: 127.0.0.1

  - name: PostgreSQL | Make sure the PostgreSQL databases are present
    postgresql_db:
      name: "{{ item }}"
      encoding: 'UTF-8'
      lc_collate: 'en_US.UTF-8'
      lc_ctype: 'en_US.UTF-8'
      port: 5432
      state: present
      login_host: add_db_endpoint
      login_user: "db_creation_user"
      login_password: "db_creation_user_password"
    delegate_to: 127.0.0.1
    with_items:
    - prod_backend_db
    - dev_backend_db
    - staging_backend_db

  - name: Create DB user
    postgresql_user:
      login_host: add_db_endpoint
      login_user: "db_creation_user"
      login_password: "db_creation_user_password"
      port: 5432
      db: "{{ item.db_name }}"
      name: "{{ item.db_username }}"
      password:  "{{ item.db_password }}"
      role_attr_flags: CREATEDB,LOGIN
      priv: "ALL/ALL"
    delegate_to: 127.0.0.1
    with_items:
    - {db_name: '', db_username: '', db_password: ''}
    - {db_name: '', db_username: '', db_password: ''}
    - {db_name: '', db_username: '', db_password: ''}

  - name: Assign db created to users
    postgresql_owner:
      login_host: add_db_endpoint
      login_user: "db_creation_user"
      login_password: "db_creation_user_password"
      port: 5432
      db: "{{ item.db_name }}"
      new_owner: "{{ item.db_username }}"
      obj_type: database
      obj_name: "{{ item.db_name }}"
    delegate_to: 127.0.0.1
    with_items:
    - {db_name: '', db_username: ''}
    - {db_name: '', db_username: ''}
    - {db_name: '', db_username: ''}

  - name: Assign DB permission to users
    postgresql_privs:
      login_host: add_db_endpoint
      login_user: "db_creation_user"
      login_password: "db_creation_user_password"
      port: 5432
      database: "{{ item.db_name }}"
      role: "{{ item.db_username }}"
      type: database
      privs: ALL
    delegate_to: 127.0.0.1
    with_items:
    - {db_name: '', db_username: ''}
    - {db_name: '', db_username: ''}
    - {db_name: '', db_username: ''}
__EOF__

