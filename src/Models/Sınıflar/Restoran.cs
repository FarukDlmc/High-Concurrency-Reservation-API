using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace TravelTripProje.Models.Sınıflar
{
    public class Restoran
    {
        [Key]
        public int Restoran_ID { get; set; }
        public string Ad { get; set; }
        public string Adres { get; set; } //nvarchar
        public string Fiyat_Kategorisi { get; set; }
        public string RestoranImage { get; set; }
        public int Sehir_ID { get; set; } //Foreign Key
        public int ülke_ID { get; set; }  //Foreign Key
        //Relational Properties
        public virtual List<RezervasyonRestoran> RezervasyonRestorans { get; set; }
        public MutfakKategori MutfakKategori { get; set; } //Bir restoranda sadece bir kategori olabilir diye kabul ettik.
        public virtual Sehir Sehir { get; set; } //Bir restoran sadece bir şehirde olabilir.
        public virtual ülke ülke { get; set; } //Bir restoran sadece bir ülkede olabilir.
    }
}