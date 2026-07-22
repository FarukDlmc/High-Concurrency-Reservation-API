namespace TravelTripProje.Migrations
{
    using System;
    using System.Data.Entity.Migrations;

    public partial class FixYorumlarBlogs : DbMigration
    {
        public override void Up()
        {
            // "Blog_ID" sütunu varsa kaldır
            Sql(@"IF EXISTS (SELECT 1 
                     FROM INFORMATION_SCHEMA.COLUMNS 
                     WHERE TABLE_NAME = 'Yorumlars' AND COLUMN_NAME = 'Blog_ID') 
          BEGIN 
              ALTER TABLE [dbo].[Yorumlars] DROP COLUMN [Blog_ID] 
          END");

            // "Blog_ID" için foreign key varsa kaldır
            Sql(@"IF EXISTS (SELECT 1 
                     FROM sys.foreign_keys 
                     WHERE name = 'FK_dbo.Yorumlars_dbo.Blogs_Blog_ID1') 
          BEGIN 
              ALTER TABLE [dbo].[Yorumlars] DROP CONSTRAINT [FK_dbo.Yorumlars_dbo.Blogs_Blog_ID1] 
          END");
        }

        public override void Down()
        {
            // "Blog_ID" sütununu yeniden ekle
            AddColumn("dbo.Yorumlars", "Blog_ID", c => c.Int(nullable: false));

            // "Blog_ID" için foreign key ekle
            AddForeignKey("dbo.Yorumlars", "Blog_ID", "dbo.Blogs", "Blog_ID", cascadeDelete: true);

            // "Blog_ID" sütunu için index oluştur
            CreateIndex("dbo.Yorumlars", "Blog_ID");
        }
    }
}
