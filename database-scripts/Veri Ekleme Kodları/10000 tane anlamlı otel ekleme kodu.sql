DECLARE @i INT = 0;
DECLARE @OtelAdlari TABLE (Ad NVARCHAR(100));
DECLARE @Adresler TABLE (Adres NVARCHAR(200));
DECLARE @Kampanyalar TABLE (Kampanya_ID INT, Ad NVARCHAR(100));
DECLARE @KategoriID TABLE (Kategori_ID INT, Ad NVARCHAR(50));

-- Örnek Otel Adlarý
INSERT INTO @OtelAdlari VALUES 
('Grand Royal Hotel'), ('Ocean Breeze Resort'), ('City Center Hotel'), ('Mountain View Lodge'), ('Sunset Bay Inn'), ('Golden Sands Hotel'),('Blue Horizon Resort'),('Paradise Island Retreat'),
('The Urban Oasis Hotel'),('Sea Pearl Inn'),('Lakeside Serenity Resort'),('Royal Palm Suites'),('The Alpine Retreat'),('Emerald Cove Hotel'),('Starlight Beach Resort'),
('Crystal Waters Inn'),('Hillside Haven Hotel'),('Infinity Bay Resort'),('Silver Moon Lodge'),('The Majestic Hotel'),('Aurora Sky Resort'),('Harbor View Hotel'),
('The Velvet Orchid Inn'),('Oceanfront Paradise Suites'),('Forest Whisper Lodge'),('The Sapphire Sands Hotel'),('Crescent Moon Retreat'),('Golden Horizon Inn'),('Serene Valley Resort'),
('Pearl Coast Suites'),('The Blossom Grove Hotel'),('Tranquil Bay Retreat'),('Azure Waves Resort'),('Sunrise Cliff Lodge'),('The Scarlet Shore Hotel'),('Coastal Breeze Suites'),
('Whispering Pines Lodge'),('Velvet Cove Retreat'),('The Summit Heights Inn'),('Majestic Dunes Resort');

-- Örnek Adresler
INSERT INTO @Adresler VALUES 
('Istanbul, Beþiktaþ'), ('Antalya, Lara'), ('Bodrum, Gumbet'), ('Izmir, Alsancak'), ('Ankara, Çankaya'), ('Istanbul, Kadýköy'),('Antalya, Konyaaltý'),('Bodrum, Yalýkavak'),
('Izmir, Karþýyaka'),('Ankara, Kýzýlay'),('Istanbul, Üsküdar'),('Antalya, Kaleiçi'),('Bodrum, Türkbükü'),('Izmir, Bornova'),('Ankara, Bahçelievler'),('Istanbul, Sarýyer'),
('Antalya, Muratpaþa'),('Bodrum, Turgutreis'),('Izmir, Buca'),('Ankara, Batýkent'),('Istanbul, Bakýrköy'),('Antalya, Side'),('Bodrum, Gümüþlük'),('Izmir, Gaziemir'),
('Ankara, Eryaman'),('Istanbul, Þiþli'),('Antalya, Alanya'),('Bodrum, Torba'),('Izmir, Çeþme'),('Ankara, Etimesgut'),('Istanbul, Beylikdüzü'),('Antalya, Manavgat'),
('Bodrum, Ortakent'),('Izmir, Seferihisar'),('Ankara, Mamak'),('Istanbul, Maltepe'),('Antalya, Kemer'),('Bodrum, Bitez'),('Izmir, Urla'),('Ankara, Sincan'),
('Istanbul, Pendik'),('Antalya, Aksu'),('Bodrum, Gündoðan'),('Izmir, Foça'),('Ankara, Dikmen'),('Istanbul, Tuzla'),('Antalya, Finike'),('Bodrum, Ortakent Yahþi'),('Izmir, Narlýdere'),
('Ankara, Çukurambar'),('Istanbul, Ataþehir'),('Antalya, Gazipaþa'),('Bodrum, Mazý'),('Izmir, Karaburun'),('Ankara, Keçiören');

-- Örnek Kampanyalar
INSERT INTO @Kampanyalar VALUES (1, 'Kýþ Ýndirimi'), (2, 'Yaza Özel'), (3, 'Erken Rezervasyon Kampanyasý'), (4, 'Aile Paketi'), (5, 'Lüks'), (6, 'Haftasonu Ýndirimi');

-- Örnek Otel Kategorileri
INSERT INTO @KategoriID VALUES (1, 'Þehir Otelleri'), (2, 'Yurt Ýçi Otelleri'), (3, 'Yurt Dýþý Otelleri'), (4, 'Kýbrýs Otelleri'), (5, 'Temalý Oteller');

WHILE @i < 5000
BEGIN
    INSERT INTO [dbo].[Otels]
           ([Ad]
           ,[Yatak_Sayisi]
           ,[Banyo_Sayisi]
           ,[Kisi_Basi_Fiyat]
           ,[Adres]
           ,[Kampanya_ID]
           ,[OtelImage]
           ,[OtelKategori_ID])
    VALUES
           ((SELECT TOP 1 Ad FROM @OtelAdlari ORDER BY NEWID()), -- Rastgele otel adý
           FLOOR(RAND() * 4) + 1, -- Yatak sayýsý (1-4)
           FLOOR(RAND() * 4) + 1, -- Banyo sayýsý (1-4)
           CAST(FLOOR(RAND() * 1001) + 1000 AS NVARCHAR(10)), -- Kiþi baþý fiyat (1000-2000)
           (SELECT TOP 1 Adres FROM @Adresler ORDER BY NEWID()), -- Rastgele adres
           (SELECT TOP 1 Kampanya_ID FROM @Kampanyalar ORDER BY NEWID()), -- Rastgele kampanya ID
           'https://st.depositphotos.com/40223836/61405/i/450/depositphotos_614052256-stock-photo-golden-hotel-icon-isolated-white.jpg', -- Otel resmi
           (SELECT TOP 1 Kategori_ID FROM @KategoriID ORDER BY NEWID())); -- Rastgele otel kategori ID
    SET @i = @i + 1;
END