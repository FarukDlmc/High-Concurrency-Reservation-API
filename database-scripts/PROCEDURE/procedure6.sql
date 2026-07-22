CREATE PROCEDURE sp_GetRestoranYorumlari
    @RestoranID INT
AS
BEGIN
    SELECT 
        Derecelendirme, 
        Yorum, 
        YorumTarihi
    FROM dbo.YorumlarRESTORANs yr
    INNER JOIN dbo.Kullanicilars k ON yr.Kullanici_ID = k.Kullanici_ID
    WHERE yr.Restoran_ID = @RestoranID
    ORDER BY YorumTarihi DESC
END