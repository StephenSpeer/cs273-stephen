SELECT i.CLIFix, i.GUIFix, c.Category
FROM Issues i
LEFT JOIN Categories.c ON c.CategoryID = i.CategoryID
WHERE c.Category = ‘Firewall’;

SELECT t.Title,  i.issueID
FROM Tags t
INNER JOIN Issue-Tag it ON t.TagID = it.TagID
INNER JOIN Issues i ON it.IssueID =i.Issue ID;

SELECT r.Resource, c.Category
FROM Resources r
INNER JOIN Issues i ON r.ResourceID = i.ResourceID
INNER JOIN Categories c ON i.Category = c.CategoryID 
WHERE c.Category = ‘Encryption’;

SELECT o.Version, i.IssueID
FROM OperatingSystem o
INNER JOIN Issues i ON o.OperatingSystemID = i.OperatingSystemID
WHERE o.Brand = ‘Windows’;

SELECT o.Version, i.IssueID
FROM OperatingSystem o
INNER JOIN Issues i ON o.OperatingSystemID = i.OperatingSystemID
WHERE o.Brand = ‘Linux’;

SELECT c.Category, COUNT(i.IssueID) AS ProblemCount
FROM Categories c
INNER JOIN Issues i ON i.CategoryID
GROUP BY Category
HAVING Category = ‘Firewall’ 
OR Category = ‘Policies’;

SELECT IssueID, AVG(Difficulty)
FROM Issues
GROUP BY Category ;

SELECT COUNT(i.CLIFix) AS FixCnt
FROM Issues i
INNER JOIN OperatingSystem o ON i.OperatingSystemID
WHERE Brand = ‘Linux’;

SELECT SELECT IssueID, AVG(Priority)
FROM Issues
GROUP BY Category;

SELECT COUNT(i.CLIFix) AS FixCnt
FROM Issues i
INNER JOIN OperatingSystem o ON i.OperatingSystemID
WHERE Brand = ‘Windows’;
