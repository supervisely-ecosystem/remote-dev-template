# Develop on remote machine

You can debug your application using an interpreter that is located on the other computer, for example, on a web server or dedicated test machine. For example: you have laptop + server with GPU in the cloud and you want to develop apps to work with Neural Networks: train / inference / serve


## Configure SSH access to your remote server (optional one-time step)

### 1. Create an SSH Shortcut

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

### 2. Set up public key authentication

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

### 3. Check SSH access

Now you can type `ssh gpu1` in terminal to connect to your remote server quickly.

<img src="https://i.imgur.com/8OZH2Xw.png"/>


## Run docker container on remote machine

### Prerequisites

Be sure, that `[docker](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository)` and `[docker-compose](https://docs.docker.com/compose/install/)` are installed on your remote server


### 1. Clone template repository

On remote server: create working directory (for example: `~/tutorial`) and clone template repository:

```sh
mkdir -p ~/tutorial && \
cd  ~/tutorial && \
git clone https://github.com/supervisely-ecosystem/remote-dev-template
```

### 2. Copy your SSH public key to template project folder 

Copy public SSH key from your local computer to remote server by executing following command:

Example: 
```sh
scp ~/.ssh/id_rsa.pub <ssh shortcut>:<path to template project>/id_rsa.pub
```

For this tutotial the command is the following:
```sh
scp ~/.ssh/id_rsa.pub gpu1:~/tutorial/remote-dev-template/id_rsa.pub
```

### 3. Run docker container

backup link: https://www.dontpanicblog.co.uk/2018/11/30/ssh-into-a-docker-container/

Execute on remote machine:
```sh
cd ~/tutorial/remote-dev-template && \
docker-compose up -d --build
```

To list containers run:
```sh
docker-compose ps
```

To kill container:
```sh
docker-compose kill
```

### 4. SSH into container

Execute on local machine:

`ssh sshuser@gpu1 -p 7777`

Now you can SHH into container that is started on your remote server.


## TODO: Browse files on remote server
https://apple.stackexchange.com/questions/5209/how-can-i-mount-sftp-ssh-in-finder-on-os-x-snow-leopard

Install (MacOs):
```sh
brew install osxfuse
brew install sshfs
```

Run on your local computer: mount remote directory  `/root/tutorial/remote-dev-template` to local directory `~/remote-dir`:
```sh
sshfs gpu1:/root/tutorial/remote-dev-template ~/remote-dir -ovolname=remote-dir
```

to unmount:
```sh
umount -f ~/remote-dir
```

## Configure remote debug with PyCharm

With PyCharm you can debug your application using an interpreter that is located in docker container on remote server. This is a Professional feature: [download PyCharm Professional](https://www.jetbrains.com/pycharm/download) to try.

All steps in this section are performed on your local machine.

### 1. Clone repository with demo project

Run on you local machine:
```sh
cd ~ && \
git clone https://github.com/supervisely-ecosystem/while-true-script && \
cd ~/while-true-script
```

### 2. Run PyCharm Professional

Press `Open` button:
<img src="https://i.imgur.com/aHZWKfn.png"/>

Go to demo project's folder `~/while-true-script` (1) and press `Open` button (2):
<img src="https://i.imgur.com/i4G9uvH.png"/>

### 3. Configure Project Interpreter

Wait untill PyCharm suggest to configure interpreter. Press `Cancel` button (1):
<img src="https://i.imgur.com/bdctiMg.png"/>







