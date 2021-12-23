#!/usr/bin/env bash

nvidia-settings -a "GPUFanControlState=1"
nvidia-settings -a "[fan:0]/GPUTargetFanSpeed=100"
nvidia-settings -a "[fan:1]/GPUTargetFanSpeed=100"
sudo nvidia-smi -i 0 -pm 1
sudo nvidia-smi -i 0 -pl 320
nvidia-settings -a "[gpu:0]/GpuPowerMizerMode=1"

docker start ethminer
