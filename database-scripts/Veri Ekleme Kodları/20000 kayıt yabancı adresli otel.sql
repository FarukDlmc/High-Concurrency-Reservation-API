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
('New York, Manhattan'), ('New York, Brooklyn'), ('New York, Queens'), ('New York, Bronx'), ('New York, Staten Island'),
('Los Angeles, Hollywood'), ('Los Angeles, Santa Monica'), ('Los Angeles, Downtown'), ('Los Angeles, Venice Beach'), ('Los Angeles, Beverly Hills'),
('Chicago, The Loop'), ('Chicago, Lincoln Park'), ('Chicago, River North'), ('Chicago, South Loop'), ('Chicago, Hyde Park'),
('Houston, Downtown'), ('Houston, Galleria Area'), ('Houston, Midtown'), ('Houston, Museum District'), ('Houston, Montrose'),
('Miami, South Beach'), ('Miami, Downtown'), ('Miami, Brickell'), ('Miami, Coral Gables'), ('Miami, Coconut Grove'),
('Paris, 1st Arrondissement'), ('Paris, Marais'), ('Paris, Montmartre'), ('Paris, Latin Quarter'), ('Paris, Champs-Élysées'),
('Marseille, Vieux-Port'), ('Marseille, Le Panier'), ('Marseille, Prado'), ('Marseille, La Corniche'), ('Marseille, Aix-en-Provence'),
('Lyon, Presquîle'), ('Lyon, Croix-Rousse'), ('Lyon, Part-Dieu'), ('Lyon, Vieux Lyon'), ('Lyon, Tête d’Or Park'),
('Toulouse, Capitole Square'), ('Toulouse, Saint-Cyprien'), ('Toulouse, Les Carmes'), ('Toulouse, Centre-Ville'), ('Toulouse, Jean-Jaurès'),
('Nice, Promenade des Anglais'), ('Nice, Old Town'), ('Nice, Cimiez'), ('Nice, Mont Boron'), ('Nice, Port Lympia'),
('Roma, Centro Storico'), ('Roma, Vatican City'), ('Roma, Trastevere'), ('Roma, Monti'), ('Roma, Testaccio'),
('Milan, Centro Storico'), ('Milan, Brera'), ('Milan, Navigli'), ('Milan, Porta Romana'), ('Milan, Cadorna'),
('Naples, Spaccanapoli'), ('Naples, Posillipo'), ('Naples, Vomero'), ('Naples, Chiaia'), ('Naples, Centro Storico'),
('Turin, Centro Storico'), ('Turin, San Salvario'), ('Turin, Lingotto'), ('Turin, Crocetta'), ('Turin, Vanchiglia'),
('Palermo, Kalsa'), ('Palermo, Mondello'), ('Palermo, Quattro Canti'), ('Palermo, Politeama'), ('Palermo, La Zisa'),
('Tokyo, Shibuya'), ('Tokyo, Shinjuku'), ('Tokyo, Ginza'), ('Tokyo, Roppongi'), ('Tokyo, Asakusa'),
('Osaka, Namba'), ('Osaka, Umeda'), ('Osaka, Tennoji'), ('Osaka, Osaka Bay Area'), ('Osaka, Shin-Osaka'),
('Kyoto, Gion'), ('Kyoto, Higashiyama'), ('Kyoto, Arashiyama'), ('Kyoto, Kyoto Station Area'), ('Kyoto, Pontocho'),
('Hokkaido, Sapporo'), ('Hokkaido, Niseko'), ('Hokkaido, Hakodate'), ('Hokkaido, Furano'), ('Hokkaido, Otaru'),
('Nagoya, Sakae'), ('Nagoya, Osu'), ('Nagoya, Nagoya Station Area'), ('Nagoya, Fushimi'), ('Nagoya, Atsuta'),
('Berlin, Mitte'), ('Berlin, Kreuzberg'), ('Berlin, Prenzlauer Berg'), ('Berlin, Friedrichshain'), ('Berlin, Charlottenburg'),
('Munich, Altstadt-Lehel'), ('Munich, Schwabing'), ('Munich, Glockenbachviertel'), ('Munich, Bogenhausen'), ('Munich, Sendling'),
('Hamburg, HafenCity'), ('Hamburg, St. Pauli'), ('Hamburg, Altona'), ('Hamburg, Eppendorf'), ('Hamburg, Winterhude'),
('Frankfurt, Innenstadt'), ('Frankfurt, Sachsenhausen'), ('Frankfurt, Altstadt'), ('Frankfurt, Westend'), ('Frankfurt, Bornheim'),
('Cologne, Altstadt'), ('Cologne, Ehrenfeld'), ('Cologne, Deutz'), ('Cologne, Sülz'), ('Cologne, Nippes'),
('London, Westminster'), ('London, Camden'), ('London, Soho'), ('London, Kensington'), ('London, Shoreditch'),
('Manchester, Northern Quarter'), ('Manchester, Deansgate'), ('Manchester, Spinningfields'), ('Manchester, Ancoats'), ('Manchester, Chorlton'),
('Birmingham, City Centre'), ('Birmingham, Jewellery Quarter'), ('Birmingham, Moseley'), ('Birmingham, Digbeth'), ('Birmingham, Edgbaston'),
('Liverpool, City Centre'), ('Liverpool, Albert Dock'), ('Liverpool, Baltic Triangle'), ('Liverpool, Ropewalks'), ('Liverpool, Everton'),
('Leeds, City Centre'), ('Leeds, Headingley'), ('Leeds, Chapel Allerton'), ('Leeds, Horsforth'), ('Leeds, Meanwood'),
('Madrid, Centro'), ('Madrid, Salamanca'), ('Madrid, Chamberí'), ('Madrid, Malasaña'), ('Madrid, Gran Vía'),
('Barcelona, Eixample'), ('Barcelona, Gothic Quarter'), ('Barcelona, El Born'), ('Barcelona, Gràcia'), ('Barcelona, Barceloneta'),
('Valencia, Ciutat Vella'), ('Valencia, Ruzafa'), ('Valencia, Benimaclet'), ('Valencia, Albufera'), ('Valencia, Malvarrosa'),
('Seville, Santa Cruz'), ('Seville, Triana'), ('Seville, El Arenal'), ('Seville, Macarena'), ('Seville, Nervión'),
('Zaragoza, Casco Antiguo'), ('Zaragoza, Delicias'), ('Zaragoza, La Almozara'), ('Zaragoza, El Rabal'), ('Zaragoza, Universidad'),
('Seoul, Gangnam'), ('Seoul, Insadong'), ('Seoul, Myeongdong'), ('Seoul, Itaewon'), ('Seoul, Hongdae'),
('Busan, Haeundae'), ('Busan, Nampo-dong'), ('Busan, Gwangalli Beach'), ('Busan, Seomyeon'), ('Busan, Jagalchi'),
('Incheon, Songdo'), ('Incheon, Bupyeong'), ('Incheon, Yeonsu'), ('Incheon, Namdong'), ('Incheon, Incheon International Airport Area'),
('Daegu, Dongseongno'), ('Daegu, Beomeo-dong'), ('Daegu, Dalseo-gu'), ('Daegu, Suseong Lake'), ('Daegu, Gyeongsan'),
('Daejeon, Yuseong-gu'), ('Daejeon, Daedeok-gu'), ('Daejeon, Jung-gu'), ('Daejeon, Dunsan-dong'), ('Daejeon, Dong-gu'),
('Sao Paulo, Avenida Paulista'), ('Sao Paulo, Vila Madalena'), ('Sao Paulo, Itaim Bibi'), ('Sao Paulo, Moema'), ('Sao Paulo, Centro'),
('Rio de Janeiro, Copacabana'), ('Rio de Janeiro, Ipanema'), ('Rio de Janeiro, Barra da Tijuca'), ('Rio de Janeiro, Leblon'), ('Rio de Janeiro, Lapa'),
('Salvador, Pelourinho'), ('Salvador, Barra'), ('Salvador, Ondina'), ('Salvador, Itapuã'), ('Salvador, Rio Vermelho'),
('Brasilia, Plano Piloto'), ('Brasilia, Asa Norte'), ('Brasilia, Asa Sul'), ('Brasilia, Lago Sul'), ('Brasilia, Setor Bueno'),
('Fortaleza, Praia do Futuro'), ('Fortaleza, Meireles'), ('Fortaleza, Aldeota'), ('Fortaleza, Centro'), ('Fortaleza, Praia de Iracema'),
('Moscow, Arbat'), ('Moscow, Tverskoy'), ('Moscow, Red Square'), ('Moscow, Zamoskvorechye'), ('Moscow, Kitay-Gorod'),('Casablanca, Ain Diab'), ('Casablanca, Maarif'), ('Casablanca, Habbous'), ('Casablanca, Gauthier'), ('Casablanca, Medina'),

