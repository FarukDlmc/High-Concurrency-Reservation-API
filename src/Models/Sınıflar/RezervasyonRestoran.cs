using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace TravelTripProje.Models.Sınıflar
{
    public class RezervasyonRestoran
    {
        [Key]
        public int Rrestoran_ID { get; set; }
        public int Restoran_ID { get; set; } //Foreign Key
        public int Kullanici_ID { get; set; } //Foreign Key
        public DateTime Tarih { get; set; }
        public TimeSpan Saat { get; set; }
        //Relational Properties
        public virtual Restoran Restoran { get; set; }
        public virtual Kullanicilar Kullanicilar { get; set; }
    }
}