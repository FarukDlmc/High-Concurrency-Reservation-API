using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using TravelTripProje.Models.Sınıflar;

namespace TravelTripProje.Controllers
{
    public class TurController : Controller
    {
        // GET: Tur
        Context c = new Context();
        public ActionResult Index()
        {
            ViewBag.ActivePage = "Tur";
            var turlar = c.Turs.ToList();
            return View(turlar);
        }
        public ActionResult TurDetay(int id)
        {
            var turlar = c.Turs.Where(o => o.Tur_ID == id).ToList();

            // Yorumlar ve kullanıcı bilgilerini eşleştir
            var turyorumlar = c.YorumlarTURs
                .Where(y => y.Tur_ID == id)
                .Select(y => new YorumViewModel
                {
                    KullaniciAdSoyad = c.Kullanicilars
                        .Where(k => k.Kullanici_ID == y.Kullanici_ID)
                        .Select(k => k.AdSoyad)
                        .FirstOrDefault(),
                    Mail = c.Kullanicilars
                        .Where(k => k.Kullanici_ID == y.Kullanici_ID)
                        .Select(k => k.Mail)
                        .FirstOrDefault(),
                    Yorum = y.Yorum,
                    YorumTarihi = y.YorumTarihi,
                    Yildiz = y.Derecelendirme
                })
                .ToList();

            // En son eklenen 4 turu getir
            var recentTours = c.Turs.OrderByDescending(o => o.Tur_ID).Take(4).ToList();

            var recentComments = c.YorumlarTURs
                .Where(y => y.Tur_ID == id) // Tur_ID'ye göre filtreleme
                .OrderByDescending(y => y.ID) // Yorum_ID'ye göre azalan sıralama
                .Take(4)
                .Select(y => new YorumViewModel
                {
                    Yorum_ID = y.ID,
                    KullaniciAdSoyad = c.Kullanicilars
                        .Where(k => k.Kullanici_ID == y.Kullanici_ID)
                        .Select(k => k.AdSoyad)
                        .FirstOrDefault(),
                    Yorum = y.Yorum,
                    YorumTarihi = y.YorumTarihi
                })
                .ToList();

            // ViewModel'i oluştur
            var model = new TurYorum
            {
                Deger1 = turlar,
                Deger2 = turyorumlar,
                SonTurlar = recentTours,
                SonYorumlar = recentComments    
            };
            return View(model);
        }
        [HttpGet]
        public PartialViewResult YorumYap(int id)
        {
            ViewBag.deger = id;
            return PartialView();
        }
        [HttpPost]
        public PartialViewResult YorumYap(YorumlarTUR y, string AdSoyad, string Mail, int Rating)
        {
            // Kullanıcıyı AdSoyad ve Mail bilgisine göre bul
            var kullanici = c.Kullanicilars.FirstOrDefault(k => k.AdSoyad == AdSoyad && k.Mail == Mail);

            if (kullanici != null)
            {
                // Kullanıcı bilgilerini eşle
                y.Kullanici_ID = kullanici.Kullanici_ID;
                y.Derecelendirme = Rating; // Yıldız derecelendirmesini kaydet
                y.YorumTarihi = DateTime.Now; // Yorum tarihini kaydet

                // YorumlarTUR tablosuna ekle
                c.YorumlarTURs.Add(y);
                c.SaveChanges();
            }
            else
            {
                // Kullanıcı bulunamazsa hata mesajı
                ModelState.AddModelError("", "Girilen Ad Soyad ve Mail'e ait bir kullanıcı bulunamadı.");
            }

            return PartialView();
        }
    }
}