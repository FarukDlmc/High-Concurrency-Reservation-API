--her otelin toplam rezervasyon sayýsýný ve ortalama puanýný listelemek:
CREATE PROCEDURE sp_GetOtelRaporu
AS
BEGIN
    SELECT 
        o.Ad,
        COUNT(r.Rotel_ID) AS ToplamRezervasyon,
        dbo.fn_GetOtelYildizOrtalama(o.Otel_ID) AS OrtalamaPuan
    FROM dbo.Otels o
    LEFT JOIN dbo.RezervasyonOtels r ON o.Otel_ID = r.Otel_ID
    GROUP BY o.Ad, o.Otel_ID
END