DECLARE @i INT = 0;
DECLARE @Sehirler TABLE (Sehir_ID INT, Sehir_Adi NVARCHAR(50), Ulke_ID INT);
DECLARE @TurKategorileri TABLE (TurKategori_ID INT, KategoriAdi NVARCHAR(50));
DECLARE @FiyatAraligi TABLE (MinFiyat INT, MaxFiyat INT);

-- Þehirler (Yabancý Þehirler ve Ülkeler)
INSERT INTO @Sehirler VALUES
(1, 'Paris', 3), (2, 'Marsilya', 3), (3, 'Lyon', 3), (4, 'Toulouse', 3), (5, 'Nice', 3),
(6, 'Londra', 7), (7, 'Manchester', 7), (8, 'Birmingham', 7), (9, 'Liverpool', 7), (10, 'Leeds', 7),
(11, 'Berlin', 6), (12, 'Münih', 6), (13, 'Hamburg', 6), (14, 'Frankfurt', 6), (15, 'Stuttgart', 6),
(16, 'Roma', 4), (17, 'Milano', 4), (18, 'Venedik', 4), (19, 'Floransa', 4), (20, 'Napoli', 4),
(21, 'Madrid', 8), (22, 'Barcelona', 8), (23, 'Valensiya', 8), (24, 'Sevilla', 8), (25, 'Bilbao', 8),
(26, 'Tokyo', 5), (27, 'Osaka', 5), (28, 'Kyoto', 5), (29, 'Yokohama', 5), (30, 'Sapporo', 5),
(31, 'Moskova', 11), (32, 'St. Petersburg', 11), (33, 'Novosibirsk', 11), (34, 'Yekaterinburg', 11), (35, 'Nijniy Novgorod', 11),
(36, 'Rio de Janeiro', 10), (37, 'São Paulo', 10), (38, 'Brasília', 10), (39, 'Salvador', 10), (40, 'Fortaleza', 10),
(41, 'Toronto', 14), (42, 'Vancouver', 14), (43, 'Montreal', 14), (44, 'Ottawa', 14), (45, 'Calgary', 14),
(46, 'Sydney', 15), (47, 'Melbourne', 15), (48, 'Brisbane', 15), (49, 'Perth', 15), (50, 'Adelaide', 15),
(51, 'Buenos Aires', 16), (52, 'Córdoba', 16), (53, 'Rosario', 16), (54, 'Mendoza', 16), (55, 'La Plata', 16),
(56, 'Lagos', 116), (57, 'Abuja', 116), (58, 'Kano', 116), (59, 'Port Harcourt', 116), (60, 'Ibadan', 116),
(61, 'Cairo', 99), (62, 'Alexandria', 99), (63, 'Giza', 99), (64, 'Sharm el-Sheikh', 99), (65, 'Luxor', 99),
(66, 'Athens', 24), (67, 'Thessaloniki', 24), (68, 'Patras', 24), (69, 'Heraklion', 24), (70, 'Larissa', 24),
(71, 'Warsaw', 25), (72, 'Kraków', 25), (73, '?ód?', 25), (74, 'Wroc?aw', 25), (75, 'Pozna?', 25),
(76, 'Brussels', 26), (77, 'Antwerp', 26), (78, 'Ghent', 26), (79, 'Bruges', 26), (80, 'Liège', 26),
(81, 'Vienna', 28), (82, 'Salzburg', 28), (83, 'Graz', 28), (84, 'Linz', 28), (85, 'Innsbruck', 28),
(86, 'Stockholm', 31), (87, 'Gothenburg', 31), (88, 'Malmö', 31), (89, 'Uppsala', 31), (90, 'Västerås', 31);

-- Tur Kategorileri
INSERT INTO @TurKategorileri VALUES
(2, 'Yurtiçi'), (3, 'Kültür Turu'), (4, 'Gemi Turu');

-- Fiyat Aralýðý
INSERT INTO @FiyatAraligi VALUES
(500, 1000);

