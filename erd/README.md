# Phase 3 — ERD

- My database is a system for competitive cyber security the issues table represents each of the primary problems that are scored, their details, and how they resolved. the operating systems, categories, resource, and tag tables help provide that additional information, the issue-tag table is to connect the tags table to the issues table.
- The one to many relationship from operating systems was done to allow one operating system version to be used for multiple issues in the main table.
- I had trouble with the difficulty and priority ID relationships, and ultimately decided it was best to just make them fields in the primary table rather than related tables with an unnecessary key.
