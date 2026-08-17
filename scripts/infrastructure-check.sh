#!/bin/bash

set -u

FAILURES=0
CHECKS=0

pass() {
	echo "PASS: $1"
}

fail() {
	echo "FAIL: $1"
	FAILURES=$((FAILURES + 1))
}

check_command() {
	local command_name="$1"

	CHECKS=$((CHECKS + 1))

	if command -v "$command_name" >/dev/null 2>&1; then
		pass "Required command available: $command_name"
	else
		fail "Required command missing: $command_name"
	fi
}

check_service() {
	local service_name="$1"

	CHECKS=$((CHECKS + 1))

	if systemctl is-active --quiet "$service_name"; then
		pass "Service active: $service_name"
	else
		fail "Service inactive: $service_name"
	fi
}

echo "Linux Infrastructure Validation"
echo "==============================="
echo

echo "Operating System"
echo "----------------"

CHECKS=$((CHECKS + 1))

if [[ "$(uname -s)" == "Linux" ]]; then
	pass "Linux operating system detected"
else
	fail "Linux operating system not detected"
fi

echo

echo "Required Commands"
echo "-----------------"

check_command bash
check_command curl
check_command aws
check_command systemctl

echo

echo "Service Validation"
echo "------------------"

check_service ssh
check_service nginx

echo

echo "Network Validation"
echo "------------------"

CHECKS=$((CHECKS + 1))

if getent hosts github.com >/dev/null 2>&1; then
	pass "DNS resolution successful"
else
	fail "DNS resolution failed"
fi

CHECKS=$((CHECKS + 1))

if curl -fsS --max-time 10 https://github.com >/dev/null; then
	pass "Outbound HTTPS connectivity successful"
else
	fail "Outbound HTTPS connectivity failed"
fi

echo

echo "AWS Identity Validation"
echo "-----------------------"

CHECKS=$((CHECKS + 1))

if aws sts get-caller-identity >/dev/null 2>&1; then
	pass "AWS identity successfully verified"
else
	fail "AWS identity verification failed"
fi

echo

echo "Validation Summary"
echo "------------------"
echo "Checks performed: $CHECKS"
echo "Checks failed: $FAILURES"

echo

if (( FAILURES == 0 )); then
	echo "OVERALL RESULT: PASS"
	exit 0
else
	echo "OVERALL RESULT: FAIL"
	exit 1
fi