-- Marrakech, Fas
('Marrakech, Medina'), ('Marrakech, Gueliz'), ('Marrakech, Hivernage'), ('Marrakech, Palmeraie'), ('Marrakech, Kasbah'),

-- Cape Town, Güney Afrika
('Cape Town, City Bowl'), ('Cape Town, Waterfront'), ('Cape Town, Green Point'), ('Cape Town, Camps Bay'), ('Cape Town, Sea Point'),

-- Johannesburg, Güney Afrika
('Johannesburg, Sandton'), ('Johannesburg, Rosebank'), ('Johannesburg, Maboneng'), ('Johannesburg, Melville'), ('Johannesburg, Braamfontein'),

-- Sydney, Avustralya
('Sydney, Circular Quay'), ('Sydney, Darling Harbour'), ('Sydney, Surry Hills'), ('Sydney, Bondi Beach'), ('Sydney, Paddington'),

-- Melbourne, Avustralya
('Melbourne, CBD'), ('Melbourne, Fitzroy'), ('Melbourne, St Kilda'), ('Melbourne, Carlton'), ('Melbourne, Southbank'),

-- Brisbane, Avustralya
('Brisbane, South Bank'), ('Brisbane, Fortitude Valley'), ('Brisbane, West End'), ('Brisbane, New Farm'), ('Brisbane, Spring Hill'),

