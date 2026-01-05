#!/bin/bash

sysctl hw.acpi.battery.life | awk '{print ENVIRON["LABEL"] $2"%"}'
