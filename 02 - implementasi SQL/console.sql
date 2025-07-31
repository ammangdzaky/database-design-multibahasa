CREATE DATABASE belajar_mysql_multibahasa;

USE belajar_mysql_multibahasa;

CREATE TABLE categories
(
    id       VARCHAR(100) NOT NULL,
    position INT          NOT NULL,
    PRIMARY KEY (id)
) ENGINE = InnoDB;

DESCRIBE categories;

INSERT INTO categories(id, position)
VALUES ('FOOD', 1);
INSERT INTO categories(id, position)
VALUES ('FASHION', 2);
INSERT INTO categories(id, position)
VALUES ('GADGET', 3);

SELECT *
FROM categories
ORDER BY position;

CREATE TABLE categories_translations
(
    category_id VARCHAR(100) NOT NULL,
    language    VARCHAR(100) NOT NULL,
    name        VARCHAR(100) NOT NULL,
    description TEXT,
    PRIMARY KEY (category_id, language)
) ENGINE = InnoDB;

SHOW CREATE TABLE categories_translations;

ALTER TABLE categories_translations
    ADD CONSTRAINT fk_categories_translation_categories
        FOREIGN KEY (category_id) REFERENCES categories (id);


-- menambahkan language ke category translation

INSERT INTO categories_translations(category_id, language, name, description)
VALUES ('FOOD', 'in_ID', 'Makanan', 'Deskripsi makanan');

INSERT INTO categories_translations(category_id, language, name, description)
VALUES ('FOOD', 'en_US', 'Food', 'Food description');

INSERT INTO categories_translations(category_id, language, name, description)
VALUES ('FASHION', 'in_ID', 'Fesyen', 'Deskripsi fesyen');

INSERT INTO categories_translations(category_id, language, name, description)
VALUES ('FASHION', 'en_US', 'Fashion', 'Fashion description');


-- menampilkan daftar kategori dalam bahasa indonesia
SELECT *
FROM categories
         JOIN categories_translations ON (categories.id = categories_translations.category_id)
WHERE language = 'in_ID'
ORDER BY position;

-- menampilkan daftar kategori dalam bahasa ingris
SELECT *
FROM categories
         JOIN categories_translations ON (categories.id = categories_translations.category_id)
WHERE language = 'en_US'
ORDER BY position;