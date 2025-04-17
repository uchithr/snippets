#!/bin/bash

# SYSTEM PERFORMANCE ANALYSIS
echo "==== TOP CPU-CONSUMING PROCESSES ===="
ps aux --sort=-%cpu | head
echo ""

# STRESS TEST (OPTIONAL - DISABLED BY DEFAULT)
# echo "==== RUNNING STRESS TEST ===="
# stress --cpu 2 --io 1 --vm 1 --vm-bytes 128M --timeout 10s

# NETWORK MONITORING
echo "==== NETWORK INTERFACE STATS ===="
ip -s link
echo ""

echo "==== ACTIVE CONNECTIONS ===="
ss -tunap
echo ""

# PING AND TRACEROUTE (REPLACE <server-ip>)
TARGET="8.8.8.8"
echo "==== PING TO $TARGET ===="
ping -c 4 $TARGET
echo ""

echo "==== TRACEROUTE TO $TARGET ===="
traceroute $TARGET
echo ""

# SERVICE STATUS
echo "==== APACHE2 SERVICE STATUS ===="
systemctl status apache2 --no-pager
echo ""

echo "==== APACHE2 PROCESSES ===="
ps aux | grep apache2
echo ""

# LOGS
echo "==== RECENT SYSTEM LOGS ===="
journalctl -xe -n 20
echo ""

echo "==== KERNEL LOGS ===="
dmesg | tail -n 20
echo ""

# MYSQL PROCESS LIST (ASSUMES PASSWORDLESS ACCESS OR .my.cnf CONFIGURED)
echo "==== MYSQL PROCESS LIST ===="
mysqladmin processlist 2>/dev/null || echo "MySQL not accessible."
echo ""

# CURL TEST
echo "==== CURL HTTP HEADERS ===="
curl -I http://your-server 2>/dev/null || echo "CURL FAILED. CHECK URL."
echo ""

# AB TEST (DISABLED BY DEFAULT)
# echo "==== APACHE BENCHMARK ===="
# ab -n 100 -c 10 http://your-server/


echo "==== TROUBLESHOOTING REPORT COMPLETE ===="



# chmod +x troubleshoot_report.sh
# ./troubleshoot_report.sh | tee troubleshoot_report.txt
#
#