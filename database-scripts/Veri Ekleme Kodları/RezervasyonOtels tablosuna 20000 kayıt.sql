DECLARE @i INT = 0;
DECLARE @Kullanici_ID INT;
DECLARE @Otel_ID INT;
DECLARE @Baslangic_Tarihi DATETIME;
DECLARE @Bitis_Tarihi DATETIME;
DECLARE @KisiSayisi INT;

-- Baþlangýç tarihi için bir referans tarih
DECLARE @MinDate DATETIME = '2022-01-01'; -- Bu tarihi istediðiniz bir tarih ile deðiþtirebilirsiniz

-- Rezervasyon ekleme döngüsü
WHILE @i < 20000
BEGIN
    -- Kullanici_ID: 1 ile 15000 arasýnda rastgele
    SET @Kullanici_ID = FLOOR(RAND() * 15000) + 1;
    
    -- Otel_ID: 1 ile 25000 arasýnda rastgele
    SET @Otel_ID = FLOOR(RAND() * 25000) + 1;

    -- Baslangic_Tarihi: Rastgele tarih (2024 yýlý)
    SET @Baslangic_Tarihi = DATEADD(DAY, FLOOR(RAND() * 365), @MinDate); -- 2024 yýlý için rastgele tarih
    
    -- Bitis_Tarihi: Baþlangýç tarihinden 10 gün sonrasý
    SET @Bitis_Tarihi = DATEADD(DAY, 10, @Baslangic_Tarihi);
    
    -- KisiSayisi: 1 ile 6 arasýnda rastgele
    SET @KisiSayisi = FLOOR(RAND() * 6) + 1;

    -- Veritabanýna kayýt ekle
    INSERT INTO [dbo].[RezervasyonOtels]
           ([Kullanici_ID]
           ,[Otel_ID]
           ,[Baslangic_Tarihi]
           ,[Bitis_Tarihi]
           ,[KisiSayisi])
    VALUES
           (@Kullanici_ID
           ,@Otel_ID
           ,@Baslangic_Tarihi
           ,@Bitis_Tarihi
           ,@KisiSayisi);

    -- Döngü sayacýný artýr
    SET @i = @i + 1;
END
