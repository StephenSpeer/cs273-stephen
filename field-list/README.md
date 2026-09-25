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
| Field | Purpose | Null/Not | Type | Notes |
|---|---|---|---|---|
| Issue ID(PK) | The problem structure | Not Null | INT |
| Operating system ID(FK) | Windows 10, Windows 11, Ubuntu, etc. | Null | INT |
| Category ID(FK) | Accounts, Services, Firewall, Updates, Policies, etc. | Null | INT |
| Priority ID(FK) | Critical / High / Medium / Low | Null | INT | CHECK (Either: Critical / High / Medium / Low) |
| Difficulty ID(FK) | Beginner / Intermediate / Advanced | Null | INT | CHECK (Either: Beginner / Intermediate / Advanced ) |
| GUI Procedure | Steps using the graphical interface | Not Null | varchar |
| Command-Line Procedure | PowerShell, CMD, Bash, etc., when applicable | Not Null | varchar |
| Potential Side Effects | What legitimate functionality could be affected | Null | varchar |

### Issue-tag
to combine issue ID with tag IDs.
| Field | Purpose | Null/Not | Type | Notes |
|---|---|---|---|---|
| Issue ID(FK) | | Null | INT | varchar |
| Tag ID(FK) | | Null | INT | varchar |

### Operating Systems
For specifications on solutions.
| Field | Purpose | Null/Not | Type | Notes |
|---|---|---|---|---|
| Operating system ID(PK) | Windows 10, Windows 11, Ubuntu, etc. | Not Null | INT |
| Brand | Win, Linux, etc. | Not Null | varchar | CHECK (Either: Windows, Linux, or Cisco) |
| OS Version / Edition | Windows 10 Pro, Ubuntu 22.04, etc. | Null | varchar |

### Tags
For labeling issues
| Field | Purpose | Null/Not | Type | Notes |
|---|---|---|---|---|
| Tag ID(PK) | | Not Null | INT |
| Tags | Searchable keywords | Not Null | varchar |
| Title | Short name, e.g. “Disable Guest Account” | Not Null | varchar |

### Categories 
For organizing solution fields
| Field | Purpose | Null/Not | Type | Notes |
|---|---|---|---|---|
| Category ID(PK) | Accounts, Services, Firewall, Updates, Policies, etc. | Not Null | INT |
| Name | | Not Null | varchar |

### Resource
for knowing what to use in alternative scenarios
| Field | Purpose | Null/Not | Type | Notes |
|---|---|---|---|---|
| Resource ID(PK) | | Not Null | INT |
| Name | | Null | varchar |
| url | https://etc. | Null | varchar |
| Description | | Null | varchar |

### Priority
For competition efficiency
| Field | Purpose | Null/Not | Type | Notes |
|---|---|---|---|---|
| Priority ID(PK) | | Not Null | INT |
| Name | | Null | varchar |

### Difficulty
For competition efficiency; regarding who should be assigned what tasks.
| Field | Purpose | Null/Not | Type | Notes |
|---|---|---|---|---|
| Difficulty ID(PK) | | Not Null | INT |
| Name | | Null | varchar |

## Reflection 
Many of the fields were untrackable in some manner so I had to change them. It also did not make sense to have Instruction ID be the primary key when it is supposed to be an end value. Therefore, it has been replace with issue id which connects each of the detail based tables much more coherently.
