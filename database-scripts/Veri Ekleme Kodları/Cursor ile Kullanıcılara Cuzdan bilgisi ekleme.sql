DECLARE @Kullanici_ID INT, 
        @KartNO NVARCHAR(16), 
        @SonKullanmaTarihi DATETIME, 
        @CVV INT;

DECLARE cursor_kullanici CURSOR FOR
SELECT Kullanici_ID
FROM Kullanicilars; -- Burada KullaniciTablosu'nu kullandýðýnýz tablo adýyla deðiþtirin

OPEN cursor_kullanici;

FETCH NEXT FROM cursor_kullanici INTO @Kullanici_ID;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Kart numarasýný 16 haneli olarak oluþtur
    SET @KartNO = CONCAT(
                    FLOOR(RAND() * 10000), 
                    '-', 
                    FLOOR(RAND() * 10000), 
                    '-', 
                    FLOOR(RAND() * 10000), 
                    '-', 
                    FLOOR(RAND() * 10000)
                  );

    -- Son kullaným tarihi oluþtur (2024-2034 yýllarý arasýnda ve 1-12 ay arasýnda)
    SET @SonKullanmaTarihi = '2030-01-01';

    -- CVV numarasýný 3 haneli olarak oluþtur
    SET @CVV = FLOOR(RAND() * 900) + 100; -- 100 ile 999 arasýnda bir sayý

    -- Veriyi 'Cuzdans' tablosuna ekle
    INSERT INTO [dbo].[Cuzdans]
           ([Kullanici_ID], 
            [Bakiye], 
            [KartNO], 
            [SonKullanmaTarihi], 
            [CVV])
    VALUES
           (@Kullanici_ID, 
            0, -- Bakiye sýfýr olarak verildi
            @KartNO, 
            @SonKullanmaTarihi, 
            @CVV);

    FETCH NEXT FROM cursor_kullanici INTO @Kullanici_ID;
END

CLOSE cursor_kullanici;
DEALLOCATE cursor_kullanici;
