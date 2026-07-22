using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using TravelTripProje.Models.Sınıflar;

namespace TravelTripProje.Controllers
{
    public class KampanyaController : Controller
    {
        // GET: Kampanya
        Context c = new Context();
        public ActionResult Index()
        {
            ViewBag.ActivePage = "Kampanyalar";
            var model = new KampanyaViewModel
            {
                Oteller = c.Otels.Include("OtelKategori").ToList(),
                Turlar = c.Turs.Include("TurKategori").ToList()
            };
            return View(model);
        }
    }
}