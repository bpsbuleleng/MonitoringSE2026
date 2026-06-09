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
