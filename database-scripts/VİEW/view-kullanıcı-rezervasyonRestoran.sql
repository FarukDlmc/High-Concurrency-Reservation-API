CREATE VIEW vw_KullaniciRezervasyonRestorans
AS
SELECT 
    k.Kullanici_ID,
    k.AdSoyad,
    k.Mail,
    ra.Restoran_ID,
    ra.Tarih,
    ra.Saat
FROM dbo.Kullanicilars k
INNER JOIN dbo.RezervasyonRestorans ra ON k.Kullanici_ID = ra.Kullanici_ID