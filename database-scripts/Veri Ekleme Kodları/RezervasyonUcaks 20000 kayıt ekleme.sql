DECLARE @i INT = 0;
DECLARE @SeyehatTipi NVARCHAR(20);
DECLARE @KoltukTipi NVARCHAR(20);
DECLARE @KoltukYeri NVARCHAR(20);
DECLARE @Nereden NVARCHAR(50);
DECLARE @Nereye NVARCHAR(50);
DECLARE @GidisTarihi DATETIME;
DECLARE @DonusTarihi DATETIME;
DECLARE @YolcuSayisi INT;

-- Þehirler (Türkiye ve Dýþ Þehirleri Burada Kullanacaðýz)
DECLARE @Sehirler TABLE (Sehir NVARCHAR(50), UlkeID INT);
INSERT INTO @Sehirler (Sehir, UlkeID)
VALUES 
-- Türkiye Þehirleri
('Ýstanbul', 2), ('Ankara', 2), ('Ýzmir', 2), ('Bursa', 2), ('Antalya', 2),
('Adana', 2), ('Konya', 2), ('Gaziantep', 2), ('Mersin', 2), ('Eskiþehir', 2),
-- Fransa Þehirleri
('Paris', 3), ('Marsilya', 3), ('Lyon', 3), ('Toulouse', 3), ('Nice', 3),
-- Ýngiltere Þehirleri
('Londra', 7), ('Manchester', 7), ('Birmingham', 7), ('Liverpool', 7), ('Leeds', 7),
-- Almanya Þehirleri
('Berlin', 6), ('Münih', 6), ('Hamburg', 6), ('Frankfurt', 6), ('Stuttgart', 6),
-- Ýtalya Þehirleri
('Roma', 4), ('Milano', 4), ('Venedik', 4), ('Floransa', 4), ('Napoli', 4),
-- Ýspanya Þehirleri
('Madrid', 8), ('Barcelona', 8), ('Valensiya', 8), ('Sevilla', 8), ('Bilbao', 8),
-- Japonya Þehirleri
('Tokyo', 5), ('Osaka', 5), ('Kyoto', 5), ('Yokohama', 5), ('Sapporo', 5),
-- Rusya Þehirleri
('Moskova', 11), ('St. Petersburg', 11), ('Novosibirsk', 11), ('Yekaterinburg', 11), ('Nijniy Novgorod', 11),
-- Brezilya Þehirleri
('Rio de Janeiro', 10), ('São Paulo', 10), ('Brasília', 10), ('Salvador', 10), ('Fortaleza', 10),
-- Kanada Þehirleri
('Toronto', 14), ('Vancouver', 14), ('Montreal', 14), ('Ottawa', 14), ('Calgary', 14),
-- Avustralya Þehirleri
('Sydney', 15), ('Melbourne', 15), ('Brisbane', 15), ('Perth', 15), ('Adelaide', 15),
-- Arjantin Þehirleri
('Buenos Aires', 16), ('Córdoba', 16), ('Rosario', 16), ('Mendoza', 16), ('La Plata', 16),
-- Nijerya Þehirleri
('Lagos', 116), ('Abuja', 116), ('Kano', 116), ('Port Harcourt', 116), ('Ibadan', 116),
-- Mýsýr Þehirleri
('Cairo', 99), ('Alexandria', 99), ('Giza', 99), ('Sharm el-Sheikh', 99), ('Luxor', 99),
-- Yunanistan Þehirleri
('Athens', 24), ('Thessaloniki', 24), ('Patras', 24), ('Heraklion', 24), ('Larissa', 24),
-- Polonya Þehirleri
('Warsaw', 25), ('Kraków', 25), ('?ód?', 25), ('Wroc?aw', 25), ('Pozna?', 25),
-- Belçika Þehirleri
('Brussels', 26), ('Antwerp', 26), ('Ghent', 26), ('Bruges', 26), ('Liège', 26),
-- Avusturya Þehirleri
('Vienna', 28), ('Salzburg', 28), ('Graz', 28), ('Linz', 28), ('Innsbruck', 28),
-- Ýsveç Þehirleri
('Stockholm', 31), ('Gothenburg', 31), ('Malmö', 31), ('Uppsala', 31), ('Västerås', 31),
-- Türkiye Dýþýndaki Diðer Þehirler
('Athens', 24), ('Warsaw', 25), ('Brussels', 26), ('Vienna', 28), ('Stockholm', 31)
-- Kullanýcý ID aralýðýný 1-15000 arasýnda seçiyoruz
-- Uçak ID 1-56 arasýnda seçilecek
-- SeyehatTipi Yurt Ýçi veya Yurt Dýþý olacak
-- KoltukTipi Business, First Class veya Ekonomi olacak
-- KoltukYeri Cam Kenarý, Orta veya Koridor olacak

