#!/bin/bash
# svennd.be
# script will keep a simple md5 hash of all files
# and annoy when stuff is changed.

# check if its a directory
if [ -d "$1" ]; then

        # create md5 of dirname
        CHECK_FILE=/opt/trip/$(printf '%s' $1 | sha256sum | cut -d ' ' -f 1).md5

        # report size
        echo -n "directory size : "
        du -hs $1

        # check if there is a run before
        if [ -f $CHECK_FILE ]; then
                echo "Base line found checking mode!";

                # check howmuch files where here last time
                COUNT_FILE=$(wc -l $CHECK_FILE | cut -d ' ' -f 1)
                COUNT_CURRENT_FILE=$(find $1 -type f | wc -l)

                if [ "$COUNT_FILE" == "$COUNT_CURRENT_FILE" ]; then
                        echo "File count ok.";
                else
                        echo "Different amount of files, remove $CHECK_FILE";
                fi

                # validate OK
                NOT_OK=$(md5sum -c $CHECK_FILE 2>/dev/null | grep -v "OK")

                # if its empty its fine
                if [ -z "$NOT_OK" ]; then
                        echo "checksum validated.";
                else
                        #uh-oh
                        echo -e "\e[41m!!!!Found different checksum value's please validate these files :\e[0m";
                        echo $NOT_OK;
                        echo -e "\e[92mreset the baseline : rm -f $CHECK_FILE && /opt/trigger.sh $1\e[0m"
                fi
        else
                # improve : check if its not empty dir
                echo "No base line found, creating one now";
                find $1 -type f -exec md5sum {} \; | sort -k 2 > $CHECK_FILE
        fi

else
        echo "usage : ./test.sh DIR"
fi
