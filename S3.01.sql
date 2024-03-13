SELECT * FROM COMPANY;
SELECT * FROM transaction;
Select * FROM credit_card;
SELECT * FROM user;

#drop table transaction;
#drop table COMPANY;
#drop table CREDIT_CARD;

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

#NIVEL 2

#EJ1

DELETE FROM transaction WHERE ID =  "02C6201E-D90A-1859-B4EE-88D2986D3B02";

select * FROM TRANSACTION WHERE ID =  "02C6201E-D90A-1859-B4EE-88D2986D3B02";
#no muestra nada, por tanto esta bien

#ej2

CREATE VIEW VistaMarketing AS
select company.company_name, company.phone, company.country, avg(transaction.amount) AS media_compra
from company
JOIN transaction
ON transaction.company_id = company.id
group by  company.company_name, company.phone, company.country
order by media_compra DESC;

select * FROM VistaMarketing;

#EJ3

Select company_name, country 
FROM VistaMarketing
WHERE country = "Germany";

#NIVEL 3

#ej1

DROP TABLE transaction; #eliminamos la anterior
DROP table company; 
DROP TABLE credit_card; 
#tendremos que eliminar company tmb porque dades_introduir inserta los datos 
#simultaneamente a ambas

#Elimino las tablas y las creo de nuevo, ya que estamos introduciendola nueva tabla user

#Primero creo las tablas con PK y por ultimo la transaction table, que contiene las FK 

    CREATE TABLE IF NOT EXISTS company (
        id VARCHAR(15) PRIMARY KEY,
        company_name VARCHAR(255),
        phone VARCHAR(15),
        email VARCHAR(100),
        country VARCHAR(100),
        website VARCHAR(255)
    );

    CREATE TABLE IF NOT EXISTS credit_card(
id VARCHAR(50) PRIMARY KEY,
Iban VARCHAR(40),
pan VARCHAR(40), 
pin int, 
cvv INT, 
expiring_date VARCHAR (20) #usamos varchar para que no de error en el DATE
);


CREATE INDEX idx_user_id ON transaction(user_id);
 
CREATE TABLE IF NOT EXISTS user (
        id INT PRIMARY KEY,
        name VARCHAR(100),
        surname VARCHAR(100),
        phone VARCHAR(150),
        email VARCHAR(150),
        birth_date VARCHAR(100),
        country VARCHAR(150),
        city VARCHAR(150),
        postal_code VARCHAR(100),
        address VARCHAR(255),
        FOREIGN KEY(id) REFERENCES transaction(user_id)        
    );



    CREATE TABLE IF NOT EXISTS transaction ( #la volvemos a crear, ahora con user id como FK
        id VARCHAR(255) PRIMARY KEY,
        credit_card_id VARCHAR(15) REFERENCES credit_card(id),
        company_id VARCHAR(20), 
        user_id INT REFERENCES user(id),
        lat FLOAT,
        longitude FLOAT,
        timestamp TIMESTAMP,
        amount DECIMAL(10, 2),
        declined BOOLEAN,
       FOREIGN KEY (company_id) REFERENCES company(id), 
	   FOREIGN KEY (credit_card_id) REFERENCES credit_card(id)
    );
    
#EJ2

CREATE VIEW InformeTecnico AS
SELECT transaction.id AS ID_Transaccion, user.name AS nombre, user.surname AS apellido, credit_card.Iban AS IBAN, company.company_name AS compañia
FROM transaction
JOIN company
ON transaction.company_id = company.id
JOIN user 
ON transaction.user_id = user.id
JOIN credit_card 
ON transaction.credit_card_id = credit_card.id;

Select *  FROM InformeTecnico;





    
    
    


