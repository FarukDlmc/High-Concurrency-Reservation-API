using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using TravelTripProje.Models.Sınıflar;

namespace TravelTripProje.Controllers
{
    public class MusteriController : Controller
    {
        // GET: Musteri
        Context c = new Context();
        // GET: MusteriBilgi
        public ActionResult Index()
        {
            return View();
        }
        [HttpGet]
        public ActionResult Bilgilerim()
        {
            // Oturumdaki kullanıcının adını alıyoruz.
            var adSoyad = Session["AdSoyad"] as string;
            if (string.IsNullOrEmpty(adSoyad))
            {
                return RedirectToAction("KullaniciLogin", "GirişYap"); // Kullanıcı oturum açmamışsa giriş sayfasına yönlendir.
            }

            // Kullanıcı bilgilerini veritabanından çekiyoruz.
            var bilgiler = c.Kullanicilars.FirstOrDefault(x => x.AdSoyad == adSoyad);
            if (bilgiler == null)
            {
                return RedirectToAction("KullaniciLogin", "GirişYap"); // Kullanıcı bulunamadıysa giriş sayfasına yönlendir.
            }

            return View(bilgiler); // Kullanıcı bilgilerini view'a gönderiyoruz.
        }
        [HttpPost]
        public ActionResult Bilgilerim(Kullanicilar model)
        {
            var mevcutKullanici = c.Kullanicilars.FirstOrDefault(x => x.Kullanici_ID == model.Kullanici_ID);
            if (mevcutKullanici != null)
            {
                mevcutKullanici.AdSoyad = model.AdSoyad;
                mevcutKullanici.Telefon = model.Telefon;
                mevcutKullanici.Mail = model.Mail;
                mevcutKullanici.Sifre = model.Sifre;

                Session["AdSoyad"] = mevcutKullanici.AdSoyad;

                c.SaveChanges(); // Değişiklikleri veritabanına kaydet.
            }
            else if (mevcutKullanici.AdSoyad == "" && mevcutKullanici.Sifre == "")
            {
                ViewBag.ErrorMessage = "Lütfen tüm alanları doldurun.";
            }
            return RedirectToAction("Bilgilerim"); // Güncellemeden sonra aynı sayfaya yönlendir.
        }
        public ActionResult LogOut()
        {
            FormsAuthentication.SignOut();
            Session.Clear();
            return RedirectToAction("Index", "Default");
        }
        //public ActionResult Premium()
        //{
        //    return View();  
        //}
    }
}