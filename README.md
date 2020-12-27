# Develop on remote machine


ssh copy id

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
sshfs gpu1:/ ~/gpu1 -ovolname=gpu1
```