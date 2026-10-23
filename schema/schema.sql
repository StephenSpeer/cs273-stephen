-- =============================================================
-- CS 273 — Phase 4 Schema
-- CyberPatriot Troubleshooting Database (Hannibal teams)
-- Author: Stephen Speer
-- Target: MySQL 8.0.16+ (CHECK constraints are enforced from 8.0.16)
-- =============================================================

DROP DATABASE IF EXISTS cyberpatriot;
CREATE DATABASE cyberpatriot
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;
USE cyberpatriot;

-- -------------------------------------------------------------
-- Lookup tables (created first, since Issues references them)
-- -------------------------------------------------------------

-- A specific OS a fix applies to (e.g., Windows / 10 Pro, Ubuntu / 22.04)
CREATE TABLE OperatingSystem (
  OperatingSystemID INT          NOT NULL AUTO_INCREMENT,
  Brand             TEXT         NULL,
  Version           TEXT         NULL,
  PRIMARY KEY (OperatingSystemID)
) ENGINE = InnoDB;

-- Competition scoring area (Accounts, Services, Firewall, Updates, Policies)
CREATE TABLE Categories (
  CategoryID        INT          NOT NULL AUTO_INCREMENT,
  Category          TEXT         NULL,
  PRIMARY KEY (CategoryID)
) ENGINE = InnoDB;

-- Outside reference documentation for a fix
CREATE TABLE Resources (
  ResourceID        INT          NOT NULL AUTO_INCREMENT,
  ResourceName      VARCHAR(128) NULL,
  URL               VARCHAR(255) NULL,
  Description       TEXT         NULL,
  PRIMARY KEY (ResourceID)
) ENGINE = InnoDB;

-- Searchable keywords for labeling issues
CREATE TABLE Tags (
  TagID             INT          NOT NULL AUTO_INCREMENT,
  Tags              TEXT         NULL,
  Title             TEXT         NULL,
  PRIMARY KEY (TagID)
) ENGINE = InnoDB;

-- -------------------------------------------------------------
-- Central table
-- -------------------------------------------------------------

-- One scored security problem and how to fix it
CREATE TABLE Issues (
  IssueID           INT UNSIGNED NOT NULL AUTO_INCREMENT,
  OperatingSystemID INT          NOT NULL,
  CategoryID        INT          NOT NULL,
  Priority          INT          NOT NULL DEFAULT 1,
  Difficulty        INT          NOT NULL DEFAULT 1,
  ResourceID        INT          NULL,
  GUIFix            TEXT         NOT NULL,
  CLIFix            TEXT         NOT NULL,
  SideEffects       TEXT         NULL,
  PRIMARY KEY (IssueID),

  CONSTRAINT chk_issues_priority   CHECK (Priority   BETWEEN 1 AND 3),
  CONSTRAINT chk_issues_difficulty CHECK (Difficulty BETWEEN 1 AND 3),

  -- Mandatory: every issue belongs to one OS
  CONSTRAINT fk_issues_os
    FOREIGN KEY (OperatingSystemID) REFERENCES OperatingSystem (OperatingSystemID)
    ON UPDATE CASCADE ON DELETE RESTRICT,

  -- Mandatory: every issue belongs to one category
  CONSTRAINT fk_issues_category
    FOREIGN KEY (CategoryID) REFERENCES Categories (CategoryID)
    ON UPDATE CASCADE ON DELETE RESTRICT,

  -- Optional: an issue may have no resource
  CONSTRAINT fk_issues_resource
    FOREIGN KEY (ResourceID) REFERENCES Resources (ResourceID)
    ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE = InnoDB;

-- -------------------------------------------------------------
-- Junction table (Issues <-> Tags, many-to-many)
-- -------------------------------------------------------------

CREATE TABLE IssueTag (
  IssueID           INT UNSIGNED NOT NULL,
  TagID             INT          NOT NULL,
  PRIMARY KEY (IssueID, TagID),  -- one row per issue/tag pairing, no duplicates

  CONSTRAINT fk_issuetag_issue
    FOREIGN KEY (IssueID) REFERENCES Issues (IssueID)
    ON UPDATE CASCADE ON DELETE CASCADE,

  CONSTRAINT fk_issuetag_tag
    FOREIGN KEY (TagID) REFERENCES Tags (TagID)
    ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE = InnoDB;
