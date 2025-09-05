-- Sample script file to populate the Pharmacy Schema

-- Customer(customerID, customerName, address, dateOfBirth, healthInsuranceName)
COPY Customer FROM stdin USING DELIMITERS '|';
1|John Doe|123 Main St, New York, NY|1980-10-19|Kaiser
2|Jane Smith|456 Oak Ave, Los Angeles, CA|2000-01-01|Blue Shield
3|Michael Johnson|789 Elm Rd, Chicago, IL|2005-01-15|Kaiser
4|Emily Davis|321 Pine Blvd, Houston, TX|1960-02-08|Kaiser
5|Robert Brown|654 Cedar Dr, Phoenix, AZ|1994-02-08|Health Net
6|Jessica Wilson|987 Maple Ln, Philadelphia, PA|1994-06-23|Health Net
7|William Martinez|741 Birch Ave, San Antonio, TX|1993-03-09|Blue Shield
8|Amanda Taylor|369 Willow Ct, San Diego, CA|1987-12-31|Blue Shield
\.

-- Pharmacy(pharmacyID, address, openTime, closeTime, numEmployees)
COPY Pharmacy FROM stdin USING DELIMITERS '|';
11|123 Main St, New York, NY|08:00:00|18:00:00|6
22|456 Oak Ave, Los Angeles, CA|08:00:00|15:00:00|6
33|789 Elm Rd, Chicago, IL|08:00:00|20:00:00|10
44|321 Pine Blvd, Houston, TX|10:00:00|15:00:00|3
55|654 Cedar Dr, Phoenix, AZ|07:00:00|20:00:00|12
66|987 Maple Ln, Denver, CO|09:00:00|17:00:00|5
\.

-- Drug(drugID, drugName, manufacturer, prescriptionRequired)
COPY Drug FROM stdin USING DELIMITERS '|';
1|Allegra|Sanofi|false
2|Tylenol|Johnson & Johnson|false
3|Lipitor|Pfizer|true
4|Amoxicillin|Teva Pharmaceuticals|true
5|Metformin|Merck|true
6|Zyrtec|Johnson & Johnson|false
7|Adderall|Shire|true
8|Xanax|Pfizer|true
9|Prozac|Eli Lilly|true
10|Ibuprofen|Bayer|false
11|Claritin|Bayer|false
12|Crestor|AstraZeneca|true
13|Lisinopril|Novartis|true
14|Prednisone|Teva Pharmaceuticals|true
15|Hydroxychloroquine|Sanofi|true
16|Azithromycin|Pfizer|true
17|Tramadol|Amneal Pharmaceuticals|true
18|Fluoxetine|Eli Lilly|true
19|Levothyroxine|Mylan|true
\.

-- Supplier(supplierID, supplierName, rating)
COPY Supplier FROM stdin USING DELIMITERS '|';
1|McKesson|10
2|AmerisourceBergen|3
3|Cardinal Health|7
4|Cencora|6
\.

-- Purchase(purchaseID, customerID, pharmacyID, purchaseTimestamp, totalPrice, creditCardType, creditCardNumber, expirationDate)
COPY Purchase FROM stdin USING DELIMITERS '|';
1|1|22|2023-10-01 10:00:00|50.00|V|123456789|2025-12-31
2|2|33|2023-10-05 14:30:00|25.75|M|987654321|2026-06-30
3|3|11|2023-11-10 09:15:00|100.50|A|112233445|2027-03-31
4|4|44|2023-11-15 12:45:00|75.20|V|556677889|2026-09-30
5|5|55|2023-12-02 16:20:00|45.99|D|667788990|2024-11-30
6|6|22|2023-12-10 11:10:00|80.30|M|778899001|2025-08-31
7|7|33|2024-01-08 13:50:00|60.00|A|889900112|2027-05-31
8|8|11|2024-01-12 15:30:00|35.40|V|990011223|2026-07-31
9|1|55|2024-02-05 17:45:00|95.75|D|111122233|2025-04-30
10|2|44|2024-02-18 08:20:00|20.25|M|222233344|2024-12-31
11|3|33|2024-03-01 10:10:00|110.99|A|333344455|2027-08-31
12|4|22|2024-03-10 14:05:00|55.80|V|444455566|2026-06-30
13|5|11|2024-03-22 09:30:00|40.60|D|555566677|2025-10-31
14|6|55|2024-04-02 18:00:00|70.45|M|\N|2026-03-31
15|7|44|2024-04-12 11:25:00|85.10|A|777788899|2027-01-31
16|8|33|2024-04-20 16:40:00|95.30|V|888899900|2025-09-30
17|1|22|2024-05-05 13:15:00|30.75|D|999900011|2024-11-30
18|2|11|2024-05-15 10:55:00|60.99|M|111100022|2026-12-31
19|3|55|2024-05-28 15:20:00|120.25|A|222200033|2027-04-30
20|4|33|2024-06-07 08:45:00|180.00|V|333300044|2025-06-30
21|5|55|2024-12-02 17:20:00|55.99|D|\N|2024-11-30
\.

-- DrugsInPurchase(purchaseID, drugID, quantity, subtotal, discount)
COPY DrugsInPurchase FROM stdin USING DELIMITERS '|';
1|1|2|20.00|0
1|6|1|30.00|0
2|2|1|10.75|0
2|11|1|15.00|0
3|3|2|100.50|10
4|4|1|40.20|0
4|5|1|35.00|0
5|6|3|45.99|0
6|7|1|30.30|0
6|8|1|30.00|0
7|9|2|60.00|0
7|10|1|20.00|0
8|10|1|15.40|0
8|1|2|20.00|0
9|2|3|45.75|0
9|3|1|50.00|0
10|4|2|20.25|0
11|5|1|60.99|0
11|6|1|50.00|0
12|7|1|55.80|0
13|8|1|40.60|0
14|9|1|25.00|0
14|17|2|35.45|0
15|11|1|40.10|0
15|12|1|45.00|0
16|13|2|95.30|0
17|14|1|10.75|0
17|15|1|20.00|0
18|16|1|30.99|0
18|17|2|30.00|5
19|18|1|55.25|0
19|19|1|55.00|0
20|1|2|25.00|20
20|2|1|10.00|0
20|3|1|50.00|0
20|4|1|15.00|0
20|5|1|35.00|0
20|6|1|45.00|0
21|8|4|55.99|0
\.

-- OrderSupply(pharmacyID, supplierID, drugID, drugPrice, quantity, orderDate, status)
COPY OrderSupply FROM stdin USING DELIMITERS '|';
11|1|1|9.50|100|2023-09-01|cnld
11|1|4|9.50|100|2023-09-02|dlvd
11|1|3|25.50|100|2023-09-01|cnld
11|1|5|25.50|100|2023-09-02|dlvd
11|2|2|8.00|200|2023-09-10|dlvd
11|3|3|25.00|150|2023-09-15|pndg
22|1|4|12.00|120|2023-09-01|dlvd
22|2|5|14.50|80|2023-09-01|dlvd
22|3|6|11.25|100|2023-10-15|cnld
33|1|7|30.00|60|2023-11-01|dlvd
33|2|8|27.50|75|2023-11-03|dlvd
33|4|9|22.00|50|2023-11-10|pndg
44|2|10|6.75|90|2023-12-01|dlvd
44|3|11|7.00|100|2023-12-10|dlvd
44|1|12|26.00|80|2023-12-15|pndg
55|4|13|15.50|60|2024-01-05|dlvd
55|3|14|13.25|70|2024-01-10|dlvd
55|2|15|19.00|65|2024-01-20|dlvd
11|1|16|18.50|90|2024-02-01|pndg
22|4|17|23.00|100|2024-02-10|dlvd
33|3|18|20.00|110|2024-02-18|dlvd
44|2|19|21.75|95|2024-02-25|cnld
55|1|1|9.25|130|2024-03-01|pndg
44|4|9|22.00|10|2024-12-10|pndg
\.
