using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TravelTripProje.Models.Sınıflar
{
    public class OtelYorum
    {
        public IEnumerable<Otel> Deger1 { get; set; } // Birden fazla otel
        public IEnumerable<YorumViewModel> Deger2 { get; set; } // Yorum ve kullanıcı bilgileri
        public IEnumerable<Otel> SonOteller { get; set; } // Son 4 otel
        public IEnumerable<YorumViewModel> SonYorumlar { get; set; } // Son 4 yorum
        public IEnumerable<Yorumlar> Deger3 { get; set; }
    }
}