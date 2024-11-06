-- Creating Views

CREATE VIEW TotalPoints AS 
SELECT *
FROM Rawscores R
WHERE R.SSN = '0001';

CREATE VIEW Weights AS 
SELECT *
FROM Rawscores R
WHERE R.SSN = '0002';

CREATE VIEW WtdPts AS
SELECT ((1/TP.HW1) * W.HW1) AS HW1, ((1/TP.HW2a) * W.HW2a) AS HW2a, ((1/TP.HW2b) * W.HW2b) AS HW2b, ((1/TP.Midterm) * W.Midterm) AS Midterm, ((1/TP.HW3) * W.HW3) AS HW3, ((1/TP.FExam) * W.FExam) AS FExam 
FROM TotalPoints TP, Weights W;



DELIMITER //
CREATE PROCEDURE printSSN(IN SSNVar VARCHAR(4))
   BEGIN
      SELECT * FROM Rawscores R WHERE R.SSN = SSNVar;
   END //
DELIMITER ;

-- CALL printSSN(1212); Example Call

DELIMITER //
CREATE PROCEDURE printPercentages(IN SSNVar VARCHAR(4))
    BEGIN
        SELECT R.SSN, (R.HW1/TP.HW1) * 100 AS HW1Perc, (R.HW2a/TP.HW2a) * 100 AS HW2aPerc, (R.HW2b/TP.HW2b) * 100 AS HW2bPerc, (R.Midterm/TP.Midterm) * 100 AS MidtermPerc, (R.HW3/TP.HW3) * 100 AS HW3Perc, (R.FExam/TP.FExam) * 100 AS FExamPerc, (R.HW1 * WP.HW1 + R.HW2a * WP.HW2a + R.HW2b * WP.HW2b + R.Midterm * WP.Midterm + R.HW3 * WP.HW3 + R.FExam * WP.FExam) AS CumAvg FROM WtdPts WP, TotalPoints TP, Rawscores R WHERE R.SSN = SSNVar;
    END //
DELIMITER ;

-- CALL printPercentages(1212); need to add printing part and change variables to match instructions

DELIMITER //
CREATE PROCEDURE AllRawScores(IN password VARCHAR(15))
BEGIN
IF EXISTS (SELECT P.CurPasswords FROM Passwords P WHERE P.CurPasswords = password) THEN
    SELECT * FROM Rawscores R WHERE R.SSN <> '0001' AND R.SSN <> '0002' ORDER BY R.Section, R.LName, R.FName;
ELSE
    SELECT `Sorry, that password is not valid. Try again!`;
END IF;
END //
DELIMITER ;

-- CALL AllRawScores('OpenSesame');
-- CALL AllRawScores('BadPassword');

DELIMITER //
CREATE PROCEDURE AllPercentages(IN password VARCHAR(15))
BEGIN
IF EXISTS (SELECT P.CurPasswords FROM Passwords P WHERE P.CurPasswords = password) THEN
    SELECT R.SSN, R.Section, (R.HW1/TP.HW1) * 100 AS HW1Perc, (R.HW2a/TP.HW2a) * 100 AS HW2aPerc, (R.HW2b/TP.HW2b) * 100 AS HW2bPerc, (R.Midterm/TP.Midterm) * 100 AS MidtermPerc, (R.HW3/TP.HW3) * 100 AS HW3Perc, (R.FExam/TP.FExam) * 100 AS FExamPerc, (R.HW1 * WP.HW1 + R.HW2a * WP.HW2a + R.HW2b * WP.HW2b + R.Midterm * WP.Midterm + R.HW3 * WP.HW3 + R.FExam * WP.FExam) AS CumAvg FROM WtdPts WP, TotalPoints TP, Rawscores R WHERE R.SSN <> '0001' AND R.SSN <> '0002' ORDER BY R.Section, CumAvg;
ELSE
    SELECT `Sorry, that password is not valid. Try again!`;
END IF;
END //
DELIMITER ;

-- CALL AllPercentages('OpenSesame');

-- SKIPPED PART E (don't understand it)

DELIMITER //
CREATE PROCEDURE ChangeScores(IN password VARCHAR(15), SSN VARCHAR(4), AssignmentName VARCHAR(10), NewScore DECIMAL(5,2))
BEGIN
IF EXISTS (SELECT P.CurPasswords FROM Passwords P WHERE P.CurPasswords = password) THEN
    IF AssignmentName = 'HW1' THEN
        UPDATE Rawscores R SET HW1 = NewScore WHERE R.SSN = SSN AND AssignmentName = 'HW1';
    ELSEIF AssignmentName = 'HW2a' THEN 
        UPDATE Rawscores R SET HW2a = NewScore WHERE R.SSN = SSN AND AssignmentName = 'HW2a';
    ELSEIF AssignmentName = 'HW2b' THEN 
        UPDATE Rawscores R SET HW2b = NewScore WHERE R.SSN = SSN AND AssignmentName = 'HW2b';
    ELSEIF AssignmentName = 'Midterm' THEN 
        UPDATE Rawscores R SET Midterm = NewScore WHERE R.SSN = SSN AND AssignmentName = 'Midterm';
    ELSEIF AssignmentName = 'HW3' THEN 
        UPDATE Rawscores R SET HW3 = NewScore WHERE R.SSN = SSN AND AssignmentName = 'HW3';
    ELSEIF AssignmentName = 'FExam' THEN 
        UPDATE Rawscores R SET FExam = NewScore WHERE R.SSN = SSN AND AssignmentName = 'FExam';
    ELSE
        SELECT `Invalid AssignmentName was entered. Try again!`;
    END IF;
ELSE
    SELECT `Sorry, that password is not valid. Try again!`;
END IF;
END //
DELIMITER ;

-- CALL ChangeScores('OpenSesame', 1212, 'HW1', 100.00);
-- CALL ChangeScores('OpenSesame', 1212, 'HW2a', 100.00);
-- CALL ChangeScores('OpenSesame', 1212, 'FExam', 100.00);
-- CALL ChangeScores('OpenSesame', 1212, 'HW4', 100.00); INVALID ASSIGNMENT NAME CASE
-- CALL ChangeScores('OpenSee', 1212, 'HW3', 100.00); INVALID PASSWORD CASE

