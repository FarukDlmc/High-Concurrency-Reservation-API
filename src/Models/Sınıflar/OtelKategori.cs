using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace TravelTripProje.Models.Sınıflar
{
    public class OtelKategori
    {
        [Key]
        public int OtelKategori_ID { get; set; }
        public string otelKategorisi { get; set; }
        //Relational Properties
        public ICollection<Otel> Otels { get; set; } //Bir kategori birden fazla otele ait olabilir.
    }
}