-- Auckland, Yeni Zelanda
('Auckland, CBD'), ('Auckland, Ponsonby'), ('Auckland, Parnell'), ('Auckland, Newmarket'), ('Auckland, Grey Lynn'),

-- Wellington, Yeni Zelanda
('Wellington, Te Aro'), ('Wellington, Kelburn'), ('Wellington, Oriental Bay'), ('Wellington, Thorndon'), ('Wellington, Miramar'),

-- Singapore
('Singapore, Orchard Road'), ('Singapore, Marina Bay'), ('Singapore, Chinatown'), ('Singapore, Little India'), ('Singapore, Bugis'),

-- Kuala Lumpur, Malezya
('Kuala Lumpur, Bukit Bintang'), ('Kuala Lumpur, KLCC'), ('Kuala Lumpur, Chinatown'), ('Kuala Lumpur, Mont Kiara'), ('Kuala Lumpur, Petaling Jaya'),

-- Jakarta, Endonezya
('Jakarta, Central Jakarta'), ('Jakarta, South Jakarta'), ('Jakarta, West Jakarta'), ('Jakarta, North Jakarta'), ('Jakarta, East Jakarta'),

-- Bangkok, Tayland
('Bangkok, Sukhumvit'), ('Bangkok, Silom'), ('Bangkok, Khao San Road'), ('Bangkok, Siam'), ('Bangkok, Chatuchak'),

-- Hanoi, Vietnam
('Hanoi, Old Quarter'), ('Hanoi, Hoan Kiem Lake'), ('Hanoi, Ba Dinh'), ('Hanoi, Tay Ho'), ('Hanoi, Cau Giay'),

-- Ho Chi Minh City, Vietnam
('Ho Chi Minh City, District 1'), ('Ho Chi Minh City, District 3'), ('Ho Chi Minh City, District 5'), ('Ho Chi Minh City, District 7'), ('Ho Chi Minh City, Binh Thanh'),

-- Sydney, Avustralya
('Sydney, Circular Quay'), ('Sydney, Darling Harbour'), ('Sydney, Surry Hills'), ('Sydney, Bondi Beach'), ('Sydney, Paddington'),

-- Melbourne, Avustralya
('Melbourne, CBD'), ('Melbourne, Fitzroy'), ('Melbourne, St Kilda'), ('Melbourne, Carlton'), ('Melbourne, Southbank'),

-- Christchurch, Yeni Zelanda
('Christchurch, Central City'), ('Christchurch, Merivale'), ('Christchurch, Riccarton'), ('Christchurch, Sumner'), ('Christchurch, Bealey Avenue'),

-- Auckland, Yeni Zelanda
('Auckland, CBD'), ('Auckland, Ponsonby'), ('Auckland, Parnell'), ('Auckland, Newmarket'), ('Auckland, Grey Lynn'),

-- Hong Kong, Çin
('Hong Kong, Central'), ('Hong Kong, Tsim Sha Tsui'), ('Hong Kong, Kowloon'), ('Hong Kong, Wan Chai'), ('Hong Kong, Causeway Bay'),

