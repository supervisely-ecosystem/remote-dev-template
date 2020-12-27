# remote-dev-template



## 1. Clone template repository
git clone https://github.com/mkolomeychenko/remote-dev-template

Result dir on my remote machine: `~/max/remote-dev-template`

## 2. Copy your SSH public key 

hint: scp <source> <destination>
`scp ~/.ssh/id_rsa.pub gpu1:~/max/remote-dev-template/id_rsa.pub`

## 3. Run docker container
- change dockerimage in template
- run container


## Browse files on remote server
https://apple.stackexchange.com/questions/5209/how-can-i-mount-sftp-ssh-in-finder-on-os-x-snow-leopard

```
brew install osxfuse
brew install sshfs
sshfs gpu1:/ ~/gpu1 -ovolname=gpu1
```


## Run container on remote machine
https://www.dontpanicblog.co.uk/2018/11/30/ssh-into-a-docker-container/

```
cd ~/max/remote-dev-template
./dev.sh
```




```
https://linuxize.com/post/how-to-setup-ssh-tunneling/#remote-port-forwarding
ssh -L 3336:db001.host:3306 user@pub001.host
sudo sshfs -o allow_other,default_permissions,IdentityFile=~/.ssh/id_rsa gpu1:/ ~/gpu1
```







./dev.sh
ssh sshuser@localhost -p 7777 -i ~/.ssh/id_rsa.pub