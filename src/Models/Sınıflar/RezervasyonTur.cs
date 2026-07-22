using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace TravelTripProje.Models.Sınıflar
{
    public class RezervasyonTur
    {
        [Key]
        public int Rtur_ID { get; set; }
        public int Kullanici_ID { get; set; } //Foreign Key
        public int Tur_ID { get; set; } //Foreign Key
        public DateTime Baslangic_Tarihi { get; set; }
        public DateTime Bitis_Tarihi { get; set; }
        //Relational Properties
        public virtual Tur Tur { get; set; }
        public virtual Kullanicilar Kullanicilar { get; set; }
    }
}