# Dashboard Monitoring Pelaksanaan SE2026 — Kabupaten Buleleng

Dashboard statis untuk memantau status pencacahan Sensus Ekonomi 2026 (rekap
per kecamatan, desa, SLS, sub-SLS, dan petugas) lengkap dengan peta sebaran.

🔗 **Situs:** _(isi setelah GitHub Pages aktif)_ `https://<username>.github.io/<repo>/`

## Cara memperbarui data

Seluruh proses dilakukan **di komputer lokal**, lalu hasilnya di-_push_ ke GitHub:

1. Timpa file **`SQLPad.xlsx`** dengan ekspor terbaru (nama file harus tetap sama,
   sheet **Master Wilayah** dengan kolom yang sama).
2. Dobel-klik **`Publish_ke_GitHub.bat`**.
   Script akan: membangun ulang `index.html` dari Excel → `commit` → `push`.
3. GitHub Pages otomatis menyegarkan situs dalam ~1–2 menit.

## Catatan

- `index.html` bersifat **statis & mandiri** (data, geometri peta, dan Leaflet
  sudah tertanam). Tidak ada koneksi ke server/spreadsheet saat dibuka.
- Hanya `index.html` (beserta README & script ini) yang di-_publish_. Data mentah
  (`SQLPad.xlsx`, `*.geojson`, folder `_build/`) **tidak** diunggah — diatur oleh
  `.gitignore`.
- Membangun ulang butuh Python + paket `pandas`, `openpyxl`, `geopandas`.

## Setup awal GitHub (sekali saja)

```bash
# di folder ini, repo lokal sudah di-init & commit pertama sudah dibuat
git remote add origin https://github.com/<username>/<repo>.git
git push -u origin main
```

Lalu di GitHub: **Settings → Pages → Source: Deploy from a branch → Branch: `main` / root**.

---

## Menduplikasi untuk kabupaten lain

Semua nilai khas kabupaten sudah dipusatkan di **`config.json`**, dan ada **form
setup** sehingga tidak perlu mengedit kode sama sekali. Default bawaan = Buleleng.

### Yang perlu disiapkan tiap kabupaten

| Item | Keterangan |
|---|---|
| Kode & nama kabupaten | mis. `5108` / Buleleng (kode 4 digit) |
| Server SQLPad + ID query | URL SQLPad provinsi & ID query yang dipakai |
| Login SQLPad | email & password (disimpan lokal di `sqlpad_login.json`) |
| Repo GitHub + Pages | repo kosong baru milik kabupaten itu |
| 3 file peta | geojson **kecamatan, desa, SLS** kabupaten itu |
| `SQLPad.xlsx` | berisi sheet **Master Wilayah** (alokasi petugas) kabupaten itu |

> Jadwal survei (tanggal mulai & total hari) bersifat nasional — biasanya sama.

### Langkah-langkah

1. **Siapkan folder.** Copy seluruh folder ini ke komputer kabupaten tujuan.
   Pastikan Python (paket `pandas`, `openpyxl`, `geopandas`, `playwright`) dan
   **Git** sudah terpasang.

2. **Buat repo GitHub kabupaten itu.** Buat repository baru (boleh kosong) di
   akun/organisasi kabupaten, lalu aktifkan **Settings → Pages → Branch: `main` /
   root**. Catat URL repo (`...git`) dan URL Pages.

3. **Jalankan form setup.** Dobel-klik **`Setup_Kabupaten.bat`** → form terbuka di
   `http://localhost:8771/`. Isi:
   - **Identitas**: kode, nama, provinsi, zona waktu (WIB/WITA/WIT).
   - **SQLPad**: base URL, ID query, email & password login.
   - **GitHub**: URL repo & URL Pages dari langkah 2.
   - **Jadwal**: tanggal mulai & total hari.

   Klik **💾 Simpan Konfigurasi**.

4. **Upload file wilayah** (di bagian bawah form): pilih lalu **Upload** untuk
   peta **Kecamatan**, **Desa**, **SLS**, dan **`SQLPad.xlsx`**. Saat geo
   kecamatan terunggah, **daftar kode kecamatan terisi otomatis**. Tutup jendela
   setup bila sudah selesai.

5. **Jalankan dashboard.** Dobel-klik **`Auto_Publish_Standby.bat`** (mode
   otomatis: tarik data tiap 1 jam → build → push) atau **`Publish_ke_GitHub.bat`**
   (sekali jalan). **Push pertama** akan meminta **login GitHub sekali** lewat
   jendela yang muncul, lalu diingat Windows. Selesai — judul, peta, data, dan
   tujuan publish semuanya otomatis mengikuti kabupaten tersebut.

### Catatan teknis

- File hasil upload disimpan dengan nama standar `geo_kec.geojson`,
  `geo_desa.geojson`, `geo_sls.geojson`, dan `SQLPad.xlsx` — otomatis dipakai
  menggantikan file Buleleng.
- **Pindah komputer:** folder `.git` (hidden) sering tidak ikut tercopy. Tidak
  masalah — saat dijalankan, koneksi ke GitHub **dibuat ulang otomatis** tanpa
  menimpa file lokal (lihat `_build/ensure_git.py`). Cukup copy folder lengkap +
  login GitHub sekali.
- **Publish dari >1 komputer:** sebelum build, riwayat dari GitHub **digabung
  otomatis** ke lokal (tanpa kehilangan hari yang hanya ada di salah satu) dan
  commit dibuat berbasis remote terbaru, jadi `git push` tidak lagi ditolak
  *"fetch first"*. Bila tetap ada yang push barusan, push diulang otomatis
  setelah rebase. **Catatan:** kalau `Auto_Publish_Standby.bat` sedang berjalan,
  **restart** dulu agar logika sinkronisasi baru ini terpakai.
- `config.json`, `sqlpad_login.json`, dan semua file data **tidak** diunggah ke
  GitHub (diatur `.gitignore`) — aman tetap di lokal.
