/*Create a distribution of beds across all wards, and a distribution of all wards
across beds*/
SELECT
	CONCAT (B.bedNo, ' ', B.type, ' ', B.size) AS 'bed_number_type_size', W.location AS 'ward_name'
FROM
	Bed as B
CROSS JOIN
	Ward AS W