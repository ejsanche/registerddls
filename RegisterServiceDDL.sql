CREATE EXTENSION "uuid-ossp";

CREATE TABLE product (
	price numeric CHECK (price > 0),                         /* item price cannot be zero or less */
	status boolean,
	id uuid NOT NULL,
	lookupcode character varying(32) NOT NULL DEFAULT(''),
	quantity int NOT NULL DEFAULT(0),
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
	
CREATE TYPE e_transaction AS ENUM (
	'return',
	'sale'
)

CREATE TABLE transaction_table (                                         /* transaction is apparently a key word */
	record_id numeric NOT NULL,
	cashier_id character varying (32) references employee(employeeid),
	total_amount numeric CHECK (price > 0),                              /* cost should never be less than or equal to zero */
	transaction_type e_transaction NOT NULL,                              /* sales are probably more common */
	reference_id numeric NOT NULL,                                       /* should reference something, but that table doesn't exist yet */
	created_on timestamp without time zone NOT NULL DEFAULT now(),
	CONSTRAINT primary_record PRIMARY KEY (record_id)
) WITH (
	OIDS=FALSE
);

CREATE TABLE transaction_entry (
	record_id numeric NOT NULL references transaction_table(record_id),
	product_sold integer[] references product(id),
	num_sold integer[],
	price_sold integer[],
	CONSTRAINT TE_PK PRIMARY KEY (record_id)
) WITH (
	OIDS=FALSE
);
