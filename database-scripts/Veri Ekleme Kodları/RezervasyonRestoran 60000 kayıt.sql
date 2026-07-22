DECLARE @i INT = 0;

WHILE @i < 60000
BEGIN
    DECLARE @RestoranID INT, @KullaniciID INT, @Tarih DATETIME, @Saat NVARCHAR(5), @KisiSayisi INT;

    -- Random Restoran_ID between 1 and 15000
    SET @RestoranID = ROUND(RAND() * (15000 - 1) + 1, 0);

    -- Random Kullanici_ID between 1 and 15000
    SET @KullaniciID = ROUND(RAND() * (15000 - 1) + 1, 0);

    -- Random Tarih (within the next 365 days)
    SET @Tarih = DATEADD(DAY, ROUND(RAND() * 365, 0), GETDATE());

    -- Random Saat between 10:00 and 22:00
    SET @Saat = CONCAT(ROUND(RAND() * (22 - 10) + 10, 0), ':', 
                       RIGHT('00' + ROUND(RAND() * 60, 0), 2));

    -- Random KisiSayisi between 1 and 5
    SET @KisiSayisi = ROUND(RAND() * 5 + 1, 0);

    -- Insert data into the table
    INSERT INTO [dbo].[RezervasyonRestorans]
           ([Restoran_ID]
           ,[Kullanici_ID]
           ,[Tarih]
           ,[Saat]
           ,[KisiSayisi])
    VALUES
           (
               @RestoranID,  -- Random Restoran_ID (1-15000)
               @KullaniciID, -- Random Kullanici_ID (1-15000)
               @Tarih,       -- Random Tarih (within next 365 days)
               @Saat,        -- Random Saat (between 10:00 and 22:00)
               @KisiSayisi   -- Random KisiSayisi (1-5)
           );

    SET @i = @i + 1;
END;
