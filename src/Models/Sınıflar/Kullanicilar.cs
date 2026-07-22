using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Reflection;
using System.Web;

namespace TravelTripProje.Models.Sınıflar
{
    public class Kullanicilar
    {
        [Key]
        public int Kullanici_ID { get; set; }
        public string AdSoyad { get; set; }
        public string Mail { get; set; } //nvarchar
        public string Sifre { get; set; } //nvarchar
        public string Telefon { get; set; } //nvarchar
        public enum Cinsiyet
        {
            Erkek = 1,
            Kadın = 2
        }
        //Relational Properties
        public virtual List<RezervasyonOtel> RezervasyonOtels { get; set; } //bir kullanıcı birden fazla otel rezervasyonu yapabilir.
        public virtual List<RezervasyonTur> RezervasyonTurs { get; set; } //bir kullanıcı birden fazla tur rezervasyonu yapabilir.
        public virtual List<RezervasyonArac> RezervasyonAracs { get; set; } //bir kullanıcı birden fazla arac rezervasyonu yapabilir.
        public virtual List<RezervasyonKamp> RezervasyonKamps { get; set; } //bir kullanıcı birden fazla kamp rezervasyonu yapabilir.
        public virtual List<RezervasyonRestoran> RezervasyonRestorans { get; set; } //bir kullanıcı birden fazla restoran rezervasyonu yapabilir.
        public ICollection<Yorumlar> Yorumlars { get; set; } //bir kullanıcı birden fazla otele yorum yapabilir.
        public ICollection<YorumlarTUR> YorumlarTURs { get; set; } //bir kullanıcı birden fazla tura yorum yapabilir.
    }
}