DECLARE @i INT = 0;
DECLARE @Sehirler TABLE (Sehir_ID INT, Sehir_Adi NVARCHAR(50));
DECLARE @MutfakKategorileri TABLE (MutfakKategori_ID INT, MutfakAdi NVARCHAR(50));
DECLARE @FiyatKategorileri TABLE (FiyatKategori NVARCHAR(10));

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

-- Mutfak Kategorileri
INSERT INTO @MutfakKategorileri VALUES 
(1, 'Osmanlý Mutfaðý'), (2, 'Fransýz Mutfaðý'), (3, 'Ýtalyan Mutfaðý'), 
(4, 'Türk Mutfaðý'), (5, 'Meksika Mutfaðý'), (6, 'Hint Mutfaðý'),
(7, 'Japon Mutfaðý'), (8, 'Yunan Mutfaðý'), (9, 'Çin Mutfaðý'), (10, 'Akdeniz Mutfaðý');

-- Fiyat Kategorileri
INSERT INTO @FiyatKategorileri VALUES ('$'), ('$$'), ('$$$');

WHILE @i < 2500
BEGIN
    DECLARE @SehirAdi NVARCHAR(50);
    DECLARE @SehirID INT;
    DECLARE @RestoranAdi NVARCHAR(100);
    DECLARE @Counter INT = 1;

    -- Rastgele þehir seçimi
    SELECT TOP 1 @SehirAdi = Sehir_Adi, @SehirID = Sehir_ID FROM @Sehirler ORDER BY NEWID();
    SET @RestoranAdi = @SehirAdi + ' Restoraný';

    -- Adý benzersiz yapmak için kontrol ve artýrma
    WHILE EXISTS (SELECT 1 FROM [dbo].[Restorans] WHERE Ad = @RestoranAdi)
    BEGIN
        SET @RestoranAdi = @SehirAdi + ' Restoraný ' + CAST(@Counter AS NVARCHAR(10));
        SET @Counter = @Counter + 1;
    END

    INSERT INTO [dbo].[Restorans]
           ([Ad]
           ,[Adres]
           ,[Fiyat_Kategorisi]
           ,[RestoranImage]
           ,[Sehir_ID]
           ,[ülke_ID]
           ,[MutfakKategori_mutfakKategori_ID])
    VALUES
           (@RestoranAdi, -- Restoran adý
           @SehirAdi + ' Mahallesi, ' + CAST(FLOOR(RAND() * 100) + 1 AS NVARCHAR(3)) + ' Cadde', -- Adres: Mahalle ve Cadde
           (SELECT TOP 1 FiyatKategori FROM @FiyatKategorileri ORDER BY NEWID()), -- Fiyat kategorisi ($, $$, $$$)
           'https://media.istockphoto.com/id/942793238/tr/foto%C4%9Fraf/klasik-tarzda-l%C3%BCks-restoran-i%C3%A7.jpg?s=170667a&w=0&k=20&c=5qWz3TuPSIEWctkTNWh9CEXaH8or0Uw7U0kUFT4s_AY=', -- Restoran resmi
           @SehirID, -- Sehir ID (Restoran adýyla ayný þehir)
           1, -- Ülke ID (Türkiye)
           (SELECT TOP 1 MutfakKategori_ID FROM @MutfakKategorileri ORDER BY NEWID())); -- Mutfak Kategorisi (1-10)
    
    SET @i = @i + 1;
END
