CREATE TRIGGER trg_AfterDeleteRezervasyon
ON dbo.RezervasyonOtels
AFTER DELETE
AS
BEGIN
    -- Silinen kayýtlarý loga yazýyoruz
    INSERT INTO dbo.LogTable (LogType, Description, CreatedDate)
    SELECT 
        'DELETE', 
        CONCAT('Rezervasyon ID: ', Rotel_ID, ' silindi.'), 
        GETDATE()
    FROM DELETED
END