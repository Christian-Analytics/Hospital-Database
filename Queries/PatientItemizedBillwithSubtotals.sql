/*UNION OPERATOR; THIS IS AN EXTENSION OF THE JOINS PATIENT BILL ADDING ANOTHER QUERY USING THE UNION OPERATOR TO DISPLAY SUBTOTALS
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
