SELECT * FROM COMPANY;

SELECT * FROM transaction;

Select * from credit_card;

DROP TABLE credit_card;

#orden seguido: Primero creamos las tablas con PKS (COMPANY Y CREDIT_CARD)
#luego creo transaction, que contiene las FK de company y credit_card


CREATE TABLE IF NOT EXISTS credit_card(
id VARCHAR(50) PRIMARY KEY,
Iban VARCHAR(40),
pan VARCHAR(40), 
pin int, 
cvv INT, 
expiring_date VARCHAR (20) #usamos varchar para que no de error en el DATE
);

#NIVEL 1

#Ejercicio 1

-- Alter the table to modify the data type of the expiring_date column to DATE
ALTER TABLE credit_card
MODIFY COLUMN expiring_date DATE; #changes the data type of an existing column

-- Update the existing date values to the desired format (assuming the current format is MM/DD/YY)
UPDATE credit_card
SET expiring_date = STR_TO_DATE(expiring_date, '%m/%d/%y');

-- Verify the changes
SELECT * FROM credit_card;

#Ejercicio 2

UPDATE credit_card
SET IBAN = "R323456312213576817699999" #el cambio que quieres introducir
WHERE ID = "CcU-2938"; #donde se va a cambiar

-- Verify the changes
SELECT * FROM credit_card;

#o tambien así

SELECT * from credit_card WHERE id = "CcU-2938";

#Ejercicio 3

INSERT INTO company (id)
VALUES ("b-9999"); 

INSERT INTO credit_card (id)
VALUES ("CcU-9999"); 

INSERT INTO transaction (id, credit_card_id, company_id, user_id, lat, longitude, amount, declined) #en el isnert into pones los nombres de las columnas
VALUES ("108B1D1D-5B23-A76C-55EF-C568E49A99DD", "CcU-9999","b-9999","9999","829.999", "-117.999", "	111.11", "0"); #y aqui los valores

#da error, porque para poder añadir datos nuevos en transaction, en concreto en los campos 
#credit card id u company id, tienen que existir datos en las PK, osea que hay que añadir estos datos en
#las tablas company y credit card id!

SELECT * FROM transaction where id = "108B1D1D-5B23-A76C-55EF-C568E49A99DD";

#Ejercicio 4

Alter table credit_card
DROP COLUMN pan;

SELECT * FROM credit_card;

DELETE FROM company WHERE ID =  "CcU-9999"; #arreglando fallos

DELETE FROM credit_card WHERE ID =  "108B1D1D-5B23-A76C-55EF-C568E49A99DD";

#NIVEL 2

#EJ1

DELETE FROM transaction WHERE ID =  "02C6201E-D90A-1859-B4EE-88D2986D3B02";

select * FROM TRANSACTION WHERE ID =  "02C6201E-D90A-1859-B4EE-88D2986D3B02";
#no muestra nada, por tanto esta bien

#ej2









