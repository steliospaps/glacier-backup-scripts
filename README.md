# glacier-backup-scripts
## purpose
These are the scripts I use for backing up to glacier. They assume that the environment allows access (glacier all, s3 all)

I use dropbox, but that exposes me to accidental or malitious deletion (by agents that have my password), malitious encryption by ransom-ware, or a dropbox failure followed by hardware failure on my side.

I checkout dropbox on a headless aws server (or one of my local ones if I have enough space)

I then tar (level-0 archive) split into 4G items that I then Bzip.

I also upload a catalogue, and a list of items.

WARNING: 
I have not recovered from this yest, and I have not created a level1 backup
## in aws
create a box with an extra drive /dev/sdb
```
sudo mkfs.ext /dev/sdb
sudo mkdir /mnt/sdb
sudo mount /dev/sdb /mnt/sdb
sudo mkdir /mnt/sdb/Dropbox
sudo chown ec2-user:ec2-user /mnt/sdb/Dropbox
cd ~
wget -O dropbox.py https://www.dropbox.com/download?dl=packages/dropbox.py
HOME=/mnt/sdb/Dropbox/ ~/dropbox.py start -i

#check until the answer is synced
HOME=/mnt/sdb/Dropbox/ ~/dropbox.py status

#backup level0
tar cvf dropbox.lv0.2018-12-31.001.tar -M -L4G -F /mnt/sdb/Dropbox/glacier-backup-scripts/volume_change_script.sh -g dropbox.lv0.2018-12-31.incremental-file.snar --level=0 --no-check-device --label=Dropbox-level0 -C /mnt/sdb/Dropbox Dropbox
```