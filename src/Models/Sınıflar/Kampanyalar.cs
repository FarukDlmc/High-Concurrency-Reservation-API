using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace TravelTripProje.Models.Sınıflar
{
    public class Kampanyalar
    {
        [Key]
        public int Kampanya_ID { get; set; }
        public string Ad { get; set; }
        //Relational Properties
        public ICollection<Otel> Otels { get; set; } //Bir kampanya birden fazla otele ait olabilir.
        public ICollection<Tur> Turs { get; set; } //Bir kampanya birden fazla tura ait olabilir.
    }
}