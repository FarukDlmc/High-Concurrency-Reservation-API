SELECT 
    Rotel_ID,
    dbo.fn_KalanGunSayisi(Rotel_ID) AS KalanGun
FROM dbo.RezervasyonOtels