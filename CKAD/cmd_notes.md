**Every 5 seconds, this container should write the current date along with greeting message Hi I am from Sidecar container to index.html**

`command: ['sh', '-c', 'while true; do echo "$(date) Hi I am from Sidecar container" >> /var/log/index.html; sleep 5; done']`

(or)

```
command:
    - /bin/sh
    - -c
    - while true; do echo $(date -u) Hi I am from Sidecar container >> /var/log/index.html; sleep 5; done
```

====

`k run roach --image=busybox -- /bin/sh -c 'echo "roach"; sleep 1000'`


```
command:
    - /bin/sh
    - -c
    - ps -eaf

```

or

`k run aaric --image=alpine -- /bin/sh -c 'ps -eaf'`


` command: ["perl", "-Mbignum=bpi", "-wle", "print bpi(1024)"]`
