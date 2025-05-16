#!/bin/bash

# Proxmox Disk Temperature Monitor (proxmox-disk-temp)
# Version: v1.0.0
# This script monitors and displays the health of all connected disks on a Proxmox system.

# Display header
printf "%-10s %-50s %-15s %-20s %-20s\n" "Disk" "Model" "Kapasite (TB)" "Airflow Temp (°C)" "Temp Celsius (°C)"
echo "---------------------------------------------------------------------------------------------------------------"

# Scan and display disk information
for disk in /dev/sd?; do
  model=$(smartctl -i $disk | grep -i "Model\|Device Model\|Product" | awk -F: '{print $2}' | xargs)
  capacity=$(lsblk -d -o NAME,SIZE | grep $(basename $disk) | awk '{print $2}')
  airflow=$(smartctl -A $disk | grep -i "Airflow_Temperature_Cel" | awk '{print $10}')
  temp=$(smartctl -A $disk | grep -i "Temperature_Celsius" | awk '{print $10}')
  
  # Print disk capacity in TB if applicable
  if [[ "$capacity" == *"G"* ]]; then
    capacity=$(echo "$capacity" | sed 's/G//g')
    capacity=$(awk "BEGIN {printf \"%.2f TB\", $capacity/1024}")
  fi

  printf "%-10s %-50s %-15s %-20s %-20s\n" "$disk" "${model:-N/A}" "${capacity:-N/A}" "${airflow:-N/A}" "${temp:-N/A}"
done
