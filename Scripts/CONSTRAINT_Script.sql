USE e_commerce_database;

------------------------------------------------------
-------------TABLE LEVEL CHECK CONSTRAINT-------------------
------------------------------------------------------

--------------------------------------------------------
------------- TABLE CUSTOMER ---------------------------
--------------------------------------------------------

ALTER TABLE Customer
ADD CONSTRAINT CHK_CustomerGender CHECK (Gender = 'Male' OR Gender = 'Female' OR Gender = 'Other');


---------------------------------------------------------
-------------TABLE DeliveryBoy---------------------------
---------------------------------------------------------

ALTER TABLE DeliveryBoy
ADD CONSTRAINT CHK_DeliveryBoyGender CHECK (Gender = 'Male' OR Gender = 'Female' OR Gender = 'Other');




