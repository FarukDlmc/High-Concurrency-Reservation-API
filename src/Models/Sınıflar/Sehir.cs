using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace TravelTripProje.Models.Sınıflar
{
    public class Sehir
    {
        [Key]
        public int Sehir_ID { get; set; }
        public string Ad { get; set; }
        //Relational Properties
        public virtual ICollection<Arac> Aracs { get; set; } //bir şehirde birden fazla arac bulunabilir.
        public ICollection<ilce> ilces { get; set; } //bir şehirde birden fazla ilçe olabilir.
        public virtual ICollection<Restoran> Restorans { get; set; } //bir şehirde birden fazla restoran bulunabilir.
        public ICollection<Kamp> Kamps { get; set; } //bir şehirde birden fazla kamp olabilir.
        public ülke Ülke { get; set; } //bir sehir sadece bir ülkede bulunur.
    }
}