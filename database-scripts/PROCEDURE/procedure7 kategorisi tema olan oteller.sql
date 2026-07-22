CREATE PROCEDURE sp_GetTemaliOteller
AS
BEGIN
    SELECT 
        Ad, 
        Adres,
		Yatak_Sayisi,
		Banyo_Sayisi,
        (SELECT otelKategorisi FROM dbo.OtelKategoris WHERE OtelKategori_ID = o.OtelKategori_ID) AS Kategori
    FROM dbo.Otels o
    WHERE o.OtelKategori_ID = 5 -- Temalý Oteller
END