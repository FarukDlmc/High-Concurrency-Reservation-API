DECLARE @i INT = 0;

-- Restoran adlarý için liste
DECLARE @RestoranAdlari TABLE (RestoranAdi NVARCHAR(255))
INSERT INTO @RestoranAdlari (RestoranAdi)
VALUES 
    ('Le Gourmet'), ('Chez Pierre'), ('Sushi World'), ('Bella Cucina'), ('The Bistro'), 
    ('Pasta House'), ('Steakhouse 101'), ('Ocean Grill'), ('Café Paris'), ('Trattoria Da Luigi'), 
    ('La Table Française'), ('Tokyo Sushi'), ('The Italian Kitchen'), ('La Dolce Vita'), 
    ('The Pancake House'), ('Bistro Bleu'), ('The Greenhouse'), ('Flavors of India'), 
    ('Sushi & Sashimi'), ('Grill House'), ('Pasta Fresca'), ('The Meatball Shop'), 
    ('A Taste of Italy'), ('Sunset Café'), ('Fried Chicken Paradise'), ('Tandoor Express'), 
    ('Pizzeria Napoli'), ('Seafood Market'), ('Wok & Roll'), ('Taco Haven');

WHILE @i < 12500
BEGIN
    DECLARE @Ad NVARCHAR(255), @Adres NVARCHAR(255), @FiyatKategori NVARCHAR(10), 
            @RestoranImage NVARCHAR(255), @SehirID INT, @UlkeID INT, @MutfakKategori INT;

    -- Rastgele restoran adý seçimi
    SELECT TOP 1 @Ad = RestoranAdi FROM @RestoranAdlari ORDER BY NEWID();

    -- Rastgele adres oluþturma
    SET @Adres = CONCAT(@Ad, ' Street, No: ', ROUND(RAND() * 100, 0), ', ', 
                        'City ID: ', ROUND(RAND() * (500 - 82) + 82, 0));

    -- Rastgele fiyat kategorisi seçimi
    SET @FiyatKategori = (CASE 
                            WHEN ROUND(RAND() * 2, 0) = 0 THEN '$'
                            WHEN ROUND(RAND() * 2, 0) = 1 THEN '$$'
                            ELSE '$$$'
                          END);

    -- Rastgele restoran resmi URL'si oluþturma
    SET @RestoranImage = CONCAT('https://restaurant.image/', ROUND(RAND() * 1000, 0), '.jpg');

    -- Rastgele Sehir_ID (82-500 arasý)
    SET @SehirID = ROUND(RAND() * (500 - 82) + 82, 0);

    -- Rastgele Ülke_ID (2-100 arasý)
    SET @UlkeID = ROUND(RAND() * (100 - 2) + 2, 0);

    -- Rastgele MutfakKategori_ID (1-40 arasý)
    SET @MutfakKategori = ROUND(RAND() * 39 + 1, 0);

    -- Veriyi tabloya ekleyin
    INSERT INTO [dbo].[Restorans]
           ([Ad]                  -- Restoran adý
           ,[Adres]               -- Adres
           ,[Fiyat_Kategorisi]    -- Fiyat kategorisi
           ,[RestoranImage]       -- Restoran resim URL'si
           ,[Sehir_ID]            -- Sehir_ID (82-500 arasý)
           ,[ülke_ID]             -- Ülke_ID (2-100 arasý)
           ,[MutfakKategori_ID])  -- MutfakKategori_ID (1-40 arasý)
    VALUES
           (
               @Ad,                 -- Restoran adý
               @Adres,              -- Adres
               @FiyatKategori,     -- Fiyat kategorisi
               @RestoranImage,     -- Restoran resim URL'si
               @SehirID,           -- Sehir_ID (82-500 arasý)
               @UlkeID,            -- Ülke_ID (2-100 arasý)
               @MutfakKategori     -- MutfakKategori_ID (1-40 arasý)
           );

    SET @i = @i + 1;
END;