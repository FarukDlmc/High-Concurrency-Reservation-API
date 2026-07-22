DECLARE @i INT = 0;

-- List of possible comments in Turkish
DECLARE @YorumlarTurkce TABLE (Yorum NVARCHAR(MAX));
INSERT INTO @YorumlarTurkce (Yorum)
VALUES
    ('Restoran çok hoþ bir atmosfere sahip, yemekler harika.'),
    ('Servis çok hýzlý ve garsonlar çok güler yüzlü.'),
    ('Fiyat/performans oraný çok iyi, kesinlikle tavsiye ederim.'),
    ('Restoranýn dekorasyonu çok þýk ve rahatlatýcý bir ortam var.'),
    ('Yemekler taze ve çok lezzetliydi, bir daha geleceðim.'),
    ('Çalýþanlar çok ilgili ve yemekler harikaydý.'),
    ('Her þey mükemmeldi, sadece biraz daha fazla seçenek olabilirdi.'),
    ('Mekan çok kalabalýktý ama yine de servis gayet hýzlýydý.'),
    ('Fiyatlar biraz pahalý, ama yemekler buna deðiyor.'),
    ('Çok þýk ve samimi bir atmosferde harika bir akþam yemeði yedik.');

-- List of possible comments in English
DECLARE @YorumlarIngilizce TABLE (Yorum NVARCHAR(MAX));
INSERT INTO @YorumlarIngilizce (Yorum)
VALUES
    ('The restaurant has a great atmosphere, and the food is amazing.'),
    ('Service was fast, and the staff was very friendly.'),
    ('Great value for money, I would definitely recommend it.'),
    ('The restaurant decor is very elegant, and it creates a relaxing environment.'),
    ('The food was fresh and delicious, I will definitely come again.'),
    ('The staff was very attentive, and the food was fantastic.'),
    ('Everything was perfect, although a few more options would have been nice.'),
    ('The place was quite crowded, but the service was still fast.'),
    ('Prices are a bit high, but the food is worth it.'),
    ('Had a wonderful dinner in a stylish and cozy atmosphere.');

-- Loop to insert 2500 records
WHILE @i < 2500
BEGIN
    DECLARE @Yorum NVARCHAR(MAX), @RestoranID INT, @KullaniciID INT, @Derecelendirme INT, @YorumTarihi DATETIME;

    -- Random Restoran_ID between 1 and 15000
    SET @RestoranID = ROUND(RAND() * (15000 - 1) + 1, 0);

    -- Random Kullanici_ID between 1 and 15000
    SET @KullaniciID = ROUND(RAND() * (15000 - 1) + 1, 0);

    -- Select a random comment based on the Kullanici_ID range
    IF @KullaniciID BETWEEN 1 AND 1001 OR @KullaniciID BETWEEN 8502 AND 15001
    BEGIN
        -- Random Turkish comment
        SELECT TOP 1 @Yorum = Yorum FROM @YorumlarTurkce ORDER BY NEWID();
    END
    ELSE
    BEGIN
        -- Random English comment
        SELECT TOP 1 @Yorum = Yorum FROM @YorumlarIngilizce ORDER BY NEWID();
    END

    -- Random Derecelendirme (rating) between 3 and 5
    SET @Derecelendirme = ROUND(RAND() * 2 + 3, 0);

    -- Random YorumTarihi (random date and time)
    SET @YorumTarihi = DATEADD(DAY, ROUND(RAND() * 365, 0), GETDATE());

    -- Insert the data into the table
    INSERT INTO [dbo].[YorumlarRESTORANs]
           ([Yorum]
           ,[Restoran_ID]
           ,[Kullanici_ID]
           ,[Derecelendirme]
           ,[YorumTarihi])
    VALUES
           (
               @Yorum,            -- Random comment (Turkish or English based on Kullanici_ID)
               @RestoranID,       -- Random Restoran_ID (1-15000)
               @KullaniciID,      -- Random Kullanici_ID (1-15000)
               @Derecelendirme,   -- Random rating (3-5)
               @YorumTarihi       -- Random YorumTarihi (date)
           );

    SET @i = @i + 1;
END;
