using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace TravelTripProje.Models.Sınıflar
{
    public class Arac
    {
        [Key]
        public int Arac_ID { get; set; }
        public string Marka { get; set; } //nvarchar
        public string Model { get; set; } //nvarchar
        public string Plaka { get; set; } //nvarchar
        public int Sehir_ID { get; set; } //Foreign Key
        public int ülke_ID { get; set; } //Foreign Key
        //Relational Properties
        public virtual List<RezervasyonArac> RezervasyonAracs { get; set; }
        public virtual Sehir Sehir { get; set; }
        public virtual ülke ülke { get; set; }

    }
}