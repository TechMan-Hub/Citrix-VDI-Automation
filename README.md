# Citrix VDI Automation

## 🔹 Overview
This project automates Citrix VDI desktop lifecycle management using PowerShell.

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
- Script worked locally but not in Task Scheduler (fixed auth context)
- Delivery group matching issues
- Handling unassigned desktops correctly
- Understanding logging behavior

---

## 🔹 Project Impact
- Automated lifecycle of 350+ desktops
- Reduced manual administrative work
- Improved reliability of maintenance operations

---

## 🔹 Scripts
See `/scripts` folder

## 🔹 Documentation
See `/docs/project-overview.md`
