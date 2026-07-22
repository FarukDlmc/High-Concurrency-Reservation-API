using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Security.Policy;
using System.Web;

namespace TravelTripProje.Models.Sınıflar
{
    public class ülke
    {
        [Key]
        public int ülke_ID { get; set; }
        public string Ad { get; set; }
        public string ülkeImage { get; set; }
        //Relational Properties
        public ICollection<Tur> Turs { get; set; } //bir ülkede birden fazla tur bulunabilir.
        public virtual ICollection<Arac> Aracs { get; set; } //bir ülkede birden fazla arac bulunabilir.
        public virtual ICollection<Restoran> Restorans { get; set; } //bir ülkede birden fazla restoran bulunabilir.
        public ICollection<Kamp> Kamps { get; set; } //bir ülkede birden fazla kamp olabilir.
        public ICollection<Sehir> Sehirs { get; set;}//bir ülkede birden fazla sehir olabilir
    }
}