#!/bin/bash

set -u

REPORT_FILE="${1:-}"

if [[ -z "$REPORT_FILE"  ]]; then
	echo "Usage: $0 <report-file>"
	exit 2
fi

if [[ ! -f "$REPORT_FILE"  ]]; then
        echo "FAIL: Report not found: $	$REPORT_FILE"
        exit 1
fi

REQUIRED_SECTIONS=(
	"Linux Server Monitoring Report"
	"Generated"
	"Hostname"
	"Operating System"
	"System Uptime"
	"CPU Load"
	"Top 5 CPU Processes"
	"Top 5 Memory Processes"
	"Memory Usage"
	"Disk Usage"
)

for section in "${REQUIRED_SECTIONS[@]}"
do
	if ! grep -qF "$section" "$REPORT_FILE"; then
		echo "FAIL: Missing required section: $section"
		exit 1
	fi
done

echo "PASS: Monitoring report contains all required sections."
exit 0
