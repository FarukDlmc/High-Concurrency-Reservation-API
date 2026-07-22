DECLARE @i INT = 0;
DECLARE @Sehirler TABLE (Sehir_ID INT, Sehir_Adi NVARCHAR(50));
DECLARE @TurKategorileri TABLE (TurKategori_ID INT, KategoriAdi NVARCHAR(50));
DECLARE @FiyatAraligi TABLE (MinFiyat INT, MaxFiyat INT);

-- Tüm 81 Türk Þehri
INSERT INTO @Sehirler VALUES
(1, 'Adana'), (2, 'Adýyaman'), (3, 'Afyonkarahisar'), (4, 'Aðrý'), (5, 'Amasya'), (6, 'Ankara'),
(7, 'Antalya'), (8, 'Artvin'), (9, 'Aydýn'), (10, 'Balýkesir'), (11, 'Bilecik'), (12, 'Bingöl'),
(13, 'Bitlis'), (14, 'Bolu'), (15, 'Burdur'), (16, 'Bursa'), (17, 'Çanakkale'), (18, 'Çankýrý'),
(19, 'Çorum'), (20, 'Denizli'), (21, 'Diyarbakýr'), (22, 'Edirne'), (23, 'Elazýð'), (24, 'Erzincan'),
(25, 'Erzurum'), (26, 'Eskiþehir'), (27, 'Gaziantep'), (28, 'Giresun'), (29, 'Gümüþhane'), (30, 'Hakkari'),
(31, 'Hatay'), (32, 'Isparta'), (33, 'Mersin'), (34, 'Ýstanbul'), (35, 'Ýzmir'), (36, 'Kars'),
(37, 'Kastamonu'), (38, 'Kayseri'), (39, 'Kýrklareli'), (40, 'Kýrþehir'), (41, 'Kocaeli'), (42, 'Konya'),
(43, 'Kütahya'), (44, 'Malatya'), (45, 'Manisa'), (46, 'Kahramanmaraþ'), (47, 'Mardin'), (48, 'Muðla'),
(49, 'Muþ'), (50, 'Nevþehir'), (51, 'Niðde'), (52, 'Ordu'), (53, 'Rize'), (54, 'Sakarya'), (55, 'Samsun'),
(56, 'Siirt'), (57, 'Sinop'), (58, 'Sivas'), (59, 'Tekirdað'), (60, 'Tokat'), (61, 'Trabzon'), (62, 'Tunceli'),
(63, 'Þanlýurfa'), (64, 'Uþak'), (65, 'Van'), (66, 'Yozgat'), (67, 'Zonguldak'), (68, 'Aksaray'),
(69, 'Bayburt'), (70, 'Karaman'), (71, 'Kýrýkkale'), (72, 'Batman'), (73, 'Þýrnak'), (74, 'Bartýn'),
(75, 'Ardahan'), (76, 'Iðdýr'), (77, 'Yalova'), (78, 'Karabük'), (79, 'Kilis'), (80, 'Osmaniye'), (81, 'Düzce');

-- Tur Kategorileri
INSERT INTO @TurKategorileri VALUES
(2, 'Yurtiçi'), (3, 'Kültür Turu'), (4, 'Gemi Turu');

-- Fiyat Aralýðý
INSERT INTO @FiyatAraligi VALUES
(500, 1000);

WHILE @i < 2500
BEGIN
    DECLARE @SehirAdi NVARCHAR(50);
    DECLARE @SehirID INT;
    DECLARE @Rota NVARCHAR(200);
    DECLARE @TurAdi NVARCHAR(100);
    DECLARE @TurKategori INT;

    -- Rastgele 1 þehir seçimi (ilk þehir) ve rota oluþturma
    SELECT TOP 1 @SehirAdi = Sehir_Adi, @SehirID = Sehir_ID
    FROM @Sehirler
    ORDER BY NEWID(); -- Ýlk þehir için rastgele seçim

    -- Rota için diðer 1 þehir (ilk þehir hariç)
    DECLARE @SehirListesi TABLE (SehirAdi NVARCHAR(50));

    -- Ýlk þehir hariç, diðer 1 þehri rastgele seçiyoruz
    INSERT INTO @SehirListesi (SehirAdi)
    SELECT TOP 1 Sehir_Adi
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
           1, -- Ülke ID (Türkiye)
           'https://cdn2.vectorstock.com/i/1000x1000/66/26/print-city-tour-stamp-on-white-vector-24496626.jpg', -- Tur resmi
           @TurKategori); -- Tur kategorisi (Yurtiçi, Kültür Turu, Gemi Turu)

    -- Sayacý artýrýyoruz
    SET @i = @i + 1;
END
