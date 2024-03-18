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
