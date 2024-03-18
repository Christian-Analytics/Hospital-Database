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