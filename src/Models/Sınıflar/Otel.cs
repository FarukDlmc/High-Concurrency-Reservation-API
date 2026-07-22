using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace TravelTripProje.Models.Sınıflar
{
    public class Otel
    {
        [Key]
        public int Otel_ID { get; set; }
        public string Ad { get; set; }
        public int Yatak_Sayisi { get; set; }
        public int Banyo_Sayisi { get; set; }
        public string Kisi_Basi_Fiyat { get; set; } //nvarchar
        public string Adres { get; set; } //nvarchar
        public int OtelKategori_ID { get; set; }
        public int? Kampanya_ID { get; set; }
        public string OtelImage { get; set; }

        //Relational Properties
        public virtual List<RezervasyonOtel> RezervasyonOtels { get; set; }

        //public ICollection<Kullanicilar> Kullanicilar { get; set; } = new List<Kullanicilar>(); ARA TABLODA EK VERİ TUTMAYA GEREK YOKSA BU YAPI KULLANILIR
        public ICollection<Yorumlar> Yorumlars { get; set; } //bir otelin birden fazla yorumu olabilir.
        public Kampanyalar Kampanya { get; set; } //Bir otelde sadece bir kampanya olabilir (olmayadabilir).
        public OtelKategori OtelKategori { get; set; } //Bir otelin sadece bir kategorisi olabilir.
    }
}