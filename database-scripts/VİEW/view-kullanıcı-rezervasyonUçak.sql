CREATE VIEW vw_KullaniciRezervasyonUcaks
AS
SELECT 
    k.Kullanici_ID,
    k.AdSoyad,
    k.Mail,
    ra.Ucak_ID,
    ra.GidisTarihi,
    ra.DonusTarihi
FROM dbo.Kullanicilars k
INNER JOIN dbo.RezervasyonUcaks ra ON k.Kullanici_ID = ra.Kullanici_ID