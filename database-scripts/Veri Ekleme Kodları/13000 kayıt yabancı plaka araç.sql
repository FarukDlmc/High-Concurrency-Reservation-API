DECLARE @i INT = 0;

WHILE @i < 13000
BEGIN
    INSERT INTO [dbo].[Aracs]
           ([Marka]
           ,[Model]
           ,[Plaka]
           ,[Sehir_ID]
           ,[ülke_ID]
           ,[Vites]
           ,[GunlukFiyat]
           ,[AracImage]
           ,[YakitKategori_ID])
    VALUES
           (
               -- Rastgele Marka
               (SELECT TOP 1 Marka FROM (VALUES ('Toyota'), ('Ford'), ('BMW'), ('Audi'), ('Mercedes'), ('Honda'), ('Nissan'), ('Volkswagen'), ('Peugeot'), ('Renault'), 
                                          ('Opel'), ('Chevrolet'), ('Fiat'), ('Hyundai'), ('Mazda'), ('Kia'), ('Subaru'), ('Jaguar'), ('Porsche'), ('Lexus') ) AS MarkaList(Marka) ORDER BY NEWID()),
               
               -- Rastgele Model
               (SELECT TOP 1 Model FROM (VALUES ('Corolla'), ('Focus'), ('3 Series'), ('A3'), ('C-Class'), ('Civic'), ('Qashqai'), ('Golf'), ('308'), ('Clio'),
                                          ('Astra'), ('Cruze'), ('500'), ('Elantra'), ('Mazda 3'), ('Sportage'), ('Forester'), ('F-Type'), ('Cayenne'), ('RX') ) AS ModelList(Model) ORDER BY NEWID()),
               
               -- Rastgele Plaka
               CONCAT(CHAR(65 + ROUND(RAND() * 25, 0)), CHAR(65 + ROUND(RAND() * 25, 0)), ROUND(RAND() * 99, 0), ROUND(RAND() * 9999, 0)),
               
               -- Rastgele Sehir_ID (82-698 arasý)
               ROUND(RAND() * (698 - 82) + 82, 0),
               
               -- Rastgele Ülke_ID (2-100 arasý)
               ROUND(RAND() * (100 - 2) + 2, 0),
               
               -- Rastgele Vites (manuel veya otomatik)
               (CASE WHEN ROUND(RAND() * 1, 0) = 0 THEN 'Manuel' ELSE 'Otomatik' END),
               
               -- Rastgele GunlukFiyat (1000-2000 arasý)
               ROUND(RAND() * (2000 - 1000) + 1000, 0),
               
               -- Rastgele AracImage (boþ string veya rastgele bir URL)
               CONCAT('https://random.image.com/', ROUND(RAND() * 1000, 0), '.jpg'),
               
               -- Rastgele YakitKategori_ID (1-4 arasý)
               ROUND(RAND() * 3 + 1, 0)
           );

    SET @i = @i + 1;
END;
