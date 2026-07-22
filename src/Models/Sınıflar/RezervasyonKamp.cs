using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace TravelTripProje.Models.Sınıflar
{
    public class RezervasyonKamp
    {
        [Key]
        public int Rkamp_ID { get; set; }
        public int Kullanici_ID { get; set; } //Foreign Key
        public int Kamp_ID { get; set; } //Foreign Key
        public DateTime Baslangic_Tarihi { get; set; }
        public DateTime Bitis_Tarihi { get; set; }
        //Relational Properties
        public virtual Kamp Kamp { get; set; }
        public virtual Kullanicilar Kullanicilar { get; set;}
    }
}