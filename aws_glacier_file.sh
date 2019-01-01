#!/bin/bash -x
set -eo pipefail
if [[ $# -lt 3 ]]
then
	echo 'usage :
'$0' <vault-name> <contents-filename> <pattern>...' >&2
	exit 1 
fi
export VAULT=${1:?}
export CONTENTS_FILENAME="${2:?}.txt"
export CONTENTS_FILE="$HOME/Private/aws/glacier/$CONTENTS_FILENAME"
shift 2

for f in "$@" 
do
	FILENAME=${f##*/}
	echo $FILENAME >> $CONTENTS_FILE || exit 1
	aws --region=eu-west-1 glacier upload-archive --account-id - --vault-name $VAULT --archive-description $FILENAME --body $f  >> $CONTENTS_FILE || exit $?
done

aws s3 cp "$CONTENTS_FILE" "s3://stelios-bucket/vaults/backup/$CONTENTS_FILENAME" 
