DECLARE @i INT = 0;

-- List of possible comments in Turkish
DECLARE @YorumlarTurkce TABLE (Yorum NVARCHAR(MAX));
INSERT INTO @YorumlarTurkce (Yorum)
VALUES
    ('Aracýn performansý harika, özellikle hýzlanma çok iyi.'),
    ('Sürüþ keyfi çok yüksek, virajlarda dahi çok stabil.'),
    ('Benzin tüketimi çok düþük, ekonomik bir araç.'),
    ('Þehir içi kullaným için oldukça uygun ve pratik.'),
    ('Aracýn iç mekan tasarýmý çok modern ve kullanýþlý.'),
    ('Fiyat/performans oraný çok iyi, kesinlikle tavsiye ederim.'),
    ('Konfor açýsýndan mükemmel, uzun yolculuklarda rahatlýk saðlýyor.'),
    ('Araç çok sessiz ve sürüþ esnasýnda hiçbir titreþim hissetmiyorum.'),
    ('Yol tutuþu gerçekten çok iyi, her türlü hava koþulunda güvenli.'),
    ('Yüksek hýzlarda bile stabiliteyi koruyor, çok güvenli bir araç.');

-- List of possible comments in English
DECLARE @YorumlarIngilizce TABLE (Yorum NVARCHAR(MAX));
INSERT INTO @YorumlarIngilizce (Yorum)
VALUES
    ('The car performs great, especially the acceleration is impressive.'),
    ('Driving experience is amazing, very stable even on sharp turns.'),
    ('Fuel consumption is very low, this car is very economical.'),
    ('It is very practical for city driving, easy to park and maneuver.'),
    ('The interior design is modern and very functional.'),
    ('Great value for money, I would definitely recommend it.'),
    ('The comfort level is amazing, great for long road trips.'),
    ('The car is very quiet, I don’t feel any vibrations while driving.'),
    ('The handling is superb, safe to drive in all weather conditions.'),
    ('Even at high speeds, the car maintains stability and feels very safe.');

-- Loop to insert 2500 records
WHILE @i < 2500
BEGIN
    DECLARE @Yorum NVARCHAR(MAX), @AracID INT, @KullaniciID INT, @Derecelendirme INT, @YorumTarihi DATETIME;

    -- Random Arac_ID between 1 and 15000
    SET @AracID = ROUND(RAND() * (15000 - 1) + 1, 0);

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
    INSERT INTO [dbo].[YorumlarARACs]
           ([Yorum]
           ,[Arac_ID]
           ,[Kullanici_ID]
           ,[Derecelendirme]
           ,[YorumTarihi])
    VALUES
           (
               @Yorum,            -- Random comment (Turkish or English based on Kullanici_ID)
               @AracID,           -- Random Arac_ID (1-15000)
               @KullaniciID,      -- Random Kullanici_ID (1-15000)
               @Derecelendirme,   -- Random rating (3-5)
               @YorumTarihi       -- Random YorumTarihi (date)
           );

    SET @i = @i + 1;
END;