-- Shanghai, Çin
('Shanghai, Bund'), ('Shanghai, Pudong'), ('Shanghai, Xintiandi'), ('Shanghai, Jing’an'), ('Shanghai, French Concession'),

-- Beijing, Çin
('Beijing, Wangfujing'), ('Beijing, Sanlitun'), ('Beijing, Chaoyang'), ('Beijing, Dongcheng'), ('Beijing, Xicheng'),

-- New Delhi, Hindistan
('New Delhi, Connaught Place'), ('New Delhi, Karol Bagh'), ('New Delhi, Hauz Khas'), ('New Delhi, Chandni Chowk'), ('New Delhi, South Extension'),

-- Mumbai, Hindistan
('Mumbai, Colaba'), ('Mumbai, Bandra'), ('Mumbai, Andheri'), ('Mumbai, Lower Parel'), ('Mumbai, Juhu'),

-- Dubai, Birleþik Arap Emirlikleri
('Dubai, Downtown Dubai'), ('Dubai, Jumeirah Beach'), ('Dubai, Palm Jumeirah'), ('Dubai, Bur Dubai'), ('Dubai, Dubai Marina'),

-- Abu Dhabi, Birleþik Arap Emirlikleri
('Abu Dhabi, Corniche'), ('Abu Dhabi, Yas Island'), ('Abu Dhabi, Al Zahiyah'), ('Abu Dhabi, Al Reem Island'), ('Abu Dhabi, Saadiyat Island'),

-- Doha, Katar
('Doha, West Bay'), ('Doha, Corniche'), ('Doha, Souq Waqif'), ('Doha, Pearl Qatar'), ('Doha, Al Dafna'),

-- Riyadh, Suudi Arabistan
('Riyadh, Olaya'), ('Riyadh, Al Malaz'), ('Riyadh, Diplomatic Quarter'), ('Riyadh, Al Faisaliyah'), ('Riyadh, King Abdulaziz Road'),

-- Jeddah, Suudi Arabistan
('Jeddah, Corniche'), ('Jeddah, Al Balad'), ('Jeddah, Al Tahlia'), ('Jeddah, Al Rawda'), ('Jeddah, North Jeddah'),

-- Beirut, Lübnan
('Beirut, Hamra'), ('Beirut, Gemayzeh'), ('Beirut, Achrafieh'), ('Beirut, Downtown'), ('Beirut, Raouche'),

-- Amman, Ürdün
('Amman, Abdali'), ('Amman, Rainbow Street'), ('Amman, Sweifieh'), ('Amman, Jabal Al Lweibdeh'), ('Amman, Shmeisani'),('Cairo, Zamalek'), ('Cairo, Downtown Cairo'), ('Cairo, Maadi'), ('Cairo, Heliopolis'), ('Cairo, Garden City'),

-- Tunis, Tunus
('Tunis, La Marsa'), ('Tunis, Sidi Bou Said'), ('Tunis, Carthage'), ('Tunis, Medina'), ('Tunis, Belvedere'),

-- Cezayir, Cezayir
('Algiers, El Madania'), ('Algiers, Hydra'), ('Algiers, Kouba'), ('Algiers, Belouizdad'), ('Algiers, Bab El Oued'),

-- Dakar, Senegal
('Dakar, Plateau'), ('Dakar, Ngor'), ('Dakar, Almadies'), ('Dakar, Yoff'), ('Dakar, Mermoz'),

-- Lagos, Nijerya
('Lagos, Victoria Island'), ('Lagos, Lekki'), ('Lagos, Ikeja'), ('Lagos, Surulere'), ('Lagos, Yaba'),

-- Nairobi, Kenya
('Nairobi, Westlands'), ('Nairobi, Kilimani'), ('Nairobi, Karen'), ('Nairobi, Upper Hill'), ('Nairobi, Lang’ata'),

-- Accra, Gana
('Accra, Osu'), ('Accra, Labone'), ('Accra, East Legon'), ('Accra, Cantonments'), ('Accra, Dzorwulu'),

-- Addis Ababa, Etiyopya
('Addis Ababa, Bole'), ('Addis Ababa, Piazza'), ('Addis Ababa, Old Airport'), ('Addis Ababa, Meskel Square'), ('Addis Ababa, Kolfe Keranio'),

-- Nairobi, Kenya
('Nairobi, Westlands'), ('Nairobi, Kilimani'), ('Nairobi, Karen'), ('Nairobi, Upper Hill'), ('Nairobi, Lang’ata'),

-- Doha, Katar
('Doha, West Bay'), ('Doha, Corniche'), ('Doha, Souq Waqif'), ('Doha, Pearl Qatar'), ('Doha, Al Dafna'),

-- Riyadh, Suudi Arabistan
('Riyadh, Olaya'), ('Riyadh, Al Malaz'), ('Riyadh, Diplomatic Quarter'), ('Riyadh, Al Faisaliyah'), ('Riyadh, King Abdulaziz Road'),

-- Jeddah, Suudi Arabistan
('Jeddah, Corniche'), ('Jeddah, Al Balad'), ('Jeddah, Al Tahlia'), ('Jeddah, Al Rawda'), ('Jeddah, North Jeddah'),

-- Dubai, Birleþik Arap Emirlikleri
('Dubai, Downtown Dubai'), ('Dubai, Jumeirah Beach'), ('Dubai, Palm Jumeirah'), ('Dubai, Bur Dubai'), ('Dubai, Dubai Marina'),

-- Abu Dhabi, Birleþik Arap Emirlikleri
('Abu Dhabi, Corniche'), ('Abu Dhabi, Yas Island'), ('Abu Dhabi, Al Zahiyah'), ('Abu Dhabi, Al Reem Island'), ('Abu Dhabi, Saadiyat Island'),

-- Kuala Lumpur, Malezya
('Kuala Lumpur, Bukit Bintang'), ('Kuala Lumpur, KLCC'), ('Kuala Lumpur, Chinatown'), ('Kuala Lumpur, Mont Kiara'), ('Kuala Lumpur, Petaling Jaya'),

-- Jakarta, Endonezya
('Jakarta, Central Jakarta'), ('Jakarta, South Jakarta'), ('Jakarta, West Jakarta'), ('Jakarta, North Jakarta'), ('Jakarta, East Jakarta'),

-- Manila, Filipinler
('Manila, Makati'), ('Manila, Bonifacio Global City'), ('Manila, Malate'), ('Manila, Quezon City'), ('Manila, Pasig'),

-- Hong Kong, Çin
('Hong Kong, Central'), ('Hong Kong, Tsim Sha Tsui'), ('Hong Kong, Kowloon'), ('Hong Kong, Wan Chai'), ('Hong Kong, Causeway Bay'),

-- Shanghai, Çin
('Shanghai, Bund'), ('Shanghai, Pudong'), ('Shanghai, Xintiandi'), ('Shanghai, Jing’an'), ('Shanghai, French Concession'),

-- Pekin, Çin
('Beijing, Wangfujing'), ('Beijing, Sanlitun'), ('Beijing, Chaoyang'), ('Beijing, Dongcheng'), ('Beijing, Xicheng'),

-- Tokyo, Japonya
('Tokyo, Shibuya'), ('Tokyo, Shinjuku'), ('Tokyo, Ginza'), ('Tokyo, Roppongi'), ('Tokyo, Asakusa'),

-- Osaka, Japonya
('Osaka, Namba'), ('Osaka, Umeda'), ('Osaka, Shinsaibashi'), ('Osaka, Dotonbori'), ('Osaka, Tennoji'),

-- Seoul, Güney Kore
('Seoul, Gangnam'), ('Seoul, Myeongdong'), ('Seoul, Itaewon'), ('Seoul, Hongdae'), ('Seoul, Insadong'),

-- Kuala Lumpur, Malezya
('Kuala Lumpur, Bukit Bintang'), ('Kuala Lumpur, KLCC'), ('Kuala Lumpur, Chinatown'), ('Kuala Lumpur, Mont Kiara'), ('Kuala Lumpur, Petaling Jaya'),

-- Jakarta, Endonezya
('Jakarta, Central Jakarta'), ('Jakarta, South Jakarta'), ('Jakarta, West Jakarta'), ('Jakarta, North Jakarta'), ('Jakarta, East Jakarta')

-- Örnek Kampanyalar
INSERT INTO @Kampanyalar VALUES (1, 'Kýþ Ýndirimi'), (2, 'Yaza Özel'), (3, 'Erken Rezervasyon Kampanyasý'), (4, 'Aile Paketi'), (5, 'Lüks'), (6, 'Haftasonu Ýndirimi');

-- Örnek Otel Kategorileri
INSERT INTO @KategoriID VALUES (1, 'Þehir Otelleri'), (2, 'Yurt Ýçi Otelleri'), (3, 'Yurt Dýþý Otelleri'), (4, 'Kýbrýs Otelleri'), (5, 'Temalý Oteller');

WHILE @i < 20000
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