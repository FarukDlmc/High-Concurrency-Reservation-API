EXEC sp_UpdateCuzdanBakiyesi @KullaniciID = 2, @Miktar = 150.00
select Bakiye from Cuzdans c where c.Kullanici_ID=Kullanici_ID