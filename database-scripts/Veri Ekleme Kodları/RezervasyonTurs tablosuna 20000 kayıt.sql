DECLARE @i INT = 0;

WHILE @i < 19999
BEGIN
    DECLARE @KullaniciID INT;
    DECLARE @BaslangicTarihi DATETIME;
    DECLARE @BitisTarihi DATETIME;
    DECLARE @TurID INT;
    DECLARE @KisiSayisi INT;

    -- Rastgele Kullanici_ID (1-15000 arasý)
    SET @KullaniciID = FLOOR(RAND() * 15000) + 1;

    -- Rastgele Baþlangýç Tarihi (Geçerli tarihten 1 yýl sonrasýna kadar)
    SET @BaslangicTarihi = DATEADD(DAY, FLOOR(RAND() * 365), GETDATE());

    -- Bitiþ Tarihi: Baþlangýç tarihinden 1 hafta sonrasý
    SET @BitisTarihi = DATEADD(WEEK, 1, @BaslangicTarihi);

    -- Rastgele Tur_ID (1-5000 arasý)
    SET @TurID = FLOOR(RAND() * 5000) + 1;

    -- Rastgele KisiSayisi (1-5 arasý)
    SET @KisiSayisi = FLOOR(RAND() * 5) + 1;

    -- RezervasyonTurs tablosuna veri ekleniyor
    INSERT INTO [dbo].[RezervasyonTurs]
           ([Kullanici_ID], [Baslangic_Tarihi], [Bitis_Tarihi], [Tur_ID], [KisiSayisi])
    VALUES
           (@KullaniciID, @BaslangicTarihi, @BitisTarihi, @TurID, @KisiSayisi);

    -- Sayacý artýrýyoruz
    SET @i = @i + 1;
END;