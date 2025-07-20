**Create a cronjob called dice that runs every one minute. Use the Pod template located at /root/throw-a-dice. The image throw-dice randomly returns a value between 1 and 6. The result of 6 is considered success and all others are failure.**

* The job should be non-parallel and complete the task once. Use a backoffLimit of 25.

* If the task is not completed within 20 seconds the job should fail and pods should be terminated.


* You don't have to wait for the job completion. As long as the cronjob has been created as per the requirements.

```
apiVersion: batch/v1
kind: CronJob
metadata:
  name: dice
spec:
  schedule: "*/1 * * * *"
  jobTemplate:
    spec:
      completions: 1
      backoffLimit: 25 # This is so the job does not quit before it succeeds.
      activeDeadlineSeconds: 20
      template:
        spec:
          containers:
          - name: dice
            image: kodekloud/throw-dice
          restartPolicy: Never

```
============

**In the ckad-job namespace, create a job named very-long-pi that simply computes a π (pi) to 1024 places and prints it out.**

* This job should be configured to retry maximum 5 times before marking this job failed, and the duration of this job should not exceed 100 seconds.

* The job should use the container image perl:5.34.0.

* The container should run a Perl command that calculates π (pi) to 1024 decimal places using: `perl -Mbignum=bpi -wle 'print bpi(1024)'`


```
apiVersion: batch/v1
kind: Job
metadata:
  name: very-long-pi
  namespace: ckad-job
spec:
  backoffLimit: 5
  activeDeadlineSeconds: 100
  template:
    spec:
      containers:
      - name: pi
        image: perl:5.34.0
        command: ["perl", "-Mbignum=bpi", "-wle", "print bpi(1024)"]
      restartPolicy: Never


```
===========