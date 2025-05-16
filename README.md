# Proxmox Disk Temperature Monitor (proxmox-disk-temp)

## 📌 Description
This script (version v1.0.0) monitors and displays the health of all connected disks on a Proxmox system, including:
- Disk Model
- Capacity (TB)
- Airflow Temperature (°C)
- Celsius Temperature (°C)

## 🚀 Usage
1. Make the script executable:
   ```bash
   chmod +x proxmox-disk-temp.sh
   ```

2. Run the script:
   ```bash
   ./proxmox-disk-temp.sh
   ```

## 🔧 Dependencies
- smartmontools (automatically installed in GitHub Actions)
