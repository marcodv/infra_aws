#!/bin/bash
sudo yum install -y kubectl gcc
wget http://download.redis.io/redis-stable.tar.gz && tar xvzf redis-stable.tar.gz && cd redis-stable && make
sudo cp src/redis-cli /usr/bin/
sudo amazon-linux-extras install postgresql10 -y
pip3 install ansible psycopg2-binary

cat > /home/ec2-user/create_postgres_users_db.yaml << __EOF__
---
- hosts: "db_name_to_connect"
  remote_user: add_user_here
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
      port: 
      state: present
      login_host: db_name_to_connect
      login_user: "add_user_here"
      login_password: "add_password"
    delegate_to: 127.0.0.1
    with_items:
    - list_db

  - name: Create DB user
    postgresql_user:
      login_host: db_name_to_connect
      login_user: "add_user_here"
      login_password: "add_password"
      port: 
      db: "{{ item.db_name }}"
      name: "{{ item.db_username }}"
      password:  "{{ item.db_password }}"
      priv: "ALL/ALL"
      role_attr_flags: "CREATEDB,LOGIN"
    delegate_to: 127.0.0.1
    with_items:
    - {db_name: '', db_username: '', db_password: ''}
    - {db_name: '', db_username: '', db_password: ''}
    - {db_name: '', db_username: '', db_password: ''}

  - name: Assign db created to users
    postgresql_owner:
      login_host: db_name_to_connect
      login_user: "add_user_here"
      login_password: "add_password"
      port: 
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
      login_host: db_name_to_connect
      login_user: "add_user_here"
      login_password: "add_password"
      port:
      database: "{{ item.db_name }}"
      role: "{{ item.db_username }}"
      type: database
      privs: ALL
    delegate_to: 127.0.0.1
    with_items:
    - {db_name: '', db_username: ''}
    - {db_name: '', db_username: ''}
    - {db_name: '', db_username: ''}

  # the list need to be of 6 elements
  - name: Revoke ALL PRIVILEGES from users in order to not access to db
    postgresql_privs:
      login_host: db_name_to_connect
      login_user: "add_user_here"
      login_password: "add_password"
      port:
      db: "{{ item.db_name }}"
      role: "{{ item.db_username }}"
      type: database
      state: absent
      grant_option: no
      priv: ALL
    delegate_to: 127.0.0.1
    with_items:
    - {db_name: '', db_username: ''}
    - {db_name: '', db_username: ''}
    - {db_name: '', db_username: ''}

  - name: Revoke PUBLIC for all the DB
    postgresql_privs:
      login_host: db_name_to_connect
      login_user: "add_user_here"
      login_password: "add_password"
      port:
      db: "{{ item }}"
      type: database
      state: absent
      grant_option: no
      priv: ALL
      role: public
    delegate_to: 127.0.0.1
    with_items:
    - list_db
__EOF__

