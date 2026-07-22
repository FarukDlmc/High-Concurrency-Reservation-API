CREATE TRIGGER trg_AfterInsertOtels
ON dbo.Otels
AFTER INSERT
AS
BEGIN
    -- Yeni eklenen otel bilgilerini alýyoruz
    INSERT INTO dbo.LogTable (LogType, Description, CreatedDate)
    SELECT 
        'INSERT', 
        CONCAT('Yeni bir otel eklendi: ', Ad, ' - Kategori ID: ', OtelKategori_ID),
        GETDATE()
    FROM INSERTED
END