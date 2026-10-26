# Rencana: Refactor home_page.dart ke luar folder book/ + 2 tombol navigasi

## Goal
Pindahkan `lib/book/home_page.dart` ke `lib/home_page.dart` (di luar folder book/ dan news/) sebagai shell halaman utama yang **hanya berisi AppBar + 2 tombol navigasi**. Pindahkan konten daftar manhwa ("Daftar Manhwa" + list builder) ke `lib/book/book_page.dart` yang ditujukan oleh tombol "Komik". Tombol "News" menuju `lib/news/news_page.dart`.

## Current context / assumptions
1. `lib/book/home_page.dart` saat ini menggabungkan: AppBar, row title + banner, "Daftar Manhwa" heading, dan book list (`ListView.builder`).
2. `lib/book/book.dart` menyimpan `listBook` (data daftar buku) — **tidak diubah**.
3. `lib/book/detail_page.dart` adalah `DetailPage` (detail buku) — **tidak diubah**.
4. `lib/news/news_page.dart` **kosong**; pengguna akan mengisinya manual.
5. Struktur target (dikonfirmasi pengguna):
   ```
   lib/
     home_page.dart        ← shell: AppBar + tombol News + tombol Komik
     book/
       book_page.dart      ← "Daftar Manhwa" + daftar buku
       detail_page.dart
       book.dart
     news/
       news_page.dart
   ```
6. Konfirmasi tambahan pengguna:
   - Book_page.dart berisi **hanya** daftar manhwa + list builder.
   - Tombol "Komik" diarahkan ke `book_page.dart`.
   - `news_page.dart` diisi manual oleh pengguna.
   - `main.dart` akan diupdate importnya ke `lib/home_page.dart`.

## Architecture / proposed approach
- **"Shell vs Content" split**: `home_page.dart` menjadi **halaman navigasi murni** (AppBar + 2 tombol). Konten manhwa dipindahkan ke `book_page.dart`. Pemisahan ini menjaga home_page.dart ringkas dan mudah diperluas nanti (tombol baru → import file konten baru).
- **Impor di `lib/home_page.dart`**:
  - `package:mobileluqman/news/news_page.dart` → untuk tombol "News".
  - `package:mobileluqman/book/book_page.dart` → untuk tombol "Komik".
- **`lib/main.dart`**: mengubah import dari `package:mobileluqman/book/home_page.dart` ke `package:mobileluqman/home_page.dart`.
- **`lib/book/book_page.dart`**: mengimpor `book.dart` (listBook) dan `detail_page.dart` (DetailPage). Tidak ada perubahan terhadap dependencies yang ada.
- **`lib/news/news_page.dart`**: **tidak diubah oleh saya** — pengguna mengisi manually. Rencana ini hanya memastikan tombol News menunjuk ke `NewsPage()` yang akan didefinisikan pengguna di file tersebut.

## Step-by-step tasks

### Task 1 — Buat `lib/book/book_page.dart`
**File:** `lib/book/book_page.dart`
Widget: `BookPage` — berisi "Daftar Manhwa" heading + list builder (menggantikan bagian konten di home_page.dart lama).

