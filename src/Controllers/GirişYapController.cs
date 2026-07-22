using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using TravelTripProje.Models.Sınıflar;

namespace TravelTripProje.Controllers
{
    public class GirişYapController : Controller
    {
        // GET: GirişYap
        Context c = new Context();
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult Login()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Login(Admin ad)
        {
            var bilgiler = c.Admins.FirstOrDefault(x => x.Kullanici == ad.Kullanici && x.Sifre == ad.Sifre);
            if (bilgiler != null)
            {
                FormsAuthentication.SetAuthCookie(bilgiler.Kullanici, false);
                Session["Kullanici"] = bilgiler.Kullanici.ToString();
                return RedirectToAction("Index", "Admin");
            }
            else
            {
                return View();
            }
        }
        public ActionResult LogOut()
        {
            FormsAuthentication.SignOut();
            return RedirectToAction("Login", "GirişYap");
        }

        public ActionResult KullaniciLogin()
        {
            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]//.NET platformunun dış saldırılara karşı aldığı, bilgi isteyen kişi gerçekten sen misin diye kontrol eden önlemidir.
        public ActionResult KullaniciLogin(Kullanicilar kl)
        {

            var bilgiler = c.Kullanicilars.FirstOrDefault(x => x.AdSoyad == kl.AdSoyad && x.Sifre == kl.Sifre);
            if (bilgiler != null)
            {
                FormsAuthentication.SetAuthCookie(bilgiler.AdSoyad, false);
                Session["AdSoyad"] = bilgiler.AdSoyad.ToString();
                return RedirectToAction("Index", "Default");
            }
            else
            {
                Console.WriteLine("Kullanıcı bulunamadı");
                return View();
            }
        }


        [HttpGet]
        public ActionResult KullaniciSignUp()
        {
            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult KullaniciSignUp(Kullanicilar model)
        {
            // Kullanıcının aynı ad-soyad ve mail ile kayıtlı olup olmadığını kontrol et
            var AdAyni = c.Kullanicilars.FirstOrDefault(x => x.AdSoyad == model.AdSoyad);
            var MailAyni = c.Kullanicilars.FirstOrDefault(x => x.Mail == model.Mail);
            var TelAyni = c.Kullanicilars.FirstOrDefault(x => x.Telefon == model.Telefon);

            if (AdAyni != null)
            {
                ViewBag.ErrorMessage = "Zaten aynı isimde kullanıcı  kayıtlı.";
                return View("KullaniciSignUp", model); // Aynı formu hata mesajıyla tekrar göster
            }
            if (MailAyni != null)
            {
                ViewBag.ErrorMessage = "Bu e-posta adresi zaten kayıtlı.";
                return View("KullaniciSignUp", model); // Aynı formu hata mesajıyla tekrar göster
            }
            if (TelAyni != null)
            {
                ViewBag.ErrorMessage = "Bu tel zaten kayıtlı.";
                return View("KullaniciSignUp", model); // Aynı formu hata mesajıyla tekrar göster
            }

            // Eğer kayıtlı değilse, kullanıcıyı kaydet
            c.Kullanicilars.Add(model);
            c.SaveChanges();

            TempData["SuccessMessage"] = "Kayıt işlemi başarıyla tamamlandı!";
            return RedirectToAction("KullaniciLogin", "GirişYap");// Giriş sayfasına yönlendir
        }


        [HttpGet]
        public ActionResult SifreUnuttum()
        {
            return View();
        }

        [HttpPost]
        public ActionResult SifreUnuttum(string Mail, string YeniSifre, string YeniSifreTekrar)
        {
            //   string AnahtarKelime
            // Kullanıcıyı e-posta ve anahtar kelimeyle kontrol et  && x.AnahtarKelime == AnahtarKelime veri tabanına eklendikten sonra
            var user = c.Kullanicilars.FirstOrDefault(x => x.Mail == Mail);

            if (user == null)
            {
                ViewBag.ErrorMessage = "Mail adresine kayıtlı hesap bulunamamıştır.";
                return View();
            }

            // Şifrelerin eşleşip eşleşmediğini kontrol et
            if (YeniSifre != YeniSifreTekrar)
            {
                ViewBag.ErrorMessage = "Yeni şifreler eşleşmiyor.";

                return View();
            }


            // Şifreyi güncelle
            user.Sifre = YeniSifre;
            c.SaveChanges();


            return RedirectToAction("KullaniciLogin", "GirişYap");
        }
    }
}