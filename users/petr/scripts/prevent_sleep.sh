#!/usr/bin/env bash

echo Preventing sleep...
systemctl mask --runtime sleep.target suspend.target hibernate.target hybrid-sleep.target
read
systemctl unmask --runtime sleep.target suspend.target hibernate.target hybrid-sleep.target

