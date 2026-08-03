#!/bin/bash

set -u

REPORT_DIR="$HOME/linux-server-monitoring/reports"
TIMESTAMP="$(date '+%Y-%m-%d_%H-%M-%S')"
REPORT_FILE="$REPORT_DIR/monitoring-report-$TIMESTAMP.txt"

mkdir -p "$REPORT_DIR"

{
	echo "Linux Server Monitoring Report"
	echo "=============================="
	echo

	echo "Generated"
	echo "---------"
	date '+%Y-%m-%d %H:%M:%S %Z'
	echo

	echo "Hostname"
	echo "--------"
	hostname
	echo

	echo "Operating System"
	echo "----------------"
	grep PRETTY_NAME /etc/os-release
	echo

	echo "System Uptime"
	echo "-------------"
	uptime -p
	echo

	echo "Memory Usage"
	echo "------------"
	free -h
	echo

	echo "Disk Usage"
	echo "----------"
	df -h /
	echo

} > "$REPORT_FILE"

echo "Monitoring report created:"
echo "$REPORT_FILE"
