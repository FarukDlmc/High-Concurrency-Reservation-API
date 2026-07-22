CREATE PROCEDURE sp_AddKullanici
    @KullaniciAdi NVARCHAR(50),
    @Email NVARCHAR(100),
    @Sifre NVARCHAR(50),
	@Telefon nvarchar(50)
AS
BEGIN
    INSERT INTO dbo.Kullanicilars (AdSoyad, Mail, Sifre, Telefon)
    VALUES (@KullaniciAdi, @Email, @Sifre, @Telefon)
END