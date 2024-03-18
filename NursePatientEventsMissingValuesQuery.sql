--Part 2) Question 7
/*Find missing values of nurses who have not seen a patient and all patients that
have not seen a nurse.*/
SELECT
    CONCAT(P.firstName, ' ', P.lastName) AS 'patient_full_name', --Concatenate first and last names (with a space in between)
    CONCAT(N.firstName, ' ', N.lastName) AS 'nurse_full_name'
FROM 
    NursePatient AS NP
FULL JOIN 
    Nurse AS N ON NP.nurseID = N.nurseID
FULL JOIN
    Patient AS P ON NP.patientNo = P.patientNo;
--There's 10 nurses who have not seen a patient and there's 6 patients who have not seen a nurse