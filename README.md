# Citrix VDI Automation

## 🔹 Overview
🚀 Automated lifecycle management for 350+ Citrix VDI desktops using PowerShell and Task Scheduler.

The solution powers on desktops for weekend maintenance and shuts them down afterward with no manual intervention.

---

## 🔹 What It Does

### ✅ Sunday Morning
- Powers on all machines
- Places unassigned desktops into maintenance mode

### ✅ Sunday Night
- Removes maintenance mode
- Powers off all machines

---

## 🔹 Technologies Used
- PowerShell
- Citrix DaaS SDK
- Task Scheduler
- Citrix Cloud API Authentication

---

## 🔹 Key Challenges Solved
- Fixed authentication issues where scripts worked locally but failed in Task Scheduler
- Resolved Delivery Group matching issues due to strict string comparison
- Handled unassigned desktops using maintenance mode to prevent unintended shutdown
- Identified why logs appeared minimal during successful runs

---

## 🔹 Project Impact
- Automated lifecycle of 350+ desktops
- Eliminated manual weekend operations
- Improved reliability of maintenance and scanning workflows

---

## 🔹 Scripts
See `/scripts` folder

## 🔹 Documentation
See `/docs/project-overview.md`