WHILE @i < 20000
BEGIN
    -- SeyehatTipi rastgele seç
    SET @SeyehatTipi = CASE WHEN RAND() > 0.5 THEN 'Yurt Ýçi' ELSE 'Yurt Dýþý' END;

    -- KoltukTipi rastgele seç
    SET @KoltukTipi = CASE 
                        WHEN RAND() > 0.66 THEN 'Business' 
                        WHEN RAND() > 0.33 THEN 'First Class' 
                        ELSE 'Ekonomi' 
                      END;

    -- KoltukYeri rastgele seç
    SET @KoltukYeri = CASE 
                        WHEN RAND() > 0.66 THEN 'Cam Kenarý' 
                        WHEN RAND() > 0.33 THEN 'Orta' 
                        ELSE 'Koridor' 
                      END;

    -- Nereden ve Nereye belirle
    IF @SeyehatTipi = 'Yurt Ýçi'
    BEGIN
        -- Yurt içi seyahat için Türkiye þehirlerinden seç
        SELECT TOP 1 @Nereden = Sehir FROM @Sehirler WHERE UlkeID = 2 ORDER BY NEWID();
        SELECT TOP 1 @Nereye = Sehir FROM @Sehirler WHERE UlkeID = 2 ORDER BY NEWID();
    END
    ELSE
    BEGIN
        -- Yurt dýþý seyahat için Türkiye dýþý þehirlerden seç
        SELECT TOP 1 @Nereden = Sehir FROM @Sehirler WHERE UlkeID != 2 ORDER BY NEWID();
        SELECT TOP 1 @Nereye = Sehir FROM @Sehirler WHERE UlkeID != 2 ORDER BY NEWID();
    END

    -- Rastgele gidis tarihi ve donus tarihi belirle
    SET @GidisTarihi = DATEADD(DAY, (RAND() * 365) + 1, GETDATE());  -- 1 yýl içinde rastgele tarih
    SET @DonusTarihi = DATEADD(DAY, (RAND() * 365) + 2, @GidisTarihi);  -- Donüþ tarihi 1-2 yýl arasýnda olacak

    -- Yolcu sayýsý 1-6 arasýnda rastgele
    SET @YolcuSayisi = CAST((RAND() * 6) + 1 AS INT);

    -- Veriyi ekle
    INSERT INTO [dbo].[RezervasyonUcaks] 
           ([Kullanici_ID], [Ucak_ID], [SeyehatTipi], [KoltukTipi], [KoltukYeri], 
            [Nereden], [Nereye], [GidisTarihi], [DonusTarihi], [YolcuSayisi])
    VALUES
           (CAST((RAND() * 15000) + 1 AS INT), -- Kullanici_ID
            CAST((RAND() * 56) + 1 AS INT), -- Ucak_ID
            @SeyehatTipi, 
            @KoltukTipi, 
            @KoltukYeri, 
            @Nereden, 
            @Nereye, 
            @GidisTarihi, 
            @DonusTarihi, 
            @YolcuSayisi);

    SET @i = @i + 1;
END;