WHILE @i < 2500
BEGIN
    DECLARE @SehirAdi NVARCHAR(50);
	DECLARE @UlkeID NVARCHAR(50);
    DECLARE @SehirID INT;
    DECLARE @Rota NVARCHAR(200);
    DECLARE @TurAdi NVARCHAR(100);
    DECLARE @TurKategori INT;

    -- Rastgele 1 þehir seçimi (ilk þehir) ve rota oluþturma
    SELECT TOP 1 @SehirAdi = Sehir_Adi, @SehirID = Sehir_ID, @UlkeID = Ulke_ID
    FROM @Sehirler
    ORDER BY NEWID(); -- Ýlk þehir için rastgele seçim

    -- Rota için diðer 1 þehir (ilk þehir hariç)
    DECLARE @SehirListesi TABLE (SehirAdi NVARCHAR(50), Ulke_ID INT);

    -- Ýlk þehir hariç, diðer 1 þehri rastgele seçiyoruz
    INSERT INTO @SehirListesi (SehirAdi, Ulke_ID)
    SELECT TOP 1 Sehir_Adi, Ulke_ID
    FROM @Sehirler
    WHERE Sehir_Adi != @SehirAdi
    ORDER BY NEWID(); -- Diðer 1 þehir için rastgele seçim

    -- Rota oluþturma: 2 þehir (ilk þehir + 1 farklý þehir)
    SELECT @Rota = @SehirAdi + ' - ' + SehirAdi
    FROM @SehirListesi;

    -- Tur adý, ilk þehri kullanarak oluþturuluyor
    SET @TurAdi = 'Unutulmaz ' + @SehirAdi + ' Turu';

    -- Tur adýnýn daha önce kullanýlýp kullanýlmadýðýný kontrol et
    DECLARE @TurAdýKontrol INT;
    SET @TurAdýKontrol = (SELECT COUNT(*) FROM [dbo].[Turs] WHERE Ad = @TurAdi);

    -- Eðer ayný ad varsa, sayýyý artýr
    IF @TurAdýKontrol > 0
    BEGIN
        DECLARE @TurAdiSayi INT = 2;
        WHILE (SELECT COUNT(*) FROM [dbo].[Turs] WHERE Ad = @TurAdi + ' ' + CAST(@TurAdiSayi AS NVARCHAR(10))) > 0
        BEGIN
            SET @TurAdiSayi = @TurAdiSayi + 1;
        END
        SET @TurAdi = @TurAdi + ' ' + CAST(@TurAdiSayi AS NVARCHAR(10));
    END

    -- Tur Kategorisi: Yurtiçi, Kültür Turu veya Gemi Turu
    SET @TurKategori = (CASE 
                         WHEN @i % 3 = 0 THEN 2 -- Yurtiçi
                         WHEN @i % 3 = 1 THEN 3 -- Kültür Turu
                         ELSE 4 -- Gemi Turu
                         END);

    -- Veritabanýna veri ekleniyor
    INSERT INTO [dbo].[Turs]
           ([Ad]
           ,[Kisi_Basi_Fiyat]
           ,[Rota]
           ,[Kampanya_ID]
           ,[ülke_ID]
           ,[TurImage]
           ,[TurKategori_ID])
    VALUES
           (@TurAdi, -- Tur adý
           CAST(FLOOR(RAND() * 500) + 500 AS NVARCHAR(10)), -- Kiþi baþý fiyat (500-1000 arasý)
           @Rota, -- Rota (ilk þehir + 1 farklý þehir)
           FLOOR(RAND() * 6) + 1, -- Kampanya ID (1-6 arasý)
           @UlkeID, -- Ülke ID (Þehir ile ilgili olan ülke)
           'https://cdn2.vectorstock.com/i/1000x1000/66/26/print-city-tour-stamp-on-white-vector-24496626.jpg', -- Tur resmi
           @TurKategori); -- Tur kategorisi (Yurtiçi, Kültür Turu, Gemi Turu)

    -- Sayacý artýrýyoruz
    SET @i = @i + 1;
END;
