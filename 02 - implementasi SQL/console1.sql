-- DDL
CREATE TABLE Artis (
    id_artis INT AUTO_INCREMENT PRIMARY KEY,
    nama_artis VARCHAR(100) NOT NULL
);

CREATE TABLE Genre (
    id_genre INT PRIMARY KEY,
    nama_genre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Album (
    id_album INT AUTO_INCREMENT PRIMARY KEY,
    judul_album VARCHAR(100) NOT NULL,
    tahun_rilis SMALLINT NOT NULL,
    id_artis INT NOT NULL,
    FOREIGN KEY (id_artis) REFERENCES Artis(id_artis)
);

CREATE TABLE Lagu (
    id_lagu INT AUTO_INCREMENT PRIMARY KEY,
    judul_lagu VARCHAR(150) NOT NULL,
    durasi_detik SMALLINT NOT NULL,
    id_album INT, -- NULLable jika lagu adalah single
    id_genre INT NOT NULL,
    FOREIGN KEY (id_album) REFERENCES Album(id_album),
    FOREIGN KEY (id_genre) REFERENCES Genre(id_genre)
);

CREATE TABLE Lagu_Artis (
    id_lagu INT NOT NULL,
    id_artis INT NOT NULL,
    peran ENUM('Vokalis', 'Produser', 'Pencipta') NOT NULL,
    PRIMARY KEY (id_lagu, id_artis),
    FOREIGN KEY (id_lagu) REFERENCES Lagu(id_lagu),
    FOREIGN KEY (id_artis) REFERENCES Artis(id_artis)
);

CREATE INDEX idx_album_artis ON Album (id_artis);
CREATE INDEX idx_lagu_album ON Lagu (id_album);
CREATE INDEX idx_lagu_genre ON Lagu (id_genre);
CREATE INDEX idx_la_artis ON Lagu_Artis (id_artis);


-- DML
INSERT INTO Genre (id_genre, nama_genre) VALUES
(10, 'Pop'),
(20, 'Folk'),
(30, 'Rock');

INSERT INTO Artis (nama_artis) VALUES
('Sheila On 7'),
('Tulus'),
('Fiersa Besari');

INSERT INTO Album (judul_album, tahun_rilis, id_artis) VALUES
('Pejantan Tangguh', 2004, 1),
('Monokrom', 2016, 2);

INSERT INTO Lagu (judul_lagu, durasi_detik, id_album, id_genre) VALUES
('Seberapa Pantas', 245, 1, 30),
('Monokrom', 216, 2, 10),
('Celengan Rindu', 230, NULL, 20);

INSERT INTO Lagu_Artis (id_lagu, id_artis, peran) VALUES
(1, 1, 'Vokalis'),
(2, 2, 'Vokalis'),
(3, 3, 'Vokalis');

SELECT * FROM Lagu;

-- Query Kompleks (JOIN)
SELECT 
    L.judul_lagu,
    AR.nama_artis
FROM 
    Lagu L
JOIN 
    Lagu_Artis LA ON L.id_lagu = LA.id_lagu
JOIN 
    Artis AR ON LA.id_artis = AR.id_artis
WHERE 
    L.id_album IS NULL;


-- DELETE
DELETE FROM Lagu_Artis 
WHERE id_lagu = 1;

DELETE FROM Lagu 
WHERE id_lagu = 1;
