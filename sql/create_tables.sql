CREATE TABLE "products" (
    "product_id" varchar(20)   NOT NULL,
    "product_name" varchar(50)   NOT NULL,
    "category_id" varchar(20)   NOT NULL,
    "launch_date" date   NOT NULL,
    "price" int   NOT NULL,
    CONSTRAINT "pk_products" PRIMARY KEY (
        "product_id"
     )
);

CREATE TABLE "category" (
    "category_id" varchar(20)   NOT NULL,
    "category_name" varchar(50)   NOT NULL,
    CONSTRAINT "pk_category" PRIMARY KEY (
        "category_id"
     )
);

CREATE TABLE "sales" (
    "sale_id" varchar(50)   NOT NULL,
    "sale_date" date   NOT NULL,
    "store_id" varchar(20)   NOT NULL,
    "product_id" varchar(20)   NOT NULL,
    "quantity" int   NOT NULL,
    CONSTRAINT "pk_sales" PRIMARY KEY (
        "sale_id"
     )
);

CREATE TABLE "stores" (
    "store_id" varchar(20)   NOT NULL,
    "store_name" varchar(50)   NOT NULL,
    "city" varchar(20)   NOT NULL,
    "country" varchar(20)   NOT NULL,
    CONSTRAINT "pk_stores" PRIMARY KEY (
        "store_id"
     )
);

CREATE TABLE "warrandy" (
    "claim_id" varchar(20)   NOT NULL,
    "claim_date" date   NOT NULL,
    "sale_id" varchar(50)   NOT NULL,
    "repair_status" varchar(20)   NOT NULL,
    CONSTRAINT "pk_warrandy" PRIMARY KEY (
        "claim_id"
     )
);

ALTER TABLE "products" ADD CONSTRAINT "fk_products_category_id" FOREIGN KEY("category_id")
REFERENCES "category" ("category_id");

ALTER TABLE "sales" ADD CONSTRAINT "fk_sales_store_id" FOREIGN KEY("store_id")
REFERENCES "stores" ("store_id");

ALTER TABLE "sales" ADD CONSTRAINT "fk_sales_product_id" FOREIGN KEY("product_id")
REFERENCES "products" ("product_id");

ALTER TABLE "warrandy" ADD CONSTRAINT "fk_warrandy_sale_id" FOREIGN KEY("sale_id")
REFERENCES "sales" ("sale_id");

