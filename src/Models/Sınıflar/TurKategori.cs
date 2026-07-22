using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace TravelTripProje.Models.Sınıflar
{
    public class TurKategori
    {
        [Key]
        public int TurKategori_ID { get; set; }
        public string turKategorisi { get; set; }
        //Relational Properties
        public ICollection<Tur> Turs { get; set; } //Bir kategori birden fazla tura ait olabilir.
    }
}