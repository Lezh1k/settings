#!/bin/bash

LABEL=⚡
sysctl -n hw.acpi.battery.life | awk '
{
    red = "#ff0000"
    yellow = "#ffff00"
    green = "#00ff00"

    p = $1 + 0
    if (p < 15)
        c = red
    else if (p < 80)
        c = yellow
    else
        c = green

    printf("{\"full_text\":\"⚡%d%%\",\"color\":\"%s\"}\n", p, c)
}'

