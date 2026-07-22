using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace TravelTripProje.Models.Sınıflar
{
    public class YorumlarTUR
    {
        [Key]
        public int ID { get; set; }
        public string Yorum { get; set; }
        public int Tur_ID { get; set; }
        public int Kullanici_ID { get; set; }
        public int Derecelendirme { get; set; }
        public DateTime YorumTarihi { get; set; }
        //Relational Properties
        public Tur Tur { get; set; }//bir yorum bir otele ait olabilir.
        public Kullanicilar Kullanici { get; set; } //bir yorum bir kullanıcıya aittir
    }
}