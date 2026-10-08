CREATE DATABASE eticaret_db;

CREATE TABLE Kategori (
    kategori_id INT AUTO_INCREMENT PRIMARY KEY,
    kategori_adi VARCHAR(100) NOT NULL
);

CREATE TABLE Musteri (
    musteri_id INT AUTO_INCREMENT PRIMARY KEY,
    ad VARCHAR(50) NOT NULL,
    soyad VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    kayit_tarihi DATE NOT NULL
);

CREATE TABLE Urun (
    urun_id INT AUTO_INCREMENT PRIMARY KEY,
    urun_adi VARCHAR(150) NOT NULL,
    kategori_id INT,
    fiyat DECIMAL(10,2) NOT NULL,
    stok_miktari INT NOT NULL,
    kritik_stok_seviyesi INT NOT NULL,
    FOREIGN KEY (kategori_id) REFERENCES Kategori(kategori_id)
);

CREATE TABLE Siparis (
    siparis_id INT AUTO_INCREMENT PRIMARY KEY,
    musteri_id INT,
    urun_id INT,
    siparis_tarihi DATETIME NOT NULL,
    adet INT NOT NULL,
    toplam_tutar DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (musteri_id) REFERENCES Musteri(musteri_id),
    FOREIGN KEY (urun_id) REFERENCES Urun(urun_id)
);

INSERT INTO Kategori (kategori_adi) VALUES
('Bilgisayar'), 
('Yazılım & Lisans'), 
('Ağ Donanımları'), 
('Bileşen & Parça'),
('Çevre Birimleri'), 
('Akıllı Telefon'), 
('Giyilebilir Teknoloji'),
('Veri Depolama'), 
('Sunucu Sistemleri'), 
('Eğitim Kaynakları');

INSERT INTO Musteri (ad, soyad, email, kayit_tarihi) VALUES
('Ahmet', 'Yılmaz', 'ahmet.y@gmail.com', '2025-10-15'),
('Ayşe', 'Demir', 'ayse.demir@gmail.com', '2025-11-02'),
('Mehmet', 'Kaya', 'mehmet.k@gmail.com', '2025-11-20'),
('Fatma', 'Çelik', 'fatma.c@gmail.com', '2025-12-05'),
('Alperen', 'Ünaldı', 'alperen.u@gmail.com', '2026-01-10'),
('Zeynep', 'Şahin', 'zeynep.s@gmail.com', '2026-01-15'),
('Burak', 'Öztürk', 'burak.o@gmail.com', '2026-02-28'),
('Elif', 'Yıldız', 'elif.y@gmail.com', '2026-03-10'),
('Can', 'Özkan', 'can.o@gmail.com', '2026-04-05'),
('Gizem', 'Aydın', 'gizem.a@gmail.com', '2026-05-12');

INSERT INTO Urun (urun_adi, kategori_id, fiyat, stok_miktari, kritik_stok_seviyesi) VALUES
('Gaming Dizüstü Bilgisayar', 1, 35000.00, 15, 5),
('Stok Optimizasyon Yazılımı', 2, 12000.00, 50, 10),
('Yüksek Hızlı Router', 3, 2500.00, 30, 8),
('1TB NVMe M.2 SSD', 8, 3200.00, 100, 20),
('Mekanik Klavye', 5, 1800.00, 45, 15),
('Finansal Analiz Modülü (FinSight)', 2, 45000.00, 10, 2),
('Akıllı Saat', 7, 5400.00, 60, 15),
('Bulut Sunucu Rack', 9, 85000.00, 5, 2),
('Veri Yapıları ve Algoritma Kitabı', 10, 450.00, 80, 25),
('Yapay Zeka Hızlandırıcı Kart', 4, 125000.00, 8, 3);

INSERT INTO Siparis (musteri_id, urun_id, siparis_tarihi, adet, toplam_tutar) VALUES
(5, 6, '2026-05-15 10:30:00', 1, 45000.00),
(1, 4, '2026-05-16 14:45:00', 2, 6400.00),
(2, 5, '2026-05-17 09:15:00', 1, 1800.00),
(5, 2, '2026-05-18 11:20:00', 1, 12000.00),
(3, 1, '2026-05-19 16:50:00', 1, 35000.00),
(7, 3, '2026-05-20 13:10:00', 3, 7500.00),
(8, 7, '2026-05-21 15:25:00', 2, 10800.00),
(4, 9, '2026-05-22 10:05:00', 5, 2250.00),
(9, 8, '2026-05-23 08:40:00', 1, 85000.00),
(10, 10, '2026-05-24 17:30:00', 1, 125000.00);

