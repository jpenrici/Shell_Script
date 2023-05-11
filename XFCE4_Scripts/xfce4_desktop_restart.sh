#!/bin/bash
# Restart XFCE4 Menu
# Reference: https://wiki.xfce.org/howto/customize-menu

# Forcing changes
xfdesktop --reoload

# Severe alternative
# killall -HUP xfdesktop