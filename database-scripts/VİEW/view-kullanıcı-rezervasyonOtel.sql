CREATE VIEW vw_KullaniciRezervasyonOtels
AS
SELECT 
    k.Kullanici_ID,
    k.AdSoyad,
    k.Mail,
    ra.Otel_ID,
    ra.Baslangic_Tarihi,
    ra.Bitis_Tarihi
FROM dbo.Kullanicilars k
INNER JOIN dbo.RezervasyonOtels ra ON k.Kullanici_ID = ra.Kullanici_ID