CREATE EXTENSION "uuid-ossp";

CREATE TABLE product (
  id uuid NOT NULL,
  lookupcode character varying(32) NOT NULL DEFAULT(''),
  count int NOT NULL DEFAULT(0),
  createdon timestamp without time zone NOT NULL DEFAULT now(),
  CONSTRAINT product_pkey PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);

CREATE TYPE Classification AS ENUM ('General Manager', 'Shift Manager', 'Cashier')
CREATE TABLE employee (
  id uuid NOT NULL,
  fName character varying(32) NOT NULL DEFAULT(''),
  lName character varying(32) NOT NULL DEFAULT(''),
  Eid int,
  active boolean,
  role Classification,
  password character varying(32),
  manager int references employee(id),
  createdon timestamp without time zone NOT NULL DEFAULT now(),
  PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);

CREATE INDEX ix_product_lookupcode
  ON product
  USING btree
  (lower(lookupcode::text) COLLATE pg_catalog."default");

INSERT INTO product VALUES (
       uuid_generate_v4()
     , 'lookupcode1'
     , 100
     , current_timestamp
);

INSERT INTO product VALUES (
       uuid_generate_v4()
     , 'lookupcode1'
     , 125
     , current_timestamp
);

INSERT INTO product VALUES (
       uuid_generate_v4()
     , 'lookupcode3'
     , 150
     , current_timestamp
);

--NEW TABLE FOR EMPLOYEE
CREATE TYPE employee_role AS ENUM('gmanager','smanager','cashier');-- general manager, shift manager, cashier.

CREATE TABLE employee (
  id serial NOT NULL,
  fname varchar(32) NOT NULL,
  lname VARCHAR(32) NOT null,
  employeeId VARCHAR(32) NOT NULL,
  status BOOLEAN,--active or inactive
  role employee_role,-- general manager, shift manager, cashier.
  manager VARCHAR (32), -- (NOT SURE) may be blank ( (This is a foreign key to another record in the Employee table, may be empty))
  password varchar (80) NOT NULL,  --save hash 
  createdon timestamp without time zone NOT NULL DEFAULT now(),
  CONSTRAINT record_rkey PRIMARY KEY (id)
);
