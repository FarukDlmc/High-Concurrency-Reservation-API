DECLARE @i INT = 0;

WHILE @i < 20000
BEGIN
    INSERT INTO [dbo].[RezervasyonAracs]
           ([Arac_ID]
           ,[Kullanici_ID]
           ,[Baslangic_Tarihi]
           ,[Bitis_Tarihi])
    VALUES
           (
               -- Rastgele Arac_ID (1-15000 arasý)
               ROUND(RAND() * (15000 - 1) + 1, 0),
               
               -- Rastgele Kullanici_ID (1-15000 arasý)
               ROUND(RAND() * (15000 - 1) + 1, 0),
               
               -- Rastgele Baslangic_Tarihi (bugünden baþlayarak rastgele bir tarih)
               DATEADD(DAY, ROUND(RAND() * 365, 0), GETDATE()),
               
               -- Bitis_Tarihi: Baslangic_Tarihi'nden 5 gün sonra
               DATEADD(DAY, 5, DATEADD(DAY, ROUND(RAND() * 365, 0), GETDATE()))
           );

    SET @i = @i + 1;
END;
