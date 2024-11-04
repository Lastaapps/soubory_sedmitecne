#!/usr/bin/env bash

nvidia-smi -q -d UTILIZATION
nvidia-settings -q gpucoretemp -t
