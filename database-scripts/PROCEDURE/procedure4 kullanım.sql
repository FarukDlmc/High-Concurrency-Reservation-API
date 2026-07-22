SELECT AdSoyad, dbo.fn_GetKullaniciYorumSayisi(Kullanici_ID) AS OteleYorumSayisi
FROM dbo.Kullanicilars