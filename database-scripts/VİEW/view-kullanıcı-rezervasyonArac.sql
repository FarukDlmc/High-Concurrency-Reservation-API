CREATE VIEW vw_KullaniciRezervasyonArac
AS
SELECT 
    k.Kullanici_ID,
    k.AdSoyad,
    k.Mail,
    ra.Arac_ID,
    ra.Baslangic_Tarihi,
    ra.Bitis_Tarihi
FROM dbo.Kullanicilars k
INNER JOIN dbo.RezervasyonAracs ra ON k.Kullanici_ID = ra.Kullanici_ID