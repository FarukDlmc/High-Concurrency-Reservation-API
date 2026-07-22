CREATE TRIGGER trg_DeleteKullaniciCuzdan
ON dbo.Kullanicilars
AFTER DELETE
AS
BEGIN
    -- Silinen kullanýcýyla iliþkili cüzdan kayýtlarýný da sil
    DELETE FROM dbo.Cuzdans
    WHERE Kullanici_ID IN (SELECT Kullanici_ID FROM DELETED)
END