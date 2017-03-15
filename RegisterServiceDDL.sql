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

CREATE TABLE employee (
  id uuid NOT NULL,
  employeeid character varying(32) NOT NULL DEFAULT(''),
  firstname character varying(128) NOT NULL DEFAULT(''),
  lastname character varying(128) NOT NULL DEFAULT(''),
  password character varying(512) NOT NULL DEFAULT(''),
  active boolean NOT NULL DEFAULT(FALSE), 
  classification int NOT NULL DEFAULT(0),
  managerid uuid NOT NULL,
  createdon timestamp without time zone NOT NULL DEFAULT now(),
  CONSTRAINT employee_pkey PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);

CREATE INDEX ix_employee_employeeid
  ON employee
  USING hash(employeeid);

