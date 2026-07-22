using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls.WebParts;

namespace TravelTripProje.Models.Sınıflar
{
    public class Tur
    {
        [Key]
        public int Tur_ID { get; set; }
        public string Ad { get; set; }
        public string Kisi_Basi_Fiyat { get; set; } //nvarchar
        public string Rota { get; set; }
        public int? Kampanya_ID { get; set; }
        public int ülke_ID { get; set; }
        public string TurImage { get; set; }
        public int TurKategori_ID { get; set; }

        //Relational Properties
        public virtual List<RezervasyonTur> RezervasyonTurs { get; set; }
        public Kampanyalar Kampanya { get; set; } //Bir turda yalnızca bir kampanya bulunabilir.
        public ülke ülke { get; set; } //Bir tur yalnızca bir ülkede bulunabilir.
        public TurKategori TurKategori { get; set; } //Bir turun sadece bir kategorisi olabilir.
        public ICollection<YorumlarTUR> YorumlarTURs { get; set; } //bir turun birden fazla yorumu olabilir.
    }
}