--Belirli bir otel kategorisine ait otelleri listelemek için:

CREATE PROCEDURE sp_GetOtellerByKategori
    @KategoriID INT
AS
BEGIN
    SELECT Ad, Adres
    FROM dbo.Otels
    WHERE OtelKategori_ID = @KategoriID
END