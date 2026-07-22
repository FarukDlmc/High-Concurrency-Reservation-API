CREATE VIEW vw_KullaniciRezervasyonTurs
AS
SELECT 
    k.Kullanici_ID,
    k.AdSoyad,
    k.Mail,
    ra.Tur_ID,
    ra.Baslangic_Tarihi,
    ra.Bitis_Tarihi
FROM dbo.Kullanicilars k
INNER JOIN dbo.RezervasyonTurs ra ON k.Kullanici_ID = ra.Kullanici_ID