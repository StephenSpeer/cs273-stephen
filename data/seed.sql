-- =============================================================
-- CS 273 — Phase 6 Seed Data
-- CyberPatriot Troubleshooting Database (Hannibal teams)
-- 5 rows per table, built so every query in queries/myQueries.sql
-- returns results. Run AFTER schema/schema.sql.
-- Insert order follows the foreign keys: lookups -> Issues -> IssueTag
-- =============================================================

USE cyberpatriot;

-- -------------------------------------------------------------
-- OperatingSystem  (3 Windows, 2 Linux -> queries 4, 5, 8, 10)
-- -------------------------------------------------------------
INSERT INTO OperatingSystem (OperatingSystemID, Brand, Version) VALUES
  (1, 'Windows', '10 Pro'),
  (2, 'Windows', '11 Pro'),
  (3, 'Windows', 'Server 2022'),
  (4, 'Linux',   'Ubuntu 22.04'),
  (5, 'Linux',   'Mint 21');

-- -------------------------------------------------------------
-- Categories  (Firewall, Policies, Encryption are named in the queries)
-- -------------------------------------------------------------
INSERT INTO Categories (CategoryID, Category) VALUES
  (1, 'Firewall'),
  (2, 'Policies'),
  (3, 'Encryption'),
  (4, 'Accounts'),
  (5, 'Services');   -- no issues yet: shows INNER JOIN leaving a category out

-- -------------------------------------------------------------
-- Resources
-- -------------------------------------------------------------
INSERT INTO Resources (ResourceID, ResourceName, URL, Description) VALUES
  (1, 'Windows Firewall Documentation',
      'https://learn.microsoft.com/en-us/windows/security/operating-system-security/network-security/windows-firewall/',
      'Microsoft guide to Windows Defender Firewall profiles and rules.'),
  (2, 'Ubuntu UFW Guide',
      'https://help.ubuntu.com/community/UFW',
      'Ubuntu community guide to the Uncomplicated Firewall (ufw).'),
  (3, 'Windows Password Policy Reference',
      'https://learn.microsoft.com/en-us/windows/security/threat-protection/security-policy-settings/password-policy',
      'Microsoft reference for password length, age, and complexity settings.'),
  (4, 'sshd_config Manual Page',
      'https://man.openbsd.org/sshd_config',
      'OpenSSH server options, including the Ciphers and MACs settings.'),
  (5, 'CyberPatriot Training Modules',
      'https://www.uscyberpatriot.org/competition/training-materials/training-modules',
      'Official AFA training material. Not linked to an issue yet.');

-- -------------------------------------------------------------
-- Tags  (Title is the plain-English name shown by query 2)
-- -------------------------------------------------------------
INSERT INTO Tags (TagID, Tags, Title) VALUES
  (1, 'firewall, windows, defender',   'Enable Windows Defender Firewall'),
  (2, 'firewall, linux, ufw',          'Enable UFW Firewall'),
  (3, 'policies, password, windows',   'Set Password Length and Age Policy'),
  (4, 'encryption, ssh, linux',        'Remove Weak SSH Ciphers'),
  (5, 'accounts, guest, windows',      'Disable Guest Account');

-- -------------------------------------------------------------
-- Issues
--   Firewall x2 (one Windows, one Linux), Policies x1,
--   Encryption x1 (with a resource -> query 3), Accounts x1 (no resource)
--   Priority / Difficulty: 1 = low/beginner ... 3 = critical/advanced
-- -------------------------------------------------------------
INSERT INTO Issues
  (IssueID, OperatingSystemID, CategoryID, Priority, Difficulty, ResourceID, GUIFix, CLIFix, SideEffects) VALUES
  (1, 1, 1, 3, 1, 1,
      'Open Windows Security > Firewall & network protection. Turn the firewall On for the Domain, Private, and Public profiles.',
      'netsh advfirewall set allprofiles state on',
      'May block a required service until an allow rule is added. Check the README for required services first.'),
  (2, 4, 1, 3, 2, 2,
      'Install gufw, open Firewall Configuration, and switch Status to On.',
      'sudo ufw enable && sudo ufw default deny incoming',
      'Blocks incoming SSH unless it is allowed first with: sudo ufw allow ssh'),
  (3, 3, 2, 2, 2, 3,
      'Open secpol.msc > Account Policies > Password Policy. Set minimum length to 10 and maximum age to 90 days.',
      'net accounts /minpwlen:10 /maxpwage:90 /minpwage:1',
      'Users with short passwords must change them at next logon.'),
  (4, 5, 3, 2, 3, 4,
      'Open /etc/ssh/sshd_config in a text editor, set the Ciphers line to AES-CTR and AES-GCM only, save, then restart the SSH service.',
      'echo "Ciphers aes256-gcm@openssh.com,aes256-ctr,aes128-ctr" | sudo tee -a /etc/ssh/sshd_config && sudo systemctl restart ssh',
      'Very old SSH clients may no longer be able to connect.'),
  (5, 2, 4, 1, 1, NULL,
      'Open Computer Management > Local Users and Groups > Users > Guest. Check "Account is disabled".',
      'net user Guest /active:no',
      NULL);

-- -------------------------------------------------------------
-- IssueTag  (one titled tag per issue -> query 2 lists all 5 issues)
-- -------------------------------------------------------------
INSERT INTO IssueTag (IssueID, TagID) VALUES
  (1, 1),
  (2, 2),
  (3, 3),
  (4, 4),
  (5, 5);
