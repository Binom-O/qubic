#!/bin/bash

echo "deb http://cz.archive.ubuntu.com/ubuntu jammy main" >> /etc/apt/sources.list
apt update
apt install libc6 -y
cd /root
mkdir qubic
cd qubic
wget https://dl.qubic.li/downloads/qli-Client-1.8.8-Linux-x64.tar.gz
tar xvzf qli-Client-1.8.8-Linux-x64.tar.gz
source /hive-config/rig.conf

cat <<EOF > appsettings.json
{
  "Settings": {
    "overwrites": {"CUDA": "12"},
    "allowHwInfoCollect": true,
    "baseUrl": "https://mine.qubic.li/",
    "amountOfThreads": 1,
    "payoutId": null,
    "accessToken":"eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJJZCI6ImQ0MGMwOWE0LWQzYTUtNDc4Ni05YzRhLTJjNGM2OTYxZWMxMCIsIk1pbmluZyI6IiIsIm5iZiI6MTcxMDMzNzYzMCwiZXhwIjoxNzQxODczNjMwLCJpYXQiOjE3MTAzMzc2MzAsImlzcyI6Imh0dHBzOi8vcXViaWMubGkvIiwiYXVkIjoiaHR0cHM6Ly9xdWJpYy5saS8ifQ.M0LReOH6-tu_fxo22ctvccgm_ZMWSkBv_ydgDtVUNm6ljfkfpgYjEV5s_T0MitzzOM145WrXlSFouC8EFF1DBA",
    "alias": "$WORKER_NAME"
  }
}
EOF

screen -L -Logfile /root/qubic/qub.log -dmS qubic /root/qubic/qli-Client
ldd --version
