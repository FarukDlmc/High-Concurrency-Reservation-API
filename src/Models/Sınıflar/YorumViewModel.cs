using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TravelTripProje.Models.Sınıflar
{
    public class YorumViewModel
    {
        public int Yorum_ID { get; set; }
        public int Otel_ID { get; set; }
        public string OtelAdi { get; set; }
        public int Tur_ID { get; set; }
        public string TurAdi { get; set; }
        public string KullaniciAdSoyad { get; set; }
        public string Yorum { get; set; }
        public DateTime YorumTarihi { get; set; }
        public int Yildiz { get; set; }
        public string Mail { get; set; }
    }
}