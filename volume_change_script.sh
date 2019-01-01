#!/bin/bash
# will expect an archive of the form xxxx.001.xxx
# example:
# tar cvf stelios.backups.helena.SERIAL.tar -M -L4G -F ~/bin/volume_change_script.sh -C ~/Dropbox stelios/backups/helena
#enable extended patterns
#shopt -s extglob

echo TAR_ARCHIVE=$TAR_ARCHIVE
echo TAR_FD=$TAR_FD
echo TAR_VOLUME=$TAR_VOLUME
NUMBER=$(printf "%03d" $TAR_VOLUME)
echo NUMBER=$NUMBER
NAME=${TAR_ARCHIVE/.[0-9][0-9][0-9]./.$NUMBER.}
echo NAME=$NAME
echo ${NAME} >&$TAR_FD
#bzip2 $TAR_ARCHIVE 
gzip $TAR_ARCHIVE 

