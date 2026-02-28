# 📋 Dokumentasi Aplikasi HealthRecord
## Sistem Manajemen Data Riwayat Kesehatan

---

## 1. Deskripsi Aplikasi

**HealthRecord** adalah aplikasi mobile berbasis Flutter yang dirancang untuk membantu pengguna mencatat, mengelola, dan memantau riwayat kesehatan pribadi secara terorganisir. Aplikasi ini menyediakan antarmuka yang bersih dan minimalis dengan color palette biru yang memberikan kesan profesional dan kepercayaan layaknya aplikasi medis modern.

Pengguna dapat menyimpan berbagai informasi penting dari setiap kunjungan ke dokter atau fasilitas kesehatan, mulai dari diagnosis, obat yang diresepkan, hingga data vital seperti tekanan darah dan berat badan. Dengan fitur CRUD (Create, Read, Update, Delete) yang lengkap, pengguna dapat dengan mudah menambah data baru, melihat detail rekam medis, mengedit informasi yang sudah ada, maupun menghapus data yang tidak diperlukan.

---

## 2. Fitur Aplikasi

### Fitur (CRUD)

| Fitur | Keterangan |
|-------|-----------|
| **Create** | Menambahkan data riwayat kesehatan baru melalui form input lengkap |
| **Read** | Menampilkan daftar semua riwayat dan detail lengkap per data |
| **Update** | Mengedit data riwayat yang sudah tersimpan |
| **Delete** | Menghapus data riwayat dengan konfirmasi dialog |

### Fitur Tambahan

- **Multi-Page Navigation** — Navigasi antar 4 halaman berbeda menggunakan `Navigator.push` dan `Navigator.pop`
- **Date Picker** — Memilih tanggal pemeriksaan menggunakan `showDatePicker` bawaan Flutter
- **Form Validation** — Validasi field wajib agar tidak kosong sebelum data disimpan
- **Snackbar Notifikasi** — Feedback visual saat data berhasil ditambah, diedit, atau dihapus
- **Alert Dialog Konfirmasi** — Konfirmasi sebelum menghapus data agar tidak terjadi penghapusan tidak sengaja
- **Dashboard** — Halaman utama yang menampilkan statistik total data dan riwayat terbaru
- **Sample Data** — 2 data contoh tersedia saat aplikasi pertama kali dibuka

---

## 3. Widget yang Digunakan

### Widget Struktur Dasar
| Widget | Kegunaan |
|--------|---------|
| `MaterialApp` | Root widget aplikasi, mengatur tema dan navigasi global |
| `Scaffold` | Struktur dasar tiap halaman (AppBar, body, FAB) |
| `AppBar` | Navigasi atas, judul halaman, dan tombol aksi |
| `CustomScrollView` + `SliverAppBar` | Efek AppBar yang dapat expand/collapse di Home Screen |

### Widget Layout
| Widget | Kegunaan |
|--------|---------|
| `Column` & `Row` | Susunan elemen vertikal dan horizontal |
| `Padding`, `SizedBox` | Jarak dan spasi antar elemen |
| `Expanded` | Mengisi ruang tersisa dalam Row/Column |
| `SingleChildScrollView` | Konten yang dapat di-scroll |
| `Container` | Custom styling, dekorasi, warna, dan border |

### Widget Data & List
| Widget | Kegunaan |
|--------|---------|
| `ListView.builder` | Menampilkan list riwayat secara efisien dan dinamis |
| `Card` | Wadah item riwayat dengan shadow dan border radius |
| `InkWell` | Area yang bisa diklik dengan efek ripple |

### Widget Input Form
| Widget | Kegunaan |
|--------|---------|
| `Form` + `GlobalKey<FormState>` | Mengelola state dan validasi form secara terpusat |
| `TextFormField` | Input teks dengan label, hint, icon, dan validasi bawaan |
| `ElevatedButton` | Tombol utama (Simpan, Edit) |
| `TextButton` | Tombol sekunder (Batal) |
| `OutlinedButton` | Tombol hapus dengan border merah |
| `IconButton` | Tombol ikon di AppBar |
| `FloatingActionButton.extended` | Tombol tambah data di List Screen |

### Widget Dialog & Feedback
| Widget | Kegunaan |
|--------|---------|
| `AlertDialog` | Konfirmasi dialog sebelum menghapus data |
| `SnackBar` | Notifikasi floating setelah aksi berhasil |
| `showDatePicker` | Picker kalender untuk memilih tanggal pemeriksaan |

### Widget Dekorasi
| Widget | Kegunaan |
|--------|---------|
| `BoxDecoration` | Kustomisasi tampilan container (gradient, border, radius) |
| `LinearGradient` | Efek gradasi biru pada header dan card |
| `Icon` | Ikon dari Material Icons |


<img width="797" height="1706" alt="image" src="https://github.com/user-attachments/assets/f049d159-f632-42b6-83b5-e8c471d182dd" />




<img width="799" height="1707" alt="image" src="https://github.com/user-attachments/assets/f18035e9-0ad6-495d-b001-feb9b8dc0960" />


---

## 4. Struktur File Proyek

```
health_record_app/
├── lib/
│   ├── main.dart                    # Entry point aplikasi
│   ├── models/
│   │   └── health_record.dart       # Model/class data riwayat kesehatan
│   ├── data/
│   │   └── health_data.dart         # In-memory data store (List global)
│   ├── theme/
│   │   └── app_theme.dart           # Konfigurasi tema dan color palette
│   ├── screens/
│   │   ├── home_screen.dart         # Dashboard / halaman utama
│   │   ├── list_screen.dart         # Daftar semua riwayat
│   │   ├── detail_screen.dart       # Detail data + tombol Edit & Hapus
│   │   └── form_screen.dart         # Form tambah dan edit data
│   └── widgets/
│       └── record_card.dart         # Komponen card untuk item list
└── pubspec.yaml                     # Konfigurasi dan dependensi Flutter
```

---

## 5. Alur Navigasi

```
HomeScreen
    │
    ├──→ ListScreen ──→ DetailScreen ──→ FormScreen (Edit)
    │         └──→ FormScreen (Tambah)
    │
    └──→ FormScreen (Tambah)
```

---

## 6. Color Palette

| Nama | Hex | Penggunaan |
|------|-----|-----------|
| Primary | `#1565C0` | AppBar, tombol utama, aksen |
| Primary Light | `#E3F2FD` | Background card, badge |
| Accent | `#42A5F5` | Gradasi, chevron |
| Background | `#FFFFFF` | Latar halaman |
| Surface | `#F8FAFF` | Input field, section card |
| Text Primary | `#1A1A2E` | Teks utama |
| Text Secondary | `#757575` | Teks sub, hint, label |
| Danger | `#EF5350` | Tombol dan ikon hapus |

---

## 7. Field Data (Model HealthRecord)

| Field | Tipe | Keterangan |
|-------|------|-----------|
| `id` | String | ID unik otomatis (timestamp) |
| `tanggal` | String | Tanggal pemeriksaan |
| `namaDokter` | String | Nama dokter / fasilitas kesehatan |
| `diagnosis` | String | Hasil diagnosis dokter |
| `obat` | String | Obat yang diresepkan |
| `tekananDarah` | String | Tekanan darah (format: 120/80) |
| `beratTinggi` | String | Berat dan tinggi badan |
| `catatan` | String | Catatan tambahan (opsional) |
