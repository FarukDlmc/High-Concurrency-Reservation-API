DECLARE @i INT = 0;
DECLARE @Isimler TABLE (Ad NVARCHAR(50));
DECLARE @Soyisimler TABLE (Soyad NVARCHAR(50));

-- Ýsimler
INSERT INTO @Isimler VALUES
('Cemal'), ('Zeynep'), ('Berat'), ('Selda'), ('Rýdvan'),
('Leyla'), ('Kemal'), ('Sibel'), ('Tolga'), ('Gizem'),
('Berfin'), ('Aras'), ('Esma'), ('Yunus'), ('Tuba'),
('Halil'), ('Yasemin'), ('Salih'), ('Berkay'), ('Büþra'),
('Sevgi'), ('Furkan'), ('Serhat'), ('Sude'), ('Pelin'),
('Koray'), ('Eda'), ('Harun'), ('Serap'), ('Bilge'),
('Neþe'), ('Hakan'), ('Hilal'), ('Deniz'), ('Metin'),
('Zeliha'), ('Orhan'), ('Ozan'), ('Þule'), ('Baran'),
('Sevda'), ('Ýlhan'), ('Cansu'), ('Melih'), ('Caner');

-- Soyisimler
INSERT INTO @Soyisimler VALUES
('Akýncý'), ('Balcý'), ('Demirtaþ'), ('Eroðlu'), ('Gökçe'),
('Karataþ'), ('Özgür'), ('Tuncel'), ('Üstün'), ('Yýldýrým'),
('Aslan'), ('Can'), ('Dündar'), ('Eren'), ('Güzel'),
('Kaplan'), ('Özkan'), ('Þen'), ('Uður'), ('Yalçýn'),
('Akkaya'), ('Bayraktar'), ('Çakýr'), ('Durmaz'), ('Erdoðan'),
('Gümüþ'), ('Kalkan'), ('Kara'), ('Tekin'), ('Ulusoy'),
('Yiðit'), ('Candan'), ('Çelik'), ('Dinçer'), ('Efe'),
('Kaya'), ('Öztürk'), ('Sezer'), ('Taþkýn'), ('Uzun'),
('Korkmaz'), ('Koç'), ('Tanrýverdi'), ('Çolak'), ('Baþar');

-- Kullanýcý ekleme iþlemi
WHILE @i < 6500
BEGIN
    DECLARE @Ad NVARCHAR(50);
    DECLARE @Soyad NVARCHAR(50);
    DECLARE @AdSoyad NVARCHAR(MAX);
    DECLARE @Mail NVARCHAR(MAX);
    DECLARE @Sifre NVARCHAR(MAX);
    DECLARE @Telefon NVARCHAR(MAX);
    DECLARE @RastgeleSayi NVARCHAR(3);
    DECLARE @Domain NVARCHAR(10);

    -- Rastgele isim ve soyisim seçimi
    SELECT TOP 1 @Ad = Ad FROM @Isimler ORDER BY NEWID();
    SELECT TOP 1 @Soyad = Soyad FROM @Soyisimler ORDER BY NEWID();
    SET @AdSoyad = CONCAT(@Ad, ' ', @Soyad);

    -- Rastgele sayý oluþturma (3 haneli)
    SET @RastgeleSayi = CAST(FLOOR(RAND() * 900) + 100 AS NVARCHAR);

    -- Rastgele e-posta alan adý oluþturma
    SET @Domain = CASE WHEN RAND() > 0.5 THEN '@gmail.com' ELSE '@hotmail.com' END;

    -- Mail ve þifre oluþturma
    SET @Mail = CONCAT(@Ad, @RastgeleSayi, @Domain);
    SET @Sifre = LEFT(@Mail, CHARINDEX('@', @Mail) - 1);

    -- Rastgele telefon numarasý oluþturma
    SET @Telefon = CONCAT(FORMAT(CAST(RAND() * 900 AS INT) + 100, '000'), 
                          ' ', FORMAT(CAST(RAND() * 900 AS INT) + 100, '000'), 
                          ' ', FORMAT(CAST(RAND() * 90 AS INT) + 10, '00'), 
                          ' ', FORMAT(CAST(RAND() * 90 AS INT) + 10, '00'));

    -- Veriyi tabloya ekleme
    INSERT INTO [dbo].[Kullanicilars]
           ([AdSoyad], [Mail], [Sifre], [Telefon])
    VALUES
           (@AdSoyad, @Mail, @Sifre, @Telefon);

    SET @i = @i + 1;
END;
