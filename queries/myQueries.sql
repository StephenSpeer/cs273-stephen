-- Query 1 - Firewall fixes
SELECT i.CLIFix, i.GUIFix, c.Category
FROM Issues i
LEFT JOIN Categories c ON c.CategoryID = i.CategoryID
WHERE c.Category = 'Firewall';

-- Query 2 - Plain-English title for each issue
SELECT t.Title, i.IssueID
FROM Tags t
INNER JOIN IssueTag it ON t.TagID = it.TagID
INNER JOIN Issues i ON it.IssueID = i.IssueID;

-- Query 3 - Resources for Encryption issues
SELECT r.ResourceName, c.Category
FROM Resources r
INNER JOIN Issues i ON r.ResourceID = i.ResourceID
INNER JOIN Categories c ON i.CategoryID = c.CategoryID
WHERE c.Category = 'Encryption';

-- Query 4 - Issues on Windows
SELECT o.Version, i.IssueID
FROM OperatingSystem o
INNER JOIN Issues i ON o.OperatingSystemID = i.OperatingSystemID
WHERE o.Brand = 'Windows';

-- Query 5 - Issues on Linux
SELECT o.Version, i.IssueID
FROM OperatingSystem o
INNER JOIN Issues i ON o.OperatingSystemID = i.OperatingSystemID
WHERE o.Brand = 'Linux';

-- Query 6 - Issue count for Firewall and Policies
SELECT c.Category, COUNT(i.IssueID) AS ProblemCount
FROM Categories c
INNER JOIN Issues i ON i.CategoryID = c.CategoryID
GROUP BY c.Category
HAVING c.Category = 'Firewall'
OR c.Category = 'Policies';

-- Query 7 - Average difficulty per category
SELECT c.Category, AVG(i.Difficulty) AS AvgDifficulty
FROM Issues i
INNER JOIN Categories c ON i.CategoryID = c.CategoryID
GROUP BY c.Category;

-- Query 8 - Number of Linux fixes
SELECT COUNT(i.CLIFix) AS FixCnt
FROM Issues i
INNER JOIN OperatingSystem o ON i.OperatingSystemID = o.OperatingSystemID
WHERE o.Brand = 'Linux';

-- Query 9 - Average priority per category
SELECT c.Category, AVG(i.Priority) AS AvgPriority
FROM Issues i
INNER JOIN Categories c ON i.CategoryID = c.CategoryID
GROUP BY c.Category;

-- Query 10 - Number of Windows fixes
SELECT COUNT(i.CLIFix) AS FixCnt
FROM Issues i
INNER JOIN OperatingSystem o ON i.OperatingSystemID = o.OperatingSystemID
WHERE o.Brand = 'Windows';
