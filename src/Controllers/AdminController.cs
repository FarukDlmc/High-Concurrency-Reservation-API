using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using TravelTripProje.Models.Sınıflar;

namespace TravelTripProje.Controllers
{
    public class AdminController : Controller
    {
        // GET: Admin
        Context c = new Context();
        [Authorize]
        public ActionResult Index()
        {
            var degerler = c.Otels.ToList();
            return View(degerler);
        }
        [HttpGet]
        public ActionResult YeniOtel()
        {
            return View();
        }
        [HttpPost]
        public ActionResult YeniOtel (Otel p)
        {
            c.Otels.Add(p);
            c.SaveChanges();
            return RedirectToAction("Index");
        }
        public ActionResult OtelSil(int id)
        {
            var b = c.Otels.Find(id);
            c.Otels.Remove(b);
            c.SaveChanges();
            return RedirectToAction("Index");
        }
        public ActionResult OtelGetir(int id)
        {
            var bl = c.Otels.Find(id);
            return View("OtelGetir", bl);
        }
        public ActionResult OtelGuncelle(Otel o)
        {
            var otl = c.Otels.Find(o.Otel_ID);
            if (otl == null)
            {
                return HttpNotFound("Güncellenecek otel bulunamadı.");
            }
            var kontrol = c.Otels.FirstOrDefault(x => x.Otel_ID == o.Otel_ID);
            if (kontrol == null)
            {
                return HttpNotFound("Güncellenecek kayıt yok");
            }
            if (o.Otel_ID == 0)
            {
                throw new Exception("Otel_ID boş geliyor.");
            }
            otl.Ad = o.Ad;
            otl.Yatak_Sayisi = o.Yatak_Sayisi;
            otl.Banyo_Sayisi = o.Banyo_Sayisi;
            otl.Kisi_Basi_Fiyat = o.Kisi_Basi_Fiyat;
            otl.Adres = o.Adres;
            otl.Kampanya_ID = o.Kampanya_ID;
            otl.OtelImage = o.OtelImage;
            otl.OtelKategori_ID = o.OtelKategori_ID;
            if (!c.OtelKategoris.Any(k => k.OtelKategori_ID == o.OtelKategori_ID))
            {
                throw new Exception("Geçersiz OtelKategori_ID. Bu ID OtelKategoris tablosunda bulunmuyor.");
            }
            c.SaveChanges();
            return RedirectToAction("Index");
        }
        public ActionResult YorumListesi()
        {
            var yorumlar=c.Yorumlars.ToList();
            return View(yorumlar);
        }
        public ActionResult YorumSil(int id)
        {
            var b = c.Yorumlars.Find(id);
            c.Yorumlars.Remove(b);
            c.SaveChanges();
            return RedirectToAction("YorumListesi");
        }
        public ActionResult YorumGetir(int id)
        {
            var yr = c.Yorumlars.Find(id);
            return View("YorumGetir", yr);
        }
        public ActionResult YorumGuncelle(Yorumlar y)
        {
            var yrm = c.Yorumlars.Find(y.ID);
            yrm.Derecelendirme=y.Derecelendirme;
            yrm.Otel_ID = y.Otel_ID;
            yrm.Yorum = y.Yorum;
            c.SaveChanges();
            return RedirectToAction("YorumListesi");
        }
        //--Tur
        [Authorize]
        public ActionResult TurIndex()
        {
            var degerler = c.Turs.ToList();
            return View(degerler);
        }
        [HttpGet]
        public ActionResult YeniTur()
        {
            return View();
        }
        [HttpPost]
        public ActionResult YeniTur(Tur t)
        {
            c.Turs.Add(t);
            c.SaveChanges();
            return RedirectToAction("TurIndex");
        }
        public ActionResult TurSil(int id)
        {
            var b = c.Turs.Find(id);
            c.Turs.Remove(b);
            c.SaveChanges();
            return RedirectToAction("TurIndex");
        }
        public ActionResult TurGetir(int id)
        {
            var bl = c.Turs.Find(id);
            return View("TurGetir", bl);
        }
        public ActionResult TurGuncelle(Tur t)
        {
            var tur = c.Turs.Find(t.Tur_ID);
            if (tur == null)
            {
                return HttpNotFound("Güncellenecek tur bulunamadı.");
            }
            var kontrol = c.Turs.FirstOrDefault(x => x.Tur_ID == t.Tur_ID);
            if (kontrol == null)
            {
                return HttpNotFound("Güncellenecek kayıt yok");
            }
            if (t.Tur_ID == 0)
            {
                throw new Exception("Tur_ID boş geliyor.");
            }
            tur.Ad = t.Ad;
            tur.Kisi_Basi_Fiyat = t.Kisi_Basi_Fiyat;
            tur.Rota = t.Rota;
            tur.Kampanya_ID = t.Kampanya_ID;
            tur.ülke_ID = t.ülke_ID;
            tur.TurImage = t.TurImage;
            tur.TurKategori_ID = t.TurKategori_ID;
            if (!c.TurKategoris.Any(k => k.TurKategori_ID == t.TurKategori_ID))
            {
                throw new Exception("Geçersiz TurKategori_ID. Bu ID TurKategoris tablosunda bulunmuyor.");
            }
            c.SaveChanges();
            return RedirectToAction("TurIndex");
        }
        public ActionResult TurYorumListesi()
        {
            var yorumlarTur = c.YorumlarTURs.ToList();
            return View(yorumlarTur);
        }
        public ActionResult TurYorumSil(int id)
        {
            var b = c.YorumlarTURs.Find(id);
            c.YorumlarTURs.Remove(b);
            c.SaveChanges();
            return RedirectToAction("TurYorumListesi");
        }
        public ActionResult TurYorumGetir(int id)
        {
            var yrtur = c.YorumlarTURs.Find(id);
            return View("TurYorumGetir", yrtur);
        }
        public ActionResult TurYorumGuncelle(YorumlarTUR yt)
        {
            var yrm = c.YorumlarTURs.Find(yt.ID);
            yrm.Derecelendirme = yt.Derecelendirme;
            yrm.Tur_ID = yt.Tur_ID;
            yrm.Yorum = yt.Yorum;
            c.SaveChanges();
            return RedirectToAction("TurYorumListesi");
        }
    }
}