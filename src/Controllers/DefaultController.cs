using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Optimization;
using TravelTripProje.Models.Sınıflar;

namespace TravelTripProje.Controllers
{
    public class DefaultController : Controller
    {
        Context c = new Context();
        // GET: Default
        public ActionResult Index()
        {
            ViewBag.ActivePage = "Ana Sayfa";
            var degerler = c.Otels.OrderByDescending(x => x.Otel_ID).Take(3).ToList();
            return View(degerler);
        }
        public ActionResult About()
        {
            ViewBag.ActivePage = "Hakkımızda";
            ViewBag.ActivePage = "Hakkımızda";

            var otelyorumlar = c.Yorumlars
                .OrderByDescending(y => y.ID)
                .Take(50)
                .Select(y => new YorumViewModel
                {
                    KullaniciAdSoyad = y.Kullanici.AdSoyad,
                    OtelAdi = y.Otel.Ad,
                    Yorum = y.Yorum.Length > 50 ? y.Yorum.Substring(0, 50) + "..." : y.Yorum,
                    Yildiz = y.Derecelendirme,
                    YorumTarihi = y.YorumTarihi,
                    Otel_ID = y.Otel_ID
                }).ToList();

            var turyorumlar = c.YorumlarTURs
                .OrderByDescending(y => y.ID)
                .Take(50)
                .Select(y => new YorumViewModel
                {
                    KullaniciAdSoyad = y.Kullanici.AdSoyad,
                    OtelAdi = y.Tur.Ad,
                    Yorum = y.Yorum.Length > 50 ? y.Yorum.Substring(0, 50) + "..." : y.Yorum,
                    Yildiz = y.Derecelendirme,
                    YorumTarihi = y.YorumTarihi,
                    Tur_ID = y.Tur_ID
                }).ToList();

            var model = new AboutViewModel
            {
                OtelYorumlar = otelyorumlar,
                TurYorumlar = turyorumlar
            };

            return View(model);
        }
        //public PartialViewResult Partial1() ARABA FALAN KOYABİLİRİZ BU PARTİALA
        //{
        //    var degerler = c.Blogs.OrderByDescending(x=>x.ID).Take(4).ToList();
        //    return PartialView(degerler);
        //}
        public PartialViewResult Partial3()
        {
            var deger = c.Turs.Take(3).ToList();
            return PartialView(deger);
        }
        public PartialViewResult Partial4()
        {
            var deger = c.Otels.Take(3).ToList();
            return PartialView(deger);
        }
        public ActionResult iletisim()
        {
            ViewBag.ActivePage = "İletişim";
            return View();
        }
    }
}
