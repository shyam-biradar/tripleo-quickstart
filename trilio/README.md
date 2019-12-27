
### STEPS ON ANSIBLE_SERVER:
1. create 'deployer' user on ansible server

useradd deployer

3. Enable passwordless sudo access to 'deployer'  user

echo "deployer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/deployer


4. login to deployer user

su - deployer

3. Create ssh keys under deployer user 

ssh-keygen -t rsa

4. Key based ssh for root@VIRTHOST

ssh-copy-id root@$VIRTHOST

ssh root@VIRTHOST uname- a

5. Install dependecies

bash quickstart.sh --install-deps

### STEPS ON VIRTHOST:

1. Install Centos7 or RHEL7

2. Make sure exact following entry available in /etc/fstab file

devpts /dev/pts devpts gid=5,mode=620 0 0


