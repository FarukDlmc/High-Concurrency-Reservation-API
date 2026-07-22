namespace TravelTripProje.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class FixTursSehirColumn : DbMigration
    {
        public override void Up()
        {
            // "Sehir_Sehir_ID" sütunu varsa kaldır
            Sql(@"IF EXISTS (SELECT 1 
                         FROM INFORMATION_SCHEMA.COLUMNS 
                         WHERE TABLE_NAME = 'Turs' AND COLUMN_NAME = 'Sehir_Sehir_ID') 
              BEGIN 
                  ALTER TABLE [dbo].[Turs] DROP COLUMN [Sehir_Sehir_ID] 
              END");

            // "Blog_ID" sütunu varsa kaldır
            Sql(@"IF EXISTS (SELECT 1 
                         FROM INFORMATION_SCHEMA.COLUMNS 
                         WHERE TABLE_NAME = 'Turs' AND COLUMN_NAME = 'Blog_ID') 
              BEGIN 
                  ALTER TABLE [dbo].[Turs] DROP COLUMN [Blog_ID] 
              END");

            // "Sehir_Sehir_ID" için foreign key varsa kaldır
            Sql(@"IF EXISTS (SELECT 1 
                         FROM sys.foreign_keys 
                         WHERE name = 'FK_dbo.Turs_dbo.Sehirs_Sehir_Sehir_ID') 
              BEGIN 
                  ALTER TABLE [dbo].[Turs] DROP CONSTRAINT [FK_dbo.Turs_dbo.Sehirs_Sehir_Sehir_ID] 
              END");

            // "Blog_ID" için foreign key varsa kaldır
            Sql(@"IF EXISTS (SELECT 1 
                         FROM sys.foreign_keys 
                         WHERE name = 'FK_dbo.Turs_dbo.Blogs_Blog_ID') 
              BEGIN 
                  ALTER TABLE [dbo].[Turs] DROP CONSTRAINT [FK_dbo.Turs_dbo.Blogs_Blog_ID] 
              END");
        }

        public override void Down()
        {
            // "Sehir_Sehir_ID" sütununu yeniden ekle
            AddColumn("dbo.Turs", "Sehir_Sehir_ID", c => c.Int());
            AddForeignKey("dbo.Turs", "Sehir_Sehir_ID", "dbo.Sehirs", "Sehir_ID");
            CreateIndex("dbo.Turs", "Sehir_Sehir_ID");

            // "Blog_ID" sütununu yeniden ekle
            AddColumn("dbo.Turs", "Blog_ID", c => c.Int());
            AddForeignKey("dbo.Turs", "Blog_ID", "dbo.Blogs", "ID");
            CreateIndex("dbo.Turs", "Blog_ID");
        }
    }
}
