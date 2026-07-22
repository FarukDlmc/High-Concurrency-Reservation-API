DECLARE @i INT = 0;

-- List of possible comments in Turkish
DECLARE @YorumlarTurkce TABLE (Yorum NVARCHAR(MAX));
INSERT INTO @YorumlarTurkce (Yorum)
VALUES
    ('Tur çok güzel, harika bir deneyim yaþadým.'),
    ('Tur rehberi çok bilgilendiriciydi, her þeyi çok iyi açýkladý.'),
    ('Fiyat/performans oraný çok iyiydi, kesinlikle tavsiye ederim.'),
    ('Tur boyunca her þey çok düzenliydi, hiç sýkýlmadým.'),
    ('Tur sýrasýnda çok keyif aldým, çok eðlenceliydi.'),
    ('Tur operatörü çok profesyoneldi, her þey mükemmeldi.'),
    ('Tura katýlmadan önce çok endiþeliydim ama sonunda çok memnun kaldým.'),
    ('Her þey mükemmeldi, harika bir tatil deneyimi oldu.'),
    ('Tur boyunca her þey zamanýnda ve düzenliydi, çok beðendim.'),
    ('Kesinlikle tekrar katýlmak isteyeceðim bir turdu, her þey çok iyi organize edilmiþti.');

-- List of possible comments in English
DECLARE @YorumlarIngilizce TABLE (Yorum NVARCHAR(MAX));
INSERT INTO @YorumlarIngilizce (Yorum)
VALUES
    ('The tour was amazing, I had a great experience.'),
    ('The tour guide was very informative, explained everything very well.'),
    ('Great value for money, I would definitely recommend it.'),
    ('Everything was very organized during the tour, I didn’t get bored at all.'),
    ('I had so much fun during the tour, it was really exciting.'),
    ('The tour operator was very professional, everything was perfect.'),
    ('I was very nervous before the tour, but I ended up being very satisfied.'),
    ('Everything was perfect, it was a wonderful vacation experience.'),
    ('Everything was on time and well organized during the tour, I loved it.'),
    ('It was a tour I would definitely want to join again, everything was perfectly organized.');

-- Loop to insert 2500 records
WHILE @i < 2500
BEGIN
    DECLARE @Yorum NVARCHAR(MAX), @TurID INT, @KullaniciID INT, @Derecelendirme INT, @YorumTarihi DATETIME;

    -- Random Tur_ID between 1 and 5000
    SET @TurID = ROUND(RAND() * (5000 - 1) + 1, 0);

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
    INSERT INTO [dbo].[YorumlarTURs]
           ([Yorum]
           ,[Tur_ID]
           ,[Kullanici_ID]
           ,[Derecelendirme]
           ,[YorumTarihi])
    VALUES
           (
               @Yorum,            -- Random comment (Turkish or English based on Kullanici_ID)
               @TurID,            -- Random Tur_ID (1-5000)
               @KullaniciID,      -- Random Kullanici_ID (1-15000)
               @Derecelendirme,   -- Random rating (3-5)
               @YorumTarihi       -- Random YorumTarihi (date)
           );

    SET @i = @i + 1;
END;
