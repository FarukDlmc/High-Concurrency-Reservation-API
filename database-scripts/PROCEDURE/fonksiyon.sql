CREATE FUNCTION fn_KalanGunSayisi
    (@RezervasyonID INT)
RETURNS INT
AS
BEGIN
    RETURN (
        SELECT DATEDIFF(DAY, GETDATE(), Baslangic_Tarihi)
        FROM dbo.RezervasyonOtels
        WHERE Rotel_ID = @RezervasyonID
    )
END