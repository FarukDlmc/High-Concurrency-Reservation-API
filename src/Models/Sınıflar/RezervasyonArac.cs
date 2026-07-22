using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace TravelTripProje.Models.Sınıflar
{
    public class RezervasyonArac
    {
        [Key]
        public int Rarac_ID { get; set; }
        public int Arac_ID { get; set; } //Foreign Key
        public int Kullanici_ID { get; set; } //Foreign Key
        public DateTime Baslangic_Tarihi { get; set; }
        public DateTime Bitis_Tarihi { get; set; }
        //Relational Properties
        public virtual Arac Arac { get; set; }
        public virtual Kullanicilar Kullanicilar { get; set;}
    }
}