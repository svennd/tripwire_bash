# tripwire_bash
Simple bash tripwire, idea based on [binsnitch](https://github.com/NVISO-BE/binsnitch). 
Use it to monitor for changes in a certain directory. Based of a baseline file.
 
## requirements
- bash
- md5sum (this can be changed to sha256 fairly simple)

## usage
```
cd /opt
git clone https://github.com/svennd/tripwire_bash
mkdir -p /opt/trip
```

Add cron : (run once a day, at 00:00)
```
EDITOR=nano crontab -e
0 0 * * * /opt/trigger.sh /my/dir/to/check
```

By default the script cannot alert you. I Like to use [postToRocket](https://www.svennd.be/post-message-to-rocket-chat-from-bash/)
