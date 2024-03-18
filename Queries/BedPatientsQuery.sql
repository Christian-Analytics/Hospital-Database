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
