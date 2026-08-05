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
 