SELECT m.ad, m.soyad, u.urun_adi, s.siparis_tarihi, s.toplam_tutar
FROM Siparis s
INNER JOIN Musteri m ON s.musteri_id = m.musteri_id
INNER JOIN Urun u ON s.urun_id = u.urun_id;

SELECT k.kategori_adi, u.urun_adi, u.stok_miktari
FROM Kategori k
LEFT JOIN Urun u ON k.kategori_id = u.kategori_id;

SELECT u.urun_adi, k.kategori_adi, u.fiyat
FROM Urun u
INNER JOIN Kategori k ON u.kategori_id = k.kategori_id;

SELECT k.kategori_adi, SUM(u.stok_miktari) as toplam_stok
FROM Urun u
INNER JOIN Kategori k ON u.kategori_id = k.kategori_id
GROUP BY k.kategori_adi
HAVING SUM(u.stok_miktari) > 30;

SELECT m.ad, m.soyad, SUM(s.toplam_tutar) as toplam_harcama
FROM Siparis s
INNER JOIN Musteri m ON s.musteri_id = m.musteri_id
GROUP BY m.musteri_id
HAVING SUM(s.toplam_tutar) > 15000;

SELECT urun_adi, fiyat, stok_miktari
FROM Urun
WHERE fiyat >= 5000 AND fiyat <= 50000
ORDER BY fiyat DESC;

SELECT ad, soyad, email, kayit_tarihi
FROM Musteri
WHERE kayit_tarihi >= '2026-01-01'
ORDER BY kayit_tarihi ASC;

SELECT COUNT(urun_id) AS toplam_urun_cesidi 
FROM Urun;

SELECT AVG(fiyat) AS ortalama_urun_fiyati 
FROM Urun;

SELECT SUM(toplam_tutar) AS toplam_ciro 
FROM Siparis;

UPDATE Urun 
SET fiyat = fiyat * 1.10 
WHERE kategori_id = 1;

UPDATE Musteri 
SET email = 'ayse.demir_yeni@gmail.com' 
WHERE musteri_id = 2;

CREATE TABLE Musteri_Yedek (
    yedek_id INT AUTO_INCREMENT PRIMARY KEY,
    eski_musteri_id INT,
    ad VARCHAR(50),
    soyad VARCHAR(50),
    silinme_tarihi DATETIME
);

DELIMITER //
CREATE TRIGGER trg_MusteriSilinme
AFTER DELETE ON Musteri
FOR EACH ROW
BEGIN
    INSERT INTO Musteri_Yedek (eski_musteri_id, ad, soyad, silinme_tarihi)
    VALUES (OLD.musteri_id, OLD.ad, OLD.soyad, NOW());
END; //
DELIMITER ;

DELETE FROM Musteri 
WHERE musteri_id = 6;

CREATE VIEW vw_KritikStok_Raporu AS
SELECT urun_adi, stok_miktari, kritik_stok_seviyesi
FROM Urun
WHERE stok_miktari <= kritik_stok_seviyesi;

SELECT * FROM vw_KritikStok_Raporu;

CREATE VIEW vw_GenelSiparis_Raporu AS
SELECT m.ad, u.urun_adi, s.adet, s.toplam_tutar
FROM Siparis s
JOIN Musteri m ON s.musteri_id = m.musteri_id
JOIN Urun u ON s.urun_id = u.urun_id;

SELECT * FROM vw_GenelSiparis_Raporu;

DELIMITER //
CREATE PROCEDURE sp_KategoriEkle(IN p_kategori_adi VARCHAR(100))
BEGIN
    INSERT INTO Kategori (kategori_adi) VALUES (p_kategori_adi);
END //
DELIMITER ;

CALL sp_KategoriEkle('Siber Güvenlik');

DELIMITER //
CREATE PROCEDURE sp_SiparisSil(IN p_sip_id INT)
BEGIN
    DELETE FROM Siparis WHERE siparis_id = p_sip_id;
END //
DELIMITER ;

CALL sp_SiparisSil(10);

SELECT urun_adi, fiyat 
FROM Urun 
WHERE fiyat > (SELECT AVG(fiyat) FROM Urun);

SELECT m.ad, m.email, s.siparis_tarihi
FROM Musteri m
INNER JOIN Siparis s ON m.musteri_id = s.musteri_id
WHERE m.ad LIKE 'A%' AND s.siparis_tarihi BETWEEN '2026-05-15' AND '2026-05-20';