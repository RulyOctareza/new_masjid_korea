<p align="center">
  <img src="docs/preview/hero.png" alt="Masjid Korea — ilustrasi aplikasi pencari masjid" width="100%">
</p>

<h1 align="center">Masjid Korea</h1>

<p align="center">
  <b>Pencari masjid terdekat di Korea Selatan.</b><br>
  Nama, alamat, foto kegiatan, dan navigasi langsung ke lokasi.
</p>

<p align="center">
  <a href="https://flutter.dev"><img alt="Flutter" src="https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white"></a>
  <img alt="BLoC" src="https://img.shields.io/badge/State-BLoC%20(Cubit)-2496ED">
  <a href="https://firebase.google.com"><img alt="Firestore" src="https://img.shields.io/badge/Data-Cloud%20Firestore-FFCA28?logo=firebase&logoColor=black"></a>
  <img alt="Platform" src="https://img.shields.io/badge/Platform-Android%20%7C%20Web-lightgrey">
</p>

---

## ✨ Preview

<p align="center">
  <img src="docs/preview/hero.png" alt="Mockup gelap Masjid Korea" width="90%">
</p>

<table align="center">
  <tr>
    <td><img src="screenshots/homepage.png" alt="Homepage" width="190"></td>
    <td><img src="screenshots/darkmode_homepage.png" alt="Homepage dark mode" width="190"></td>
    <td><img src="screenshots/searchpage.png" alt="Pencarian" width="190"></td>
    <td><img src="screenshots/detailpage_darkmode.png" alt="Detail masjid" width="190"></td>
  </tr>
  <tr>
    <td align="center">Home</td>
    <td align="center">Dark mode</td>
    <td align="center">Pencarian</td>
    <td align="center">Detail</td>
  </tr>
</table>

<table align="center">
  <tr>
    <td><img src="screenshots/comunity_mosque.png" alt="Komunitas" width="190"></td>
    <td><img src="screenshots/open_kakao.png" alt="Navigasi KakaoMap" width="190"></td>
    <td><img src="screenshots/splashpage.png" alt="Splash" width="190"></td>
  </tr>
  <tr>
    <td align="center">Komunitas</td>
    <td align="center">Navigasi KakaoMap</td>
    <td align="center">Splash</td>
  </tr>
</table>

---

## 📖 Tentang

Masjid Korea membantu muslim — terutama WNI dan pelajar — menemukan masjid di seluruh Korea
Selatan. Dibangun dengan Flutter, **BLoC (Cubit)**, dan pendekatan **Clean Architecture**
supaya mudah dirawat dan dikembangkan.

---

## 🌟 Fitur

- 🕌 Daftar masjid lengkap dengan nama, alamat, dan foto kegiatan
- 📏 **Jarak Haversine** dari lokasi pengguna ke masjid
- 🗺️ Navigasi ke masjid lewat **KakaoMap**
- ☁️ Data real-time di **Firebase Cloud Firestore**
- 🎭 Animasi Lottie untuk loading
- 🌗 Mode terang & gelap
- 📋 Salin alamat ke clipboard
- 🔎 Halaman pencarian masjid

---

## 🛠️ Tech Stack

| Area | Pilihan |
|---|---|
| Framework | Flutter (Android + Web) |
| State management | BLoC / Cubit |
| Backend | Firebase Cloud Firestore |
| Lokasi | `geolocator`, `location` |
| HTTP | Dio |
| Peta & navigasi | KakaoMap via `url_launcher` |
| Animasi | Lottie |

---

## 🚀 Menjalankan

```bash
flutter pub get
flutter run
```

Tambahkan konfigurasi Firebase (`firebase_options.dart`) dan API key KakaoMap sebelum build.

---

## 📄 Lisensi

MIT © Fatchurizkia Ruly Octareza
