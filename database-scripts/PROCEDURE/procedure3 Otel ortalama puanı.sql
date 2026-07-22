--Bir otelin yorumlarýndan ortalama puanýný hesaplamak için

CREATE FUNCTION fn_GetOtelYildizOrtalama
    (@OtelID INT)
RETURNS DECIMAL(5, 2)
AS
BEGIN
    DECLARE @Ortalama DECIMAL(5, 2)

    SELECT @Ortalama = AVG(Derecelendirme)
    FROM dbo.Yorumlars
    WHERE Otel_ID = @OtelID

    RETURN ISNULL(@Ortalama, 0)
END