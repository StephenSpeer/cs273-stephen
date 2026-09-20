# Phase 2 — Field List
## Draft Fields
| Field | Purpose | Notes |
|---|---|---|
| Instruction ID | Unique identifier, e.g. WIN-ACCT-001 | Replaced with Issue ID | 
| Title | Short name, e.g. “Disable Guest Account” |
| Operating System | Windows 10, Windows 11, Ubuntu, etc. | Multivalued, brought into its own table |
| OS Version / Edition | Windows 10 Pro, Ubuntu 22.04, etc. | Multipart Spilt into brand and version. |
| Competition Category | Accounts, Services, Firewall, Updates, Policies, etc. |
| Security Objective | What security problem the instruction addresses |
| Threat / Vulnerability | What could go wrong if it's left unsecured |
| Priority | Critical / High / Medium / Low |
| CyberPatriot Relevance | How commonly the item appears in competition images |
| Difficulty | Beginner / Intermediate / Advanced |
| Instruction | The actual step-by-step procedure |
| GUI Procedure | Steps using the graphical interface |
| Command-Line Procedure | PowerShell, CMD, Bash, etc., when applicable |
| Command(s) | Exact commands that can be used |
| Expected State | What the system should look like after remediation |
| Verification Method | How to confirm the change worked |
| Before State | What an insecure configuration looks like |not relevant |
| After State | What a secure configuration looks like |ditto |
| Dependencies | Things that must be done first |
| Potential Side Effects | What legitimate functionality could be affected |
| Do Not Change | Settings that should be left alone |
| Competition Warning | Things competitors should check before applying the fix |
| Rollback Procedure | How to undo the change if necessary |
| Evidence / Source | Microsoft documentation, Ubuntu documentation, CyberPatriot material, etc. |
| Last Verified | Date the instruction was last tested |
| Verified By | Team member who tested it |
| Applicable Image Types | Windows workstation, Windows server, Linux, etc. |
| Tags | Searchable keywords |
| Notes | Additional team-specific information |

Without guidance, I would have created one giant table instead of attaching several foreign keys.

## Calculated Fields
| Fields | Formula |
|---|---|
| Operating system name | = brand + version |
| Fix Value | Priority + Difficulty |

## Table List
### Issues
the list of problems
| Field | Purpose | Notes |
|---|---|---|
| Issue ID(PK) | The problem structure |
| Operating system ID(FK) | Windows 10, Windows 11, Ubuntu, etc. |
| Category ID(FK) | Accounts, Services, Firewall, Updates, Policies, etc. |
| Priority ID(FK) | Critical / High / Medium / Low |
| Difficulty ID(FK) | Beginner / Intermediate / Advanced |
| GUI Procedure | Steps using the graphical interface |
| Command-Line Procedure | PowerShell, CMD, Bash, etc., when applicable |
| Potential Side Effects | What legitimate functionality could be affected |

### Issue-tag
to combine issue ID with tag IDs.
| Field | Purpose | Notes |
|---|---|---|
| Issue ID(FK) |
| Tag ID(FK) |

### Operating Systems
For specifications on solutions.
| Field | Purpose | Notes |
|---|---|---|
| Operating system ID(PK) | Windows 10, Windows 11, Ubuntu, etc. |
| Brand | Win, Linux, etc. |
| OS Version / Edition | Windows 10 Pro, Ubuntu 22.04, etc. |

### Tags
For labeling issues
| Field | Purpose | Notes |
|---|---|---|
| Tag ID(PK) |
| Tags | Searchable keywords |
| Title | Short name, e.g. “Disable Guest Account” |

### Categories 
For organizing solution fields
| Field | Purpose | Notes |
|---|---|---|
| Category ID(PK) | Accounts, Services, Firewall, Updates, Policies, etc. |
| Name |

### Resource
for knowing what to use in alternative scenarios
| Field | Purpose | Notes |
|---|---|---|
| Resource ID(PK) | 
| Name | 
| url | https://etc. |
| Description |

### Priority
For competition efficiency
| Field | Purpose | Notes |
|---|---|---|
| Priority ID(PK) |
| Name |

### Difficulty
For competition efficiency; regarding who should be assigned what tasks.
| Field | Purpose | Notes |
|---|---|---|
| Difficulty ID(PK) |
| Name |

## Reflection 
Many of the fields were untrackable in some manner so I had to change them. It also did not make sense to have Instruction ID be the primary key when it is supposed to be an end value. Therefore, it has been replace with issue id which connects each of the detail based tables much more coherently.
