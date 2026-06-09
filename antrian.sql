CREATE DATABASE IF NOT EXISTS db_antrian;
USE db_antrian;

-- =========================
-- TABEL USER
-- =========================
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin','petugas') DEFAULT 'petugas',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- TABEL LOKET
-- =========================
CREATE TABLE loket (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama_loket VARCHAR(50) NOT NULL,
    status ENUM('aktif','nonaktif') DEFAULT 'aktif'
);

-- =========================
-- TABEL ANTRIAN
-- =========================
CREATE TABLE antrian (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nomor_antrian INT NOT NULL,
    status ENUM('menunggu','dipanggil','selesai') DEFAULT 'menunggu',
    loket_id INT NULL,
    waktu_ambil TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    waktu_panggil DATETIME NULL,
    waktu_selesai DATETIME NULL,

    CONSTRAINT fk_antrian_loket
    FOREIGN KEY (loket_id)
    REFERENCES loket(id)
    ON DELETE SET NULL
    ON UPDATE CASCADE
);

-- =========================
-- DATA AWAL USER
-- =========================
INSERT INTO users (nama, username, password, role)
VALUES
('Administrator', 'admin', MD5('admin123'), 'admin');

-- =========================
-- DATA AWAL LOKET
-- =========================
INSERT INTO loket (nama_loket)
VALUES
('Loket 1'),
('Loket 2'),
('Loket 3');

-- =========================
-- DATA CONTOH ANTRIAN
-- =========================
INSERT INTO antrian
(nomor_antrian, status, loket_id)
VALUES
(1,'menunggu',NULL),
(2,'menunggu',NULL),
(3,'menunggu',NULL),
(4,'menunggu',NULL),
(5,'menunggu',NULL);

-- =========================
-- VIEW DASHBOARD
-- =========================
CREATE VIEW v_dashboard AS
SELECT
    COUNT(*) AS total_antrian,
    SUM(status='menunggu') AS total_menunggu,
    SUM(status='dipanggil') AS total_dipanggil,
    SUM(status='selesai') AS total_selesai
FROM antrian;