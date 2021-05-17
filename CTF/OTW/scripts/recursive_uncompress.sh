#!/bin/sh

NEW_TEMP_FOLDER_NAME=/tmp/$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)

mkdir $NEW_TEMP_FOLDER_NAME
xxd -r ~/data.txt $NEW_TEMP_FOLDER_NAME/data.gz
gzip -d $NEW_TEMP_FOLDER_NAME/data.gz
mv $NEW_TEMP_FOLDER_NAME/data $NEW_TEMP_FOLDER_NAME/data.bz2
bzip2 -d $NEW_TEMP_FOLDER_NAME/data.bz2
mv $NEW_TEMP_FOLDER_NAME/data $NEW_TEMP_FOLDER_NAME/data.gz
gzip -d $NEW_TEMP_FOLDER_NAME/data.gz
mv $NEW_TEMP_FOLDER_NAME/data $NEW_TEMP_FOLDER_NAME/data.tar
tar -xf $NEW_TEMP_FOLDER_NAME/data.tar -C $NEW_TEMP_FOLDER_NAME
mv $NEW_TEMP_FOLDER_NAME/data5.bin $NEW_TEMP_FOLDER_NAME/data5.bin.tar
tar -xf $NEW_TEMP_FOLDER_NAME/data5.bin.tar -C $NEW_TEMP_FOLDER_NAME
mv $NEW_TEMP_FOLDER_NAME/data6.bin $NEW_TEMP_FOLDER_NAME/data6.bz2
bzip2 -d $NEW_TEMP_FOLDER_NAME/data6.bz2
mv $NEW_TEMP_FOLDER_NAME/data6 $NEW_TEMP_FOLDER_NAME/data6.tar
tar -xf $NEW_TEMP_FOLDER_NAME/data6.tar -C $NEW_TEMP_FOLDER_NAME
mv $NEW_TEMP_FOLDER_NAME/data8.bin $NEW_TEMP_FOLDER_NAME/data8.gz
gzip -d $NEW_TEMP_FOLDER_NAME/data8.gz
cat $NEW_TEMP_FOLDER_NAME/data8
rm -rf $NEW_TEMP_FOLDER_NAME