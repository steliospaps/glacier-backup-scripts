# glacier-backup-scripts
## purpose
These are the scripts I use for backing up to glacier. They assume that the environment allows access (glacier all, s3 all)

I use dropbox, but that exposes me to accidental or malitious deletion (by agents that have my password), malitious encryption by ransom-ware, or a dropbox failure followed by hardware failure on my side.

I checkout dropbox on a headless aws server (or one of my local ones if I have enough space)

I then tar (level-0 archive) split into 4G items that I then Bzip.

I also upload a catalogue, and a list of items.

WARNING: 
I have not recovered from this yest, and I have not created a level1 backup
