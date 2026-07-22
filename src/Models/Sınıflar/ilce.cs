using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace TravelTripProje.Models.Sınıflar
{
    public class ilce
    {
        [Key]
        public int ilce_ID { get; set; }
        public string Ad { get; set; }
        public int Sehir_ID { get; set; } //Foreign Key
        //Relational Properties
        public virtual Sehir Sehir { get; set; } //Bir ilçe yalnızca bir şehirde bulunabilir.
    }
}