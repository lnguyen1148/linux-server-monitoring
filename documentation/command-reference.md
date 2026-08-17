# Command Reference


## Remote Server Access


### SSH


Connect to the Ubuntu EC2 instance.

```bash
ssh -i /path/to/private-key.pem ubuntu@EEC2_PUBLIC_IP
```


## Project Directories

Create the monitoring project folders on EC2.

```bash
mkdir -p ~/linux-server-monitoring/scripts
mkdir -p ~/linux-server-monitoring/reports
```


## Bash Script Management


Check a script for syntax errors.

```bash
bash -n scripts/monitor.sh
```

Make the script executable.

```bash
chmod +x scripts/monitor.sh
```

Run the script.

```bash
./scripts/monitor.sh
```


## Report Inspection


List generated reports.

```bash
ls -lt reports
```

Display the newest report.

```bash
cat "$(ls -t reports/monitoring-report-*.txt | head -n 1)"
```


## Secure File Transfer


Copy the tested monitoring script from EC2 to the local repository.

```bash
scp -i /path/to/private-key.pem ubuntu@EC2_PUBLIC_IP:home/ubuntu/linux-server-monitoring/scripts/monitor.sh scripts/monitor.sh
```


## CPU Monitoring


Display system load averages.

```bash
uptime
```

List running processes sorted by CPU usage.

```bash
ps aux --sort=-%cpu
```

Display the first highest CPU-consuming processes.

```bash
ps aux --sort=-%cpu | head -n 6
```


## Memory Monitoring


Display memory usage.

```bash
free -h
```


Display the processes using the most memory.

```bash
ps aux --sort=-%mem | head -n 6
```
 
Validate the newest generated monitoring report.

```bash
REPORT_FILE="$(ls -t reports/monitoring-report-*.txt | head -n 1)"
bash scripts/validate-report.sh "$REPORT_FILE"
```

Display the exit status of the previous command.

```bash
echo $?
```


## Linux Service Validation

Display detailed information about a systemd service.

```bash
systemctl status ssh --no-pager
```

Check whether a service is currently active.

```bash
systemctl is-active ssh
```

Check a service silently and use only its exit status.

```bash
systemctl is-active --quiet nginx
```

Display failed systemd services.

```bash
systemctl --failed
```


## Command Availability

Check whether a command is available to the shell.

```bash
command -v aws
```

Suppress normal and error output when only the command's exit status is needed.

```bash
command -v aws >/dev/null 2>&1
```


## Network Validation

Resolve a hostname using the system name-service configuration.

```bash
getent hosts github.com
```

Display address information for a hostname.

```bash
getent ahosts github.com
```

Test outbound HTTPS connectivity with a timeout.

```bash
curl -fsS --max-time 10 https://github.com >/dev/null
```


## AWS Identity Validation

Verify the AWS identity available to the EC2 instance.

```bash
aws sts get-caller-identity
```

Run the identity check silently when only success or failure is needed.

```bash
aws sts get-caller-identity >/dev/null 2>&1
```


## Bash Debugging

Run a Bash script in trace mode to display commands as they are executed.

```bash
bash -x scripts/infrastructure-check.sh
```


