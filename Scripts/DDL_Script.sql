
-- -----------------------------------------------------
-- Schema e-commerce_database
-- -----------------------------------------------------
CREATE DATABASE e_commerce_database

USE e_commerce_database

-- -----------------------------------------------------
-- Table `e-commerce_database`.`customer`
-- -----------------------------------------------------
CREATE TABLE Customer(
  CustomerId INT NOT NULL,
  FirstName	 VARCHAR(45) NOT NULL,
  LastName	 VARCHAR(45) NOT NULL,
  DOB		 DATE NOT NULL,
  Gender	 VARCHAR(6) NOT NULL,
  PhoneId	 VARCHAR(15) NULL DEFAULT NULL,
  EmailId	 VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (CustomerId));

-- -----------------------------------------------------
-- Table `e-commerce_database`.`Address`
-- -----------------------------------------------------

CREATE TABLE Address(
	AddressID INT NOT NULL,
	Line1 VARCHAR(45),
	Line2 VARCHAR(45),
	City  VARCHAR(45),
	State VARCHAR(45),
	Zip   INT NOT NULL,
	Country VARCHAR(45),
	PRIMARY KEY (AddressId)
	)
-- -----------------------------------------------------
-- Table `e_commerce_database`.`CustomerHasAddress`
-- -----------------------------------------------------
CREATE TABLE CustomerHasAddress (
    CustomerId INT NOT NULL,
	AddressId INT NOT NULL,
	PRIMARY KEY(CustomerId,AddressId),
	CONSTRAINT FK1_CustomerId
	FOREIGN KEY (CustomerId) REFERENCES Customer(CustomerId),
	CONSTRAINT FK2_AddressId
	FOREIGN KEY (AddressId) REFERENCES Address(AddressId)
)

-- -----------------------------------------------------
-- Table `e-commerce_database`.`Payment`
-- -----------------------------------------------------

CREATE TABLE Payment (
  PaymentId INT NOT NULL,
  CustomerId INT NOT NULL,
  OrderId INT NOT NULL,
  AddressId INT NOT NULL,
  BillingDate DATE,
  PRIMARY KEY (PaymentId),
  CONSTRAINT FK1_CustomerPayment FOREIGN KEY (CustomerId) REFERENCES Customer(CustomerId),
  CONSTRAINT FK2_OrderPayment    FOREIGN KEY (OrderId) REFERENCES Orders(OrderId),
  CONSTRAINT FK3_AddressPayment  FOREIGN KEY (AddressId) REFERENCES Address(AddressId)
);

-- -----------------------------------------------------
-- Table `e-commerce_database`.`PaymentDetails`
-- -----------------------------------------------------
CREATE TABLE PaymentDetails(
	PaymentDetailsId INT NOT NULL,
	PaymentId INT NOT NULL,
	CardNumber VARCHAR(16),
	CardHolderName VARCHAR(45),
	BankName VARCHAR(45),
	ExpMonth VARCHAR(45),
	ExpYear VARCHAR(45),
	PRIMARY KEY (PaymentDetailsId,PaymentId),
	CONSTRAINT FK1_PaymentId
	FOREIGN KEY (PaymentId) REFERENCES Payment(PaymentId),
)

ALTER TABLE PaymentDetails
ALTER COLUMN CardNumber VARCHAR(25)
-- -----------------------------------------------------
-- Table `e_commerce_database`.`Orders`
-- -----------------------------------------------------

CREATE TABLE Orders(
 OrderId INT NOT NULL,
 CustomerId INT NOT NULL,
 ShipperId INT NOT NULL,
 OrderDate DATE,
 Amount DECIMAL(12,2),
 PRIMARY KEY (OrderId),
 CONSTRAINT FK1_CustomerOrder 
 FOREIGN KEY (CustomerId) REFERENCES Customer(CustomerId),
 CONSTRAINT FK2_ShipperOrder
 FOREIGN KEY (ShipperId) REFERENCES ShippingDetails(ShipperId),
)

-- -----------------------------------------------------
-- Table `e_commerce_database`.`OrderLine`
-- -----------------------------------------------------
CREATE TABLE OrderLine (
OrderLineId INT NOT NULL,
OrderId INT NOT NULL,
ProductId INT NOT NULL,
Quantity INT NOT NULL,
TotalPrice Decimal(12,2),
PRIMARY KEY (OrderLineId),
CONSTRAINT FK1_OrdersOrderLine 
FOREIGN KEY (OrderId) REFERENCES Orders(OrderId),
CONSTRAINT FK2_ProductOrderLine
FOREIGN KEY (ProductId) REFERENCES Product(ProductId),
)

-- -----------------------------------------------------
-- Table `e_commerce_database`.`Product`
-- -----------------------------------------------------
CREATE TABLE Product(
	ProductId INT NOT NULL,
	ManufactureId INT NOT NULL,
	CategoryId INT NOT NULL,
	ProductName VARCHAR (45),
	ProductDescription VARCHAR(45),
	DiscountAvailable VARCHAR(45),
	Color VARCHAR(45),
	Price Decimal(12,2),
	Availability VARCHAR(45),
PRIMARY KEY (ProductId),
CONSTRAINT FK1_ManufactureProduct 
FOREIGN KEY (ManufactureId) REFERENCES Manufacturer(ManufactureId),
CONSTRAINT FK2_CategoryProduct
FOREIGN KEY (CategoryId) REFERENCES Category(CategoryId),
)

-- -----------------------------------------------------
-- Table `e_commerce_database`.`Manufacture`
-- -----------------------------------------------------
CREATE TABLE Manufacturer(
	ManufactureId INT NOT NULL,
	ManufactureName VARCHAR(45),
	PRIMARY KEY (ManufactureId),
)

-- -----------------------------------------------------
-- Table `e_commerce_database`.`Category`
-- -----------------------------------------------------
CREATE TABLE Category(
	CategoryId INT NOT NULL,
	CategoryName VARCHAR(45),
	PRIMARY KEY (CategoryId),
	)
-- -----------------------------------------------------
-- Table `e_commerce_database`.`ShippingDetails`
-- -----------------------------------------------------
CREATE TABLE ShippingDetails (
	ShipperId INT NOT NULL,
	AddressId INT NOT NULL,
	DeliveryBoyId INT NOT NULL,
	ShippingDate DATE,
	PRIMARY KEY (ShipperId),
	CONSTRAINT FK1_AddressShipping
	FOREIGN KEY (AddressId) REFERENCES Address(AddressId),
	CONSTRAINT FK2_DeliveryBoyShipping
	FOREIGN KEY (DeliveryBoyId) REFERENCES DeliveryBoy (DeliveryBoyId)
)

-- -----------------------------------------------------
-- Table `e_commerce_database`.`DeliveryBoy`
-- -----------------------------------------------------

CREATE TABLE DeliveryBoy (
  
  DeliveryBoyId INT NOT NULL,
  FirstName	 VARCHAR(45) NOT NULL,
  LastName	 VARCHAR(45) NOT NULL,
  DOB		 DATE NOT NULL,
  Gender	 VARCHAR(6) NOT NULL,
  PhoneId	 VARCHAR(15) NULL DEFAULT NULL,
  EmailId	 VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (DeliveryBoyId)
)

-- -----------------------------------------------------
-- Table `e_commerce_database`.`Supplier`
-- -----------------------------------------------------
CREATE TABLE Supplier (
	SupplierId INT NOT NULL,
	AddressId INT NOT NULL,
	CompanyName VARCHAR(45),
	PhoneNumber VARCHAR(45),
	Email VARCHAR(45),
PRIMARY KEY (SupplierId),
CONSTRAINT FK_AddressId
FOREIGN KEY (AddressId) REFERENCES Address(AddressId)
)

-- -----------------------------------------------------
-- Table `e_commerce_database`.`SupplierContact`
-- -----------------------------------------------------
CREATE TABLE SupplierContact (
	SupplierContactId INT NOT NULL,
	SupplierId INT NOT NULL,
	ContactFName VARCHAR(45),
	ContactLName VARCHAR(45),
	PhoneNumber VARCHAR(45),
	Email VARCHAR(45),
	Age VARCHAR(45),
	Gender VARCHAR(6),
PRIMARY KEY (SupplierContactId),
CONSTRAINT FK_SupplierId
FOREIGN KEY (SupplierId) REFERENCES Supplier(SupplierId)
)

EXEC sp_rename 'SupplierContact.Age', 'DOB', 'COLUMN';
SELECT * FROM SupplierContact;
-- -----------------------------------------------------
-- Table `e_commerce_database`.`SupplierContactHasAddress`
-- -----------------------------------------------------

CREATE TABLE SupplierContactHasAddress(
 SupplierContactId INT NOT NULL,
 AddressId INT NOT NULL,
 PRIMARY KEY(SupplierContactId,AddressId),
 CONSTRAINT FK1_SupplierContactId
 FOREIGN KEY (SupplierContactId) REFERENCES SupplierContact(SupplierContactId),
 CONSTRAINT FK2_AddressIdSupplierContact
 FOREIGN KEY (AddressId) REFERENCES Address(AddressId)
)

-- -----------------------------------------------------
-- Table `e_commerce_database`.`Supply`
-- -----------------------------------------------------
CREATE TABLE Supply (
	ProductId INT NOT NULL,
	SupplierContactId INT NOT NULL,
	Quantity INT,
	SupplyDate DATE,
	PRIMARY KEY (ProductId,SupplierContactId),
	CONSTRAINT FK1_ProductIdSupply
	FOREIGN KEY (ProductId) REFERENCES Product(ProductId),
	CONSTRAINT FK2_SupplierContactIdSupply
	FOREIGN KEY (SupplierContactId) REFERENCES SupplierContact(SupplierContactId)

)

USE e_commerce_database


ALTER TABLE PaymentDetails
DROP COLUMN TypeCard

