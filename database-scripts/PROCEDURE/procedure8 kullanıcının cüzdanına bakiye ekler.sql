--kullanýcýnýn cüzdanýna bakiye ekler
CREATE PROCEDURE sp_UpdateCuzdanBakiyesi
    @KullaniciID INT,
    @Miktar DECIMAL(10, 2)
AS
BEGIN
    UPDATE dbo.Cuzdans
    SET Bakiye = Bakiye + @Miktar
    WHERE Kullanici_ID = @KullaniciID
END