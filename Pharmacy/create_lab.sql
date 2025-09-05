-- CSE 182 Spring 2025 Lab4 create file

DROP SCHEMA Lab4 CASCADE;
CREATE SCHEMA Lab4;


CREATE TABLE Customer(
  customerID INT PRIMARY KEY,
  customerName VARCHAR(40),
  address VARCHAR(50),
  dateOfBirth DATE,
  healthInsuranceName VARCHAR(40)
);

CREATE TABLE Pharmacy(
  pharmacyID INT PRIMARY KEY,
  address VARCHAR(50),
  openTime TIME,
  closeTime TIME,
  numEmployees INT
);

CREATE TABLE Drug(
  drugID INT PRIMARY KEY,
  drugName VARCHAR(40),
  manufacturer VARCHAR(40),
  prescriptionRequired BOOLEAN
);


CREATE TABLE Supplier(
  supplierID INT PRIMARY KEY,
  supplierName VARCHAR(40),
  rating INT
);

CREATE TABLE Purchase(
  purchaseID INT PRIMARY KEY,
  customerID INT,
  pharmacyID INT,
  purchaseTimestamp TIMESTAMP,
  totalPrice NUMERIC(8, 2),
  creditCardType CHAR(1),
  credidCardNumber INT,
  expirationDate DATE,
  FOREIGN KEY (customerID) REFERENCES Customer(customerID),
  FOREIGN KEY (pharmacyID) REFERENCES Pharmacy(pharmacyID)
);

CREATE TABLE DrugsInPurchase(
  purchaseID INT,
  drugID INT,
  quantity INT,
  subtotal NUMERIC(8, 2),
  discount INT,
  PRIMARY KEY (purchaseID, drugID),
  FOREIGN KEY (purchaseID) REFERENCES Purchase(purchaseID),
  FOREIGN KEY (drugID) REFERENCES Drug(drugID)
);

CREATE TABLE OrderSupply(
  pharmacyID INT,
  supplierID INT,
  drugID INT,
  drugPrice NUMERIC(8, 2),
  quantity INT,
  orderDate DATE,
  status CHAR(20),
  PRIMARY KEY (pharmacyID, supplierID, drugID),
  FOREIGN KEY (pharmacyID) REFERENCES Pharmacy(pharmacyID),
  FOREIGN KEY (supplierID) REFERENCES Supplier(supplierID),
  FOREIGN KEY (drugID) REFERENCES Drug(drugID)
);