```dart
import 'package:flutter/material.dart';
import 'package:mobileluqman/book/book.dart';
import 'package:mobileluqman/book/detail_page.dart';

class BookPage extends StatelessWidget {
  const BookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Manhwa"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //SubTitle
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Daftar Manhwa",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),

              //ListBook
              ListView.builder(
                itemCount: listBook.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final book = listBook[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(book: book),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 100,
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5.0,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Image.asset(book.image, width: 60),
                          const SizedBox(width: 12),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                book.name,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                book.categoryBook,
                                style: const TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

**Verifikasi:** `flutter analyze lib/book/book_page.dart` → laporan 0 error.

---

### Task 2 — Buat `lib/home_page.dart` (dipindahkan ke luar folder book/)
**File:** `lib/home_page.dart`
Widget: `HomePage` — shell utama dengan AppBar + 2 tombol navigasi.

```dart
import 'package:flutter/material.dart';
import 'package:mobileluqman/news/news_page.dart';
import 'package:mobileluqman/book/book_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Komikers Si Luqman"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Tombol navigasi
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const NewsPage()),
                      );
                    },
                    icon: const Icon(Icons.article),
                    label: const Text("News"),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const BookPage()),
                      );
                    },
                    icon: const Icon(Icons.book),
                    label: const Text("Komik"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

**Catatan:** Row title + banner (`"Daftar Komik Kesukaan Kalian Ada Disini"` + `images/banner.webp`) yang tadinya ada di home_page.dart **tidak dimasukkan** karena struktur pengguna hanya memasukkan AppBar + tombol. Jika pengguna ingin mempertahankan judul + banner, mereka bisa menambahkannya di bawah AppBar di file ini.

**Verifikasi:** `flutter analyze lib/home_page.dart` → laporan 0 error.

---

### Task 3 — Perbarui `lib/main.dart` (ubah import home_page)
**File:** `lib/main.dart`

Ganti baris import:
```dart
import 'package:mobileluqman/book/home_page.dart';
```
menjadi:
```dart
import 'package:mobileluqman/home_page.dart';
```

**Verifikasi:** `flutter analyze` (seluruh proyek) → laporan 0 error.

---

### Task 4 — Konfirmasi definisi `NewsPage` di news_page.dart
Karena `lib/news/news_page.dart` **diisi manual pengguna**, pastikan pengguna menambahkan widget `NewsPage` di dalam file tersebut. Tombol "News" di `home_page.dart` (Task 2) menunjuk ke `NewsPage()`.

Contoh struktur yang harus ada (pengguna mengisi sesuai kebutuhan):
```dart
import 'package:flutter/material.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Berita"),
      ),
      body: const Center(
        child: Text("Halaman berita (diisi manual)."),
      ),
    );
  }
}
```

**Verifikasi:** Setelah pengguna menambahkan `NewsPage`, `flutter analyze` → 0 error. Tombol "News" dapat diklik dan membuka halaman berita.

---

### Task 5 — Uji navigasi manual
1. Jalankan aplikasi: `flutter run`
2. Klik tombol **News** → halaman berita dibuka (belum ada isi, karena diisi manual pengguna).
3. Klik tombol **Komik** → halaman daftar manhwa (`BookPage`) terbuka dengan "Daftar Manhwa" + list buku.

## Tests / validation
| Langkah | Command | Output yang diharapkan |
|------|---------|-----------------|
| Analyze book_page.dart | `flutter analyze lib/book/book_page.dart` | "0 errors" |
| Analyze home_page.dart | `flutter analyze lib/home_page.dart` | "0 errors" |
| Analyze seluruh proyek | `flutter analyze` | "0 errors" |
| Jalankan app + klik tombol | `flutter run` → klik "News" / "Komik" | Halaman berita dan halaman manhwa terbuka bergantian |
| Review git diff | `git diff --stat` | Hanya file yang diharapkan diubah; tidak ada file baru yang tidak sengaja diciptakan |

## Risks, tradeoffs, and open questions

**Tradeoffs / perubahan yang diambil**
- **Judul + banner dihilangkan dari home_page.dart**: Row `"Daftar Komik Kesukaan Kalian Ada Disini"` + `images/banner.webp` yang tadinya di home_page.dart tidak dimasukkan dalam shell baru. Jika ingin mempertahankan, tambahkan di bawah AppBar di `lib/home_page.dart`. (Tergantung keinginan pengguna — belum diubah karena struktur yang dikonfirmasi hanya memasukkan AppBar + tombol.)
- **Tombol "Komik" sekarang navigasi ke halaman terpisah**, bukan menampilkan daftar di halaman yang sama. Ini sesuai konfirmasi pengguna (book_page.dart = konten manhwa).
- **news_page.dart tidak diubah**: pengguna mengisi manual. Tombol News menunjuk ke `NewsPage()` yang pengguna harus mendefinisikan.

**Riwayat penyebab perubahan**
- `main.dart`: import `book/home_page.dart` → `home_page.dart`
- `lib/book/home_page.dart`: dihapus/dipindah ke `lib/home_page.dart`
- `lib/book/book_page.dart`: **dibuat baru** (menggantikan bagian konten di home_page.dart lama)

**Open questions**
1. Apakah pengguna ingin judul row + banner dipertahankan di `lib/home_page.dart`? (Tidak ada di struktur yang dikonfirmasi.)
2. Apakah tombol "Komik" tampil di home_page.dart, atau akan ada tombol lain di masa depan? (Struktur saat ini: 2 tombol dalam Row, rata-samping.)

## Assessment: Cocok atau belum?
**SESUAI** — struktur ini cocok untuk tujuan pengguna, dengan catatan:

- **Positif**: memisahkan navigasi (home_page.dart) dari konten (book_page.dart), menjadikan struktur lebih modular dan mudah diperluas. Setiap tombol baru hanya perlu import file konten baru, tanpa mengubah shell.
- **Catatan**: ini adalah refactor, bukan sekadar penambahan tombol. Home_page.dart lama (berisi AppBar + judul + banner + "Daftar Manhwa" + list) dibagi menjadi 2 file: shell baru di `lib/home_page.dart` dan konten di `lib/book/book_page.dart`.

Rekomendasi: **lanjutkan dengan refactor ini** — sesuai dengan konfirmasi pengguna dan menghasilkan struktur yang bersih. Hanya perhatikan satu titik: jika pengguna ingin menyimpan judul + banner di halaman utama, tambahkan kode tersebut kembali ke `lib/home_page.dart` setelah refactor selesai.
