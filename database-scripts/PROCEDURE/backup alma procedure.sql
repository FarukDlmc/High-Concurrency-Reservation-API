CREATE PROCEDURE TakeBackupDatabase
    @DatabaseName NVARCHAR(128) = 'TatilSeyehatdb', -- Yedeklenecek veritabanýnýn adý
    @BackupPath NVARCHAR(255) = 'C:\Program Files\Microsoft SQL Server\MSSQL16.DEVELOPER_2022\MSSQL\Backup' -- Yedekleme dosyasýnýn yolu
AS
BEGIN
    BEGIN TRY
        -- Dinamik SQL ile BACKUP DATABASE komutu
        DECLARE @SQL NVARCHAR(MAX);
        SET @SQL = 'BACKUP DATABASE [' + @DatabaseName + '] TO DISK = ''' + @BackupPath + '\' + @DatabaseName + '.bak'' WITH FORMAT, INIT, NAME = ''' + @DatabaseName + ' Full Backup'', SKIP, NOREWIND, NOUNLOAD, STATS = 10;';
        
        -- Yedekleme iþlemini çalýþtýr
        EXEC sp_executesql @SQL;

        PRINT 'Veritabaný baþarýyla yedeklendi: ' + @BackupPath + '\' + @DatabaseName + '.bak';
    END TRY
    BEGIN CATCH
        -- Hata yönetimi
        PRINT 'Hata oluþtu: ' + ERROR_MESSAGE();
    END CATCH
END;
GO