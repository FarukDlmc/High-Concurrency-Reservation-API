DECLARE @i INT = 0;  
DECLARE @Isimler TABLE (Ad NVARCHAR(50));  
DECLARE @Soyisimler TABLE (Soyad NVARCHAR(50));  

-- Yabancý Ýsimler  
INSERT INTO @Isimler VALUES
('Liam'), ('Noah'), ('Oliver'), ('Elijah'), ('James'),
('Benjamin'), ('Lucas'), ('Mason'), ('Ethan'), ('Alexander'),
('Charlotte'), ('Amelia'), ('Sophia'), ('Isabella'), ('Mia'),
('Ava'), ('Harper'), ('Evelyn'), ('Luna'), ('Camila'),
('Aiden'), ('Logan'), ('Jacob'), ('Mateo'), ('Michael'),
('Abigail'), ('Ella'), ('Grace'), ('Victoria'), ('Scarlett'),
('Zoe'), ('Lily'), ('Sophie'), ('Olivia'), ('Emily'),
('Nathan'), ('Caleb'), ('Ryan'), ('Henry'), ('Leo'),
('Ella'), ('Madison'), ('Aria'), ('Chloe'), ('Layla'),
('Zara'), ('Mila'), ('Aurora'), ('Ellie'), ('Hannah');

-- Yabancý Soyisimler  
INSERT INTO @Soyisimler VALUES
('Anderson'), ('Bennett'), ('Carter'), ('Diaz'), ('Fisher'),
('Garrett'), ('Harrison'), ('Hughes'), ('Jackson'), ('Kennedy'),
('Lawson'), ('Mitchell'), ('Newton'), ('Parker'), ('Quinn'),
('Reed'), ('Sanders'), ('Taylor'), ('Turner'), ('Walker'),
('Baker'), ('Brooks'), ('Clark'), ('Collins'), ('Duncan'),
('Evans'), ('Foster'), ('Gibson'), ('Griffin'), ('Hale'),
('Jenkins'), ('Knight'), ('Lambert'), ('Maxwell'), ('Nash'),
('Patton'), ('Preston'), ('Ramsey'), ('Shepherd'), ('Spencer'),
('Tate'), ('Vaughn'), ('Wheeler'), ('Whitney'), ('Young');  

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
