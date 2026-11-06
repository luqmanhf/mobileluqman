# 📱 Mobile Luqmann (mobileluqman)

Aplikasi mobile berbasis **Flutter** multi-fitur yang mengintegrasikan informasi berita daring (*News*), katalog komik (*Manhwa*), serta manajemen catatan harian (*Note App*) dengan persistensi basis data lokal **SQLite**.

---

## 📑 Daftar Isi
- [Fitur Utama](#-fitur-utama)
- [Teknologi & Dependensi](#-teknologi--dependensi)
- [Struktur Direktori Proyek](#-struktur-direktori-proyek)
- [Prasyarat Sistem](#-prasyarat-sistem)
- [Cara Menjalankan Proyek](#-cara-menjalankan-proyek)
  - [1. Persiapan Awal](#1-persiapan-awal)
  - [2. Menjalankan Emulator Google Pixel 6](#2-menjalankan-emulator-google-pixel-6)
  - [3. Menjalankan Aplikasi](#3-menjalankan-aplikasi)
- [Perintah Build (Opsional)](#-perintah-build-opsional)
- [Catatan & Troubleshooting](#-catatan--troubleshooting)

---

## Fitur Utama

Aplikasi memiliki antarmuka utama yang mudah diakses melalui tab navigasi di dashboard:

1. **📰 Berita (News Page)**
   - Integrasi REST API dengan [NewsAPI](https://newsapi.org/) untuk menyajikan berita bisnis terhangat.
   - Menampilkan daftar artikel dengan thumbnail, judul, deskripsi singkat, dan tanggal rilis.
   - Halaman detail berita interaktif untuk membaca artikel secara lengkap.

2. **📚 Komik (Book / Manhwa Page)**
   - Katalog manhwa/komik dengan daftar judul populer.
   - Menampilkan rating, kategori/genre, harga koin, serta gambar sampul lokal.
   - Halaman detail komik lengkap dengan banner dan ringkasan sinopsis cerita.

3. **📝 Catatan (Note App CRUD)**
   - Manajemen catatan pribadi berbasis database lokal **SQLite** (`sqflite`).
   - Tampilan visual kartu catatan dinamis menggunakan **Staggered Grid View** (`MasonryGridView`).
   - Operasi CRUD Lengkap:
     - **Create**: Membuat catatan baru dengan pengaturan prioritas dan status penting.
     - **Read**: Membaca daftar catatan serta melihat detail isi catatan.
     - **Update**: Mengedit judul, deskripsi, atau prioritas catatan.
     - **Delete**: Menghapus catatan yang sudah tidak diperlukan.

4. **🎨 Tampilan & Tipografi**
   - Menggunakan font kustom **JetBrainsMono** untuk nuansa modern dan rapi.
   - Navigasi responsif menggunakan Dart 3 *switch expression*.

---

## 🛠 Teknologi & Dependensi

Proyek ini dibangun menggunakan:
- **Flutter SDK**: `>=3.2.0 <4.0.0`
- **Dart SDK**: `^3.0.0`
- **Dependensi Utama (`pubspec.yaml`)**:
  - `http`: Pengambilan data API berita dari NewsAPI.
  - `sqflite` & `path`: Persistensi basis data lokal SQLite untuk aplikasi catatan.
  - `flutter_staggered_grid_view`: Tampilan grid asimetris/masonry untuk kartu catatan.
  - `intl`: Pemformatan tanggal dan waktu.
  - `cupertino_icons`: Ikon gaya iOS/Material pendukung.

---

## 📂 Struktur Direktori Proyek

```text
mobileluqman/
├── android/                   # Kode native dan konfigurasi platform Android
├── ios/                       # Kode native dan konfigurasi platform iOS
├── images/                    # Aset gambar sampul komik dan banner aplikasi
│   ├── banner.webp
│   └── image1.webp - image9.webp
├── font/                      # Berkas font kustom
│   ├── JetBrainsMono-Light.ttf
│   └── JetBrainsMono-Bold.ttf
├── lib/
│   ├── main.dart              # Entry point aplikasi (Root Widget & Theme)
│   ├── home_page.dart         # Halaman utama dengan tab switch (News, Komik, Catatan)
│   ├── news/                  # Modul Berita
│   │   ├── client.dart        # HTTP Client untuk NewsAPI
│   │   ├── response_articles.dart # Model parsing JSON artikel
│   │   ├── news_page.dart     # Tampilan list berita
│   │   └── detail_news_page.dart # Tampilan detail isi berita
│   ├── book/                  # Modul Katalog Komik
│   │   ├── book.dart          # Model dan mock data daftar manhwa
│   │   ├── book_page.dart     # Tampilan list kartu komik
│   │   └── detail_page.dart   # Tampilan detail & sinopsis komik
│   └── noteapp/               # Modul Aplikasi Catatan (SQLite CRUD)
│       ├── db/
│       │   └── note_db.dart   # Helper database SQLite (Inisialisasi & Query)
│       ├── models/
│       │   └── note.dart      # Model data Note & mapping ke SQLite
│       ├── pages/
│       │   ├── note_page.dart        # Tampilan grid catatan & tombol tambah
│       │   ├── note_detail_page.dart # Tampilan detail catatan & tombol aksi
│       │   └── add_edit_note_page.dart # Form input/edit catatan
│       └── widgets/
│           ├── note_card_widgets.dart # Widget kartu catatan
│           └── note_form_widgets.dart # Widget form input catatan
├── pubspec.yaml               # Definisi dependensi, aset, dan font
└── README.md                  # Dokumentasi proyek
```

---

## 💻 Prasyarat Sistem

Sebelum menjalankan aplikasi, pastikan sistem Anda telah terpasang:
1. **Flutter SDK** versi 3.2.0 ke atas ([Panduan Instalasi Flutter](https://docs.flutter.dev/get-started/install)).
2. **Android Studio** atau **VS Code** dengan ekstensi Flutter & Dart.
3. **Android SDK** dan **Android Emulator** (khususnya AVD **Pixel 6**).
4. Verifikasi instalasi lingkungan Flutter dengan perintah:
   ```bash
   flutter doctor
   ```

---

## 🚀 Cara Menjalankan Proyek

### 1. Persiapan Awal
Buka terminal dan arahkan ke direktori proyek, lalu unduh semua dependensi yang diperlukan:
```bash
flutter pub get
```

### 2. Menjalankan Emulator Google Pixel 6
Proyek ini dikonfigurasi untuk dijalankan pada emulator **Pixel 6**.

Periksa daftar emulator yang tersedia di perangkat Anda:
```bash
flutter emulators
```

Jalankan emulator **Pixel 6**:
```bash
flutter emulators --launch Pixel_6
```
> Tunggu beberapa saat hingga emulator selesai booting dan siap digunakan.

### 3. Menjalankan Aplikasi
Setelah emulator Google Pixel 6 aktif, pastikan perangkat terdeteksi dengan menjalankan:
```bash
flutter devices
```

Jalankan aplikasi langsung ke emulator Pixel 6:
```bash
flutter run -d Pixel_6
```

Atau jika Pixel 6 adalah satu-satunya emulator yang sedang berjalan:
```bash
flutter run
```

> **Hot Reload & Hot Restart**:
> - Tekan tombol `r` pada terminal untuk melakukan **Hot Reload** (memperbarui perubahan kode secara instan).
> - Tekan tombol `R` untuk melakukan **Hot Restart**.
> - Tekan tombol `q` untuk menghentikan aplikasi.

---

## 📦 Perintah Build (Opsional)

Untuk menghasilkan berkas instalasi APK Android:
```bash
# Build APK rilis
flutter build apk --release

# Lokasi berkas hasil build:
# build/app/outputs/flutter-apk/app-release.apk
```

---

## 📌 Catatan & Troubleshooting

- **Koneksi Internet**: Modul **News** membutuhkan koneksi internet aktif untuk mengambil berita secara real-time dari NewsAPI. Jika berita gagal dimuat, periksa koneksi internet atau status API Key pada `lib/news/client.dart`.
- **Basis Data Catatan**: SQLite berjalan secara lokal pada perangkat. Setiap catatan yang disimpan akan tetap tersimpan di dalam memori internal emulator/perangkat meskipun aplikasi ditutup.
- **Font & Asset**: Semua font `JetBrainsMono` dan gambar katalog komik sudah terdaftar di `pubspec.yaml`. Jika ada aset baru yang ditambahkan, jalankan kembali `flutter pub get`.
