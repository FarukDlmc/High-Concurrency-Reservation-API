BEGIN TRANSACTION;

BEGIN TRY
    -- 1. Kullanýcýnýn mevcut bakiyesini kontrol et
    DECLARE @KullaniciID INT = 1; -- Test için Kullanýcý ID 
    DECLARE @OtelID INT = 1; -- Test için Otel ID
    DECLARE @KisiBasiFiyat DECIMAL(18, 2);
    DECLARE @Cuzdan DECIMAL(18, 2);

    -- Otelin kiþi baþý fiyatýný al
    SELECT @KisiBasiFiyat = Kisi_Basi_Fiyat
    FROM Otels
    WHERE Otel_ID = @OtelID;

    -- Kullanýcýnýn cüzdan bakiyesini al
    SELECT @Cuzdan = Bakiye -- Cuzdans yerine doðru isim
    FROM Cuzdans
    WHERE Kullanici_ID = @KullaniciID;

    -- Bakiye kontrolü
    IF (@Cuzdan < @KisiBasiFiyat)
    BEGIN
        RAISERROR('Bakiye yetersiz!', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;

    -- 2. Rezervasyon kaydý ekle
    -- Baslangic_Tarihi için GETDATE() ve Bitis_Tarihi için 1 gün ekleyebiliriz (örneðin)
    INSERT INTO RezervasyonOtels (Kullanici_ID, Otel_ID, Baslangic_Tarihi, Bitis_Tarihi)
    VALUES (@KullaniciID, @OtelID, GETDATE(), DATEADD(DAY, 1, GETDATE())); -- Bitis_Tarihi, 1 gün sonrasý

    -- 3. Kullanýcýnýn cüzdanýný güncelle
    UPDATE Cuzdans
    SET Bakiye = Bakiye - @KisiBasiFiyat -- Cuzdans yerine doðru isim
    WHERE Kullanici_ID = @KullaniciID;

    -- Eðer tüm iþlemler baþarýlý olursa, commit yap
    COMMIT TRANSACTION;
    PRINT 'Rezervasyon baþarýlý ve bakiye düþüldü.';
END TRY
BEGIN CATCH
    -- Hata oluþursa, transaction geri alýnýr
    ROLLBACK TRANSACTION;

    -- Hata mesajýný göster
    PRINT 'Hata: ' + ERROR_MESSAGE();
END CATCH;
