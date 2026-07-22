using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TravelTripProje.Models.Sınıflar
{
    public class AboutViewModel
    {
        public List<YorumViewModel> OtelYorumlar { get; set; }
        public List<YorumViewModel> TurYorumlar { get; set; }
    }
}