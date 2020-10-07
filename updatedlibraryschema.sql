CREATE TABLE "people" (
  "name" varchar,
  "id" serial PRIMARY KEY
);

CREATE TABLE "authors" (
  "title" varchar,
  "author" varchar,
  "id" serial PRIMARY KEY
);

CREATE TABLE "book" (
  "title" varchar,
  "author" varchar,
  "id"  serial PRIMARY KEY
);

CREATE TABLE "authors_books" (
  "id" serial PRIMARY KEY,
  "author_id" integer,
  "book_id" integer
);

CREATE TABLE "checkouts" (
  "id" serial PRIMARY KEY,
  "book_id" integer,
  "people_id" integer,
  "due_date" date
);

ALTER TABLE table_name
ALTER COLUMN column_name [SET DATA] TYPE new_data_type;