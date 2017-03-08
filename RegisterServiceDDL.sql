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
  fname VARCHAR(32) NOT NULL,
  lname VARCHAR(32) NOT NULL,
  employeeId VARCHAR(32) NOT NULL,
  status BOOLEAN,--active or inactive
  role employee_role,-- general manager, shift manager, cashier.
  manager int references employee(id), -- I believe that this is how make manager a foreign key
  password VARCHAR (80) NOT NULL,  --save hash 
  createdon timestamp without time zone NOT NULL DEFAULT now(),
  CONSTRAINT record_rkey PRIMARY KEY (id)
  ) WITH (	
  OIDS=FALSE		--This is in the provided table so I thought it would be a good idea to include it
);
