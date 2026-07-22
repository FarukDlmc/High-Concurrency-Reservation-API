DECLARE @i INT = 0;

-- List of possible comments in Turkish
DECLARE @YorumlarTurkce TABLE (Yorum NVARCHAR(MAX));
INSERT INTO @YorumlarTurkce (Yorum)
VALUES
    ('Otelin konumu çok güzel, her yere kolayca ulaþabiliyorsunuz.'),
    ('Personel çok yardýmcý ve güler yüzlüydü, harika bir deneyim.'),
    ('Fiyatlar biraz yüksek ama hizmet çok iyi, tekrar gelmeyi düþünüyorum.'),
    ('Odalarda biraz daha fazla temizlik yapýlabilir, ancak genel olarak iyiydi.'),
    ('Mükemmel bir tatil geçirdim, konfor açýsýndan çok rahat bir otel.'),
    ('Otelin iç dekorasyonu çok hoþ, çok modern ve rahat.'),
    ('Yemekler harikaydý, özellikle kahvaltý çok çeþitli ve lezzetliydi.'),
    ('Odalar çok sessiz ve rahat, çok iyi dinlendim.'),
    ('Yüzme havuzu çok güzeldi, yaz tatili için ideal bir otel.'),
    ('Otelin spa hizmeti çok kaliteli, kesinlikle tavsiye ederim.');

-- List of possible comments in English
DECLARE @YorumlarIngilizce TABLE (Yorum NVARCHAR(MAX));
INSERT INTO @YorumlarIngilizce (Yorum)
VALUES
    ('The location of the hotel is great, very easy to access everywhere.'),
    ('The staff was very helpful and friendly, a wonderful experience.'),
    ('Prices are a bit high but the service was excellent, I am thinking of returning.'),
    ('The rooms could be a bit cleaner, but overall it was good.'),
    ('Had a perfect vacation, the hotel was very comfortable and relaxing.'),
    ('The hotel’s interior design is very nice, modern and comfortable.'),
    ('The food was amazing, especially the breakfast, it was very diverse and tasty.'),
    ('The rooms were very quiet and comfortable, I slept very well.'),
    ('The swimming pool was amazing, perfect for a summer vacation.'),
    ('The hotel’s spa service was very high quality, I would definitely recommend it.');

-- Loop to insert 2500 records
WHILE @i < 2500
BEGIN
    DECLARE @Yorum NVARCHAR(MAX), @KullaniciID INT, @OtelID INT, @Derecelendirme INT, @YorumTarihi DATETIME;

    -- Random Kullanici_ID between 1 and 15000
    SET @KullaniciID = ROUND(RAND() * (15000 - 1) + 1, 0);

    -- Random Otel_ID between 1 and 25000
    SET @OtelID = ROUND(RAND() * (25000 - 1) + 1, 0);

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
    INSERT INTO [dbo].[Yorumlars]
           ([Yorum]
           ,[Kullanici_ID]
           ,[Otel_ID]
           ,[Derecelendirme]
           ,[YorumTarihi])
    VALUES
           (
               @Yorum,            -- Random comment (Turkish or English based on Kullanici_ID)
               @KullaniciID,      -- Random Kullanici_ID (1-15000)
               @OtelID,           -- Random Otel_ID (1-25000)
               @Derecelendirme,   -- Random rating (3-5)
               @YorumTarihi       -- Random YorumTarihi (date)
           );

    SET @i = @i + 1;
END;
