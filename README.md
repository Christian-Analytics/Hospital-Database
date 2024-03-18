Add SQL queries for hospital database analysis

This commit adds a set of decision-making SQL queries used to analyze the hospital database. The queries cover various aspects of the database, including analyzing nurse productivity, unseen patients, medical procedures, and patient billing. These queries are designed to extract meaningful insights from the data, aiding in identifying trends and improving operational efficiency within the hospital.

Queries included in this commit:
-Nurses who have not seen patients and vice versa to aid in productivity analysis
-Analysis of Patient Information who have been admitted in February
-Full List of Treatments Administered displaying patient and physician name
-Number of admits conducted by physician, sorted by date
-Simple Bulk Insert using a data generator to insert Physician information
-Patient itemized bill (also stored as a parametric SPROC by patient name- can access from MDF)
-Distribution of beds across all wards using cross join
-Patient-Bed distribution
