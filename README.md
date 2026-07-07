# Citrix VDI Automation

## 🔹 Overview
Automated lifecycle management for 350+ Citrix VDI desktops using PowerShell and Task Scheduler.

The solution powers on desktops for weekend maintenance and shuts them down afterward with no manual intervention.

---

## 🔹 What It Does

### Sunday Morning
- Powers on all machines
- Places unassigned desktops into maintenance mode

### Sunday Night
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
- Tracked down why the script behaved differently when run manually versus through Task Scheduler.
- Built separate handling for assigned and unassigned desktops so machines stayed available for weekend scanning.
- Added maintenance mode logic to prevent unassigned machines from being shut back down before scans completed.
- Increased reliability by adding retry logic for machines that did not power on during the first pass.
- Improved logging and reporting so future technicians can quickly identify machines that were missed.
- Automated startup and shutdown processes across multiple Citrix Delivery Groups that previously required manual effort.

---

## 🔹 Lessons Learned
- A script working in a PowerShell window does not always mean it will behave the same way through Task Scheduler.
- Good logging is just as important as getting the automation working because troubleshooting is nearly impossible without it.
- Large batches of power-on requests do not always complete the same way, so retries and reporting are important.
- Small details like Delivery Group names, authentication methods, and machine states can have a big impact on automation results.
- Building the solution is only part of the job; documenting it well makes it useful for the rest of the team.

---

## 🔹 Project Impact
- Automated the weekly power-on and shutdown process for more than 350 Citrix virtual desktops.
- Reduced the amount of weekend work required from technicians during maintenance and Fortra scanning windows.
- Improved visibility by adding logging, failure reporting, and operational tracking.
- Created a repeatable process that can be handed off to other technicians and reused in the future.
- Helped move the environment closer to a fully automated, hands-off process.

---

## 🔹 What I Built
I created a PowerShell-based automation solution that powers on Citrix virtual desktops before weekly security scanning and powers them back off once maintenance is complete.

The solution handles assigned and unassigned desktops differently, uses maintenance mode to prevent unwanted power actions, includes retry logic for reliability, and generates logs that help identify any machines that were missed during execution.

The final solution was successfully deployed in production and is now being used to reduce manual weekend support work.

---

## 🔹 Scripts
See `/scripts` folder

## 🔹 Documentation
See `/docs/project-overview.md`
