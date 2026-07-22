CREATE PROCEDURE sp_GetUcuslarByTarih
    @BaslangicTarihi DATE,
    @BitisTarihi DATE
AS
BEGIN
    SELECT 
        KoltukTipi,
		KoltukYeri,
		Nereden,
		Nereye,
        GidisTarihi, 
        DonusTarihi
    FROM dbo.RezervasyonUcaks
    WHERE GidisTarihi BETWEEN @BaslangicTarihi AND @BitisTarihi
    ORDER BY GidisTarihi
END