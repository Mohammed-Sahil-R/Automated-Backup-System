# Automated Linux Backup System

A Bash-scripted automated backup solution for Linux systems using cron job scheduling. Designed to run unattended, compress backups efficiently, manage old backup retention, and log every operation for traceability.

---

## Features

- Automatically compresses and archives specified directories
- Schedules backups using Linux `cron`
- Retains only the last N backups (configurable) — older ones are auto-deleted
- Logs every backup run with timestamps to a log file
- Supports multiple source directories
- Lightweight — pure Bash, no external dependencies

---

## Tech Stack

| Tool       | Purpose                          |
|------------|----------------------------------|
| Bash       | Scripting language               |
| `tar`      | Compression and archiving        |
| `cron`     | Scheduled / automated execution  |
| Linux (Ubuntu) | Runtime environment          |

---

## Project Structure

```
Automated-Backup-System/
├── backup.sh          # Main backup script
├── setup_cron.sh      # Helper script to register the cron job
├── backup.log         # Auto-generated log file (after first run)
└── README.md
```

---

## Configuration

Open `backup.sh` and edit the variables at the top:

```bash
# Directory to back up
SOURCE_DIR="/home/user/documents"

# Where backups are stored
BACKUP_DIR="/home/user/backups"

# How many recent backups to keep
MAX_BACKUPS=7

# Log file location
LOG_FILE="/home/user/backups/backup.log"
```

---

## How to Run

### 1. Clone the repository

```bash
git clone https://github.com/Mohammed-Sahil-R/Automated-Backup-System.git
cd Automated-Backup-System
```

### 2. Make scripts executable

```bash
chmod +x backup.sh setup_cron.sh
```

### 3. Run a manual backup

```bash
./backup.sh
```

### 4. Schedule with cron (daily at 2:00 AM)

```bash
./setup_cron.sh
```

Or manually add to crontab:

```bash
crontab -e
# Add this line:
0 2 * * * /path/to/Automated-Backup-System/backup.sh
```

---

## Sample Log Output

```
[2026-05-20 02:00:01] Backup started.
[2026-05-20 02:00:02] Source: /home/user/documents
[2026-05-20 02:00:04] Archive created: backup_2026-05-20_02-00-01.tar.gz (3.2 MB)
[2026-05-20 02:00:04] Old backup removed: backup_2026-05-13_02-00-01.tar.gz
[2026-05-20 02:00:04] Backup completed successfully.
```

---

## Concepts Used

- `tar` — archiving and gzip compression
- `cron` / `crontab` — scheduled task execution
- `find` — locating and removing old backups
- `date` — timestamping archive filenames and log entries
- Bash conditionals and functions
- File I/O and logging

---

## Learning Outcomes

- Linux system administration and file management
- Bash scripting best practices
- Automating repetitive tasks with cron
- Log management and operational traceability
- Backup retention policies

---

## Author

**Mohammed Sahil R**  
[LinkedIn](https://www.linkedin.com/in/mohammed-sahil-r) · [GitHub](https://github.com/Mohammed-Sahil-R)
