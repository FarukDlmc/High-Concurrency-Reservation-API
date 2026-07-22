namespace TravelTripProje.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class RemoveBlogTable : DbMigration
    {
        public override void Up()
        {
            // "Blog" tablosunu sil
            DropTable("dbo.Blogs");
        }
        
        public override void Down()
        {
            // "Blog" tablosunu geri ekle
            CreateTable(
                "dbo.Blogs",
                c => new
                {
                    Blog_ID = c.Int(nullable: false, identity: true)
                })
                .PrimaryKey(t => t.Blog_ID);
        }
    }
}
