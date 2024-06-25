/*Find missing values for beds with and without patients, and for patients with and
without beds.*/
SELECT
	P.firstName AS 'Patient_Name',
	B.bedNo AS 'Bed_Number',
	B.type AS 'Bed_Type'
FROM
	Patient AS P
FULL JOIN
	Bed AS B ON P.bedNo=B.bedNo

/*Create a distribution of beds across all wards, and a distribution of all wards
across beds*/
SELECT
	CONCAT (B.bedNo, ' ', B.type, ' ', B.size) AS 'bed_number_type_size', W.location AS 'ward_name'
FROM
	Bed as B
CROSS JOIN
	Ward AS W

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

/*Patients admitted to hospital in a certain month, their admitting physician, bed
assigned and ward, sorted by most recent date.*/
SELECT
	P.lastName AS 'Patient Last Name',
	B.type AS 'Bed_Type',
	B.size AS 'Bed_Size',
	W.location AS 'Ward_Name',
	PH.lastName AS 'Admitting_Doc',
	Month(AD.admitDate) AS 'Month_Admitted',
	AD.admitDate AS 'Date_Admitted'
FROM
	AdultDischarge AS AD
JOIN
	Physician AS PH ON AD.admitDoc=PH.doctorID
JOIN 
	Patient AS P ON AD.patientNo=P.patientNo
JOIN
	Bed AS B ON P.bedNo=B.bedNo
JOIN 
	Ward AS W ON B.wardID=W.wardID
WHERE
	MONTH(AD.admitDate)=2
ORDER BY AD.admitDate

/*Patiet Itemized Bill with Subtotals using UNION OPERATOR; THIS IS AN EXTENSION OF THE JOINS PATIENT BILL ADDING ANOTHER QUERY USING THE UNION OPERATOR TO DISPLAY SUBTOTALS
First Query selects a patient's Item Charges, the item's name(s), quantities, and date incurred*/
SELECT
    'Item' AS charge_type,
    P.patientNo,
    CONCAT(P.firstName, ' ', P.lastName) AS patient_full_name,
    IC.date,
    I.name AS [name],
    IC.quantity as [quantity],
    I.charge AS [charge]
FROM
    ItemCharge IC
JOIN 
    Item I ON IC.itemNo = I.itemNo
JOIN
    Patient P ON IC.patientNo = P.patientNo
WHERE 
    P.patientNo = 6
GROUP BY 
    P.patientNo, CONCAT(P.firstName, ' ', P.lastName), IC.date, I.name, IC.quantity, I.charge

UNION -- Union on Second Query that selects a patient's Treatment Charges
SELECT
    'Treatment' AS charge_type,
    P.patientNo,
    CONCAT(P.firstName, ' ', P.lastName),
    TA.dateTime AS date,
    T.name AS [name],
    COUNT(*) AS [quantity],-- counts each treatment as 1
    T.charge AS [charge]
FROM
    TreatmentAdministration TA
JOIN
    Treatment T ON TA.treatmentNo = T.treatmentNo
JOIN 
    Patient P ON TA.patientNo = P.patientNo
WHERE 
    P.patientNo = 6
GROUP BY 
    P.patientNo, CONCAT(P.firstName, ' ', P.lastName), TA.dateTime, T.name, T.charge

UNION -- Union on Third Query that Takes the sum of the charges, and the sum of the quantities
SELECT 
    'Total' AS charge_type,
    P.patientNo,
    CONCAT(P.firstName, ' ', P.lastName),
    GETDATE() AS [date],
    'Amount Owed' AS [name],
    (SELECT SUM(IC.quantity) FROM ItemCharge IC WHERE IC.patientNo = P.patientNo) +
    (SELECT COUNT(*) FROM TreatmentAdministration TA WHERE TA.patientNo = P.patientNo) AS [quantity],
    --have to use COUNT for treatment administration because there's no quantity column in the TA table
    SUM(I.charge) + SUM(T.charge) AS charge
FROM
    Patient P
JOIN 
    ItemCharge IC ON P.patientNo = IC.patientNo
JOIN 
    Item I ON IC.itemNo = I.itemNo
JOIN
    TreatmentAdministration TA ON P.patientNo = TA.patientNo
JOIN
    Treatment T ON TA.treatmentNo = T.treatmentNo
WHERE 
    P.patientNo = 6
GROUP BY 
    CONCAT(P.firstName, ' ', P.lastName), P.patientNo
ORDER BY 
    charge ASC

/*Total list of treatments administered to a patient by physician for each
treatment, sorted by date of treatment, listing last name of patient and of physician.*/
SELECT
	P.lastName AS 'Patient_Last_Name',
	T.name AS 'Treatment_Name',
	PH.lastName AS 'Physician_Last_Name',
	CAST(TA.dateTime AS Date) AS 'Treatment_Date'
FROM
	TreatmentAdministration AS TA
JOIN
	Patient AS P ON TA.patientNo=P.patientNo
JOIN
	Physician AS PH ON TA.doctorID=PH.doctorID
JOIN
	Treatment AS T ON TA.treatmentNo=T.treatmentNo
ORDER BY TA.dateTime

/*Physician total admits for the past year, sorted by date.*/
SELECT TOP 1000
	P.lastName AS 'Doctor Last Name',
	Count(AD.admitDoc) AS 'Number of times Doctor admitted someone on that date',
	AD.admitDate AS 'Date Doctor Admitted a Patient'
FROM
	AdultDischarge AD
JOIN
	Physician P ON AD.admitDoc=P.doctorID
JOIN
	Patient PA ON AD.patientNo=PA.patientNo
WHERE
	AD.admitDate >= DATEADD(year, -1, GETDATE()) -- anything in the past year
GROUP BY P.lastName, AD.admitDate
ORDER BY AD.admitDate