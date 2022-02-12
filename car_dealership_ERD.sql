 -- Designed by Justin Rittenhouse and Hamilton White
 CREATE TABLE "salesperson" (
	"salesperson_id" serial NOT NULL,
	"first_name" varchar(255) NOT NULL,
	"last_name" varchar(255) NOT NULL,
	CONSTRAINT "salesperson_pk" PRIMARY KEY ("salesperson_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "cars_for_sale" (
	"car_for_sale_id" serial NOT NULL,
	"make" TEXT NOT NULL,
	"model" TEXT NOT NULL,
	"color" TEXT NOT NULL,
	"year" int NOT NULL,
	"salesperson_id" int NOT NULL,
	CONSTRAINT "cars_for_sale_pk" PRIMARY KEY ("car_for_sale_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "customer" (
	"customer_id" serial NOT NULL,
	"first_name" varchar(255) NOT NULL,
	"last_Name" varchar(255) NOT NULL,
	"email" varchar(255) NOT NULL,
	"phone_number" int NOT NULL UNIQUE,
	CONSTRAINT "customer_pk" PRIMARY KEY ("customer_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "invoice" (
	"invoice_id" serial NOT NULL,
	"customer_id" int NOT NULL,
	"salesperson_id" int NOT NULL,
	"car_for_sale_id" int NOT NULL,
	"amount" DECIMAL NOT NULL,
	CONSTRAINT "invoice_pk" PRIMARY KEY ("invoice_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "service_history" (
	"service_ticket_id" serial NOT NULL,
	"mechanic_id" int NOT NULL,
	"car_id" int NOT NULL,
	"amount" DECIMAL NOT NULL,
	CONSTRAINT "service_history_pk" PRIMARY KEY ("service_ticket_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "car_in_for_service" (
	"car_service_id" serial NOT NULL,
	"make" TEXT NOT NULL,
	"model" TEXT NOT NULL,
	"color" TEXT NOT NULL,
	"year" int NOT NULL,
	"customer_id" int NOT NULL,
	CONSTRAINT "car_in_for_service_pk" PRIMARY KEY ("car_service_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "mechanics" (
	"mechanic" serial NOT NULL,
	"first_name" varchar(255) NOT NULL,
	"last_name" varchar(255) NOT NULL,
	CONSTRAINT "mechanics_pk" PRIMARY KEY ("mechanic")
) WITH (
  OIDS=FALSE
);

-- Note: This detail spawned from a misunderstanding, but it turned into a feature of our shop.
-- Each salesperson is responsible for a specific vehicle here. Who are you to judge our business model?
ALTER TABLE "public"."cars_for_sale" ADD CONSTRAINT "cars_for_sale_fk0" FOREIGN KEY ("salesperson_id") REFERENCES "public"."salesperson"("salesperson_id");

ALTER TABLE "public"."invoice" ADD CONSTRAINT "invoice_fk0" FOREIGN KEY ("customer_id") REFERENCES "public"."customer"("customer_id");
ALTER TABLE "public"."invoice" ADD CONSTRAINT "invoice_fk1" FOREIGN KEY ("salesperson_id") REFERENCES "public"."salesperson"("salesperson_id");
ALTER TABLE "public"."invoice" ADD CONSTRAINT "invoice_fk2" FOREIGN KEY ("car_for_sale_id") REFERENCES "public"."cars_for_sale"("car_for_sale_id");

ALTER TABLE "public"."service_history" ADD CONSTRAINT "service_history_fk0" FOREIGN KEY ("mechanic_id") REFERENCES "public"."mechanics"("mechanic");
ALTER TABLE "public"."service_history" ADD CONSTRAINT "service_history_fk1" FOREIGN KEY ("car_id") REFERENCES "public"."car_in_for_service"("car_service_id");

ALTER TABLE "public"."car_in_for_service" ADD CONSTRAINT "car_in_for_service_fk0" FOREIGN KEY ("customer_id") REFERENCES "public"."customer"("customer_id");

-- Whoopsie Solving and Nitpicking
alter table "customer" rename column "last_Name" to "last_name";
alter table "cars_for_sale" rename column "year" to "make_year";
alter table "car_in_for_service" rename column "year" to "make_year";
alter table "service_history" add "part_needed" varchar(255);
alter table "customer" drop "phone_number";
alter table "customer" add "phone_number" varchar(255);