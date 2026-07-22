using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;
using System.Reflection.Emit;


namespace TravelTripProje.Models.Sınıflar
{
    public class Context : DbContext
    {
        public DbSet<Admin> Admins { get; set; }
        public DbSet<AdresBlog> AdresBlogs { get; set; }
        public DbSet<Hakkimizda> Hakkimizdas { get; set; }
        public DbSet<iletisim> iletisims { get; set; }
        public DbSet<Yorumlar> Yorumlars { get; set; }
        public DbSet<YorumlarTUR> YorumlarTURs { get; set; }
        public DbSet<Arac> Aracs { get; set; }
        public DbSet<Kamp> Kamps { get; set; }
        public DbSet<Otel> Otels { get; set; }
        public DbSet<OtelKategori> OtelKategoris { get; set; }
        public DbSet<TurKategori> TurKategoris { get; set; }
        public DbSet<MutfakKategori> MutfakKategoris { get; set; }
        public DbSet<Restoran> Restorans { get; set; }
        public DbSet<Tur> Turs { get; set; }
        public DbSet<Sehir> Sehirs { get; set; }
        public DbSet<ilce> ilces { get; set; }
        public DbSet<ülke> ülkes { get; set; }
        public DbSet<Kampanyalar> Kampanyalars { get; set; }
        public DbSet<Kullanicilar> Kullanicilars { get; set; }
        public DbSet<RezervasyonOtel> RezervasyonOtels { get; set; }
        public DbSet<RezervasyonTur> RezervasyonTurs { get; set; }
        public DbSet<RezervasyonArac> RezervasyonAracs { get; set; }
        public DbSet<RezervasyonKamp> RezervasyonKamps { get; set; }
        public DbSet<RezervasyonRestoran> RezervasyonRestorans { get; set; }

        //Çoka çoktan oluşan tablolara composit key atama işlemi MİCROSOFT.ENTİTİYFRAMEWORKCORE İNDİREMEDİĞİM İÇİN BU YÖNTEM DEVRE DIŞI.
        //protected override void OnModelCreating(ModelBuilder modelBuilder)
        //{
        //    // Kompozit Anahtar Tanımlamaları
        //    modelBuilder.Entity<RezervasyonOtel>()
        //        .HasKey(ro => new { ro.OtelId, ro.KampanyaId });

        //    modelBuilder.Entity<RezervasyonArac>()
        //        .HasKey(ra => new { ra.AracId, ra.KampanyaId });

        //    modelBuilder.Entity<RezervasyonKamp>()
        //        .HasKey(rk => new { rk.KampanyaId });

        //    modelBuilder.Entity<RezervasyonRestoran>()
        //        .HasKey(rr => new { rr.RestoranId, rr.KampanyaId });

        //    modelBuilder.Entity<RezervasyonTur>()
        //        .HasKey(rt => new { rt.TurId, rt.KampanyaId });
        //}
    }
}