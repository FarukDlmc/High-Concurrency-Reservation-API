using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using TravelTripProje.Models.Sınıflar;

namespace TravelTripProje.Controllers
{
    public class OtelController : Controller
    {
        Context c = new Context();
        // GET: Otel
        public ActionResult Index()
        {
            ViewBag.ActivePage = "Otel";
            var oteller = c.Otels.Include(o => o.OtelKategori).ToList();
            return View(oteller);
        }
        public ActionResult OtelDetay(int id)
        {
            // Otelleri getir
            var oteller = c.Otels.Where(o => o.Otel_ID == id).ToList();

            // Yorumlar ve kullanıcı bilgilerini eşleştir
            var yorumlar = c.Yorumlars
                .Where(y => y.Otel_ID == id)
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
            // En son eklenen 4 oteli getir
            var recentPosts = c.Otels.OrderByDescending(o => o.Otel_ID).Take(4).ToList();

            var recentComments = c.Yorumlars
                .Where(y => y.Otel_ID == id) // Otel_ID'ye göre filtreleme
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
            var model = new OtelYorum
            {
                Deger1 = oteller,
                Deger2 = yorumlar,
                SonOteller = recentPosts, 
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
        public PartialViewResult YorumYap(Yorumlar y, string AdSoyad, string Mail, int Rating)
        {
            // Kullanıcıyı AdSoyad ve Mail bilgisine göre bul
            var kullanici = c.Kullanicilars.FirstOrDefault(k => k.AdSoyad == AdSoyad && k.Mail == Mail);

            if (kullanici != null)
            {
                // Kullanıcı bilgilerini eşle
                y.Kullanici_ID = kullanici.Kullanici_ID;
                y.Derecelendirme = Rating; // Yıldız derecelendirmesini kaydet
                y.YorumTarihi = DateTime.Now; // Yorum tarihini kaydet

                // Yorumlar tablosuna ekle
                c.Yorumlars.Add(y);
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