using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Security.Principal;
using System.Web;

namespace TravelTripProje.Models.Sınıflar
{
    public class MutfakKategori
    {
        [Key]
        public int mutfakKategori_ID { get; set; }
        public string MutfakAdi { get; set; }

        //Relational Properties
        public ICollection<Restoran> Restorans { get; set; } //Bir mutfak kategorisi birden fazla restorana ait olabilir.
    }
}