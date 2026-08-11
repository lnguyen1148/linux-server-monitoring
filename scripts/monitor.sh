#!/bin/bash

##########################################################
# Linux Server Monitoring Script
#
# Purpose:
#  Generate s system health report for the EC2 instance.
#
# Author:
#  Linh Nguyen
#
# Project:
#
#  Linux Server Monitoring & Automation
##########################################################

set -u

print_section() {
	local title="$1"

	echo "$title"
	printf '%*s\n' "${#title}" '' | tr ' ' '-'
}

REPORT_DIR="${REPORT_DIR:-$HOME/linux-server-monitoring/reports}"
TIMESTAMP="$(date '+%Y-%m-%d_%H-%M-%S')"
REPORT_FILE="$REPORT_DIR/monitoring-report-$TIMESTAMP.txt"

mkdir -p "$REPORT_DIR"

{
	echo "Linux Server Monitoring Report"
	echo "=============================="
	echo

	print_section "Generated"
	date '+%Y-%m-%d %H:%M:%S %Z'
	echo

	print_section "Hostname"
	hostname
	echo

	print_section "Operating System"
	grep PRETTY_NAME /etc/os-release
	echo

	print_section "System Uptime"
	uptime -p
	echo

	print_section "CPU Load"
	uptime
	echo

	print_section "Top 5 CPU Processes"
	ps aux --sort=-%cpu | head -n 6
	echo

	print_section "Memory Usage"
	free -h
	echo

	print_section "Top 5 Memory Processes"
	ps aux --sort=-%mem | head -n 6
	echo

	print_section "Disk Usage"
	df -h /
	echo

} > "$REPORT_FILE"

echo "Monitoring report created:"
echo "$REPORT_FILE"
