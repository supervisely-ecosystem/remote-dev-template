# Develop on remote machine

You can debug your application using an interpreter that is located on the other computer, for example, on a web server or dedicated test machine. For example: you have laptop + server with GPU in the cloud and you want to develop apps to work with Neural Networks: train / inference / serve


## Create an SSH Shortcut (optional one-time step)

If you are constantly needing to SSH into multiple servers, it can real daunting to remember all the different usernames, hostnames, IP addresses, and even sometimes custom private keys to connect to them. It's actually extremely easy to create command line shortcuts to solve this problem. More info here: https://linuxize.com/post/using-the-ssh-config-file/

Edit SSH config:
```sh
nano ~/.ssh/config
```

Add Server Info to the end of file:

```
Host gpu1
     HostName XX.XXX.XXX.XX
     User root
```

In this example shortcut is `gpu1`. `HostName` - is an ip-address to your server.

## Set up public key authentication (optional one-time step)

ssh-copy-id installs an SSH key on a server as an authorized key. Its purpose is to provision access without requiring a password for each login. This facilitates automated, passwordless logins and single sign-on using the SSH protocol. More info here: https://www.ssh.com/ssh/copy-id


Check that you have SSH keys:
```sh
cat ~/.ssh/id_rsa.pub
```

If you see message `No such file or directory` then run following command to generate as SSH key:
```sh
ssh-keygen
```

Authorize you SSH key on remote server. I will need to enter remote server password
```
ssh-copy-id -i ~/.ssh/id_rsa gpu1
```

## Check SSH access

Now you can type `ssh gpu1` in terminal to connect to your remote server quickly.

<img src="https://i.imgur.com/8OZH2Xw.png"/>






add server to ssh config

ssh copy id

docker compose (how to use)


## 1. Clone template repository
git clone https://github.com/mkolomeychenko/remote-dev-template

Result dir on my remote machine: `~/max/remote-dev-template`

## 2. Copy your SSH public key to template project folder

hint: scp <source> <destination>
```
scp ~/.ssh/id_rsa.pub gpu1:~/max/remote-dev-template/id_rsa.pub
```

or for local development
`cp ~/.ssh/id_rsa.pub ~/max/remote-dev-template/id_rsa.pub`

## 3. Run docker container
- change dockerimage in dev.sh
- run container
```
cd ~/max/remote-dev-template && \
./dev.sh

```

backup link: https://www.dontpanicblog.co.uk/2018/11/30/ssh-into-a-docker-container/

## 4. SSH into container
`ssh sshuser@gpu1 -p 7777`

or

`ssh sshuser@localhost -p 7777 -i ~/.ssh/id_rsa.pub`


## Browse files on remote server
https://apple.stackexchange.com/questions/5209/how-can-i-mount-sftp-ssh-in-finder-on-os-x-snow-leopard

```
brew install osxfuse
brew install sshfs
sshfs gpu1:/root/max/remote-dev-template ~/gpu1 -ovolname=gpu1
```