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
