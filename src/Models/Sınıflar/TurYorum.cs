using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TravelTripProje.Models.Sınıflar
{
    public class TurYorum
    {
        public IEnumerable<Tur> Deger1 { get; set; } // Birden fazla tur
        public IEnumerable<YorumViewModel> Deger2 { get; set; } // Yorum ve kullanıcı bilgileri
        public IEnumerable<Tur> SonTurlar { get; set; } // Son 4 tur
        public IEnumerable<YorumViewModel> SonYorumlar { get; set; } // Son 4 yorum
    }
}