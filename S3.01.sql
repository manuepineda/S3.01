SELECT * FROM COMPANY;

SELECT * FROM transaction;


CREATE TABLE IF NOT EXISTS credit_card(
id VARCHAR(15) PRIMARY KEY,
Iban VARCHAR(40),
pan VARCHAR(40), 
pin int, 
cvv INT, 
expiring_date VARCHAR (20)
);


-- Alter the table to modify the data type of the expiring_date column to DATE
ALTER TABLE credit_card
MODIFY COLUMN expiring_date DATE; #changes the data type of an existing column

-- Update the existing date values to the desired format (assuming the current format is MM/DD/YY)
UPDATE credit_card
SET expiring_date = STR_TO_DATE(expiring_date, '%m/%d/%y');

-- Verify the changes
SELECT * FROM credit_card;


Select *
from credit_card;

DROP TABLE credit_card;