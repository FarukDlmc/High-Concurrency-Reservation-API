--bir kullanýcýnýn otellere toplam kac yorum yaptýgý
CREATE FUNCTION fn_GetKullaniciYorumSayisi
    (@KullaniciID INT)
RETURNS INT
AS
BEGIN
    RETURN (
        SELECT COUNT(*)
        FROM dbo.Yorumlars
        WHERE Kullanici_ID = @KullaniciID
    )
END