using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace TravelTripProje.Models.Sınıflar
{
    public class Kamp
    {
        [Key]
        public int Kamp_ID { get; set; }
        public string Ad { get; set; }
        public int Kisi_Basi_Fiyat { get; set; }
        //Relational Properties
        public virtual List<RezervasyonKamp> RezervasyonKamps { get; set; }
        public Sehir Sehir { get; set; }
        public ülke ülke { get; set; }

    }
}