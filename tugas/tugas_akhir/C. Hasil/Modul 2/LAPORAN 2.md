# 📝 Laporan Tugas Akhir

**Mata Kuliah**: Sistem Operasi  
**Semester**: Genap / Tahun Ajaran 2024–2025  
**Nama**: Ahmad sultoni  
**NIM**: 240202850  
**Modul yang Dikerjakan**:  
`Modul 2 – Penjadwalan CPU Non-Preemptive Berbasis Prioritas`

---

## 📌 Deskripsi Singkat Tugas

**Modul 2 – Penjadwalan CPU Non-Preemptive Berbasis Prioritas**:

Modul ini bertujuan untuk mengganti algoritma penjadwalan default dalam kernel `xv6-public`, dari *Round Robin* menjadi *Non-Preemptive Priority Scheduling*.  
Setiap proses diberikan nilai prioritas, di mana angka yang lebih kecil menunjukkan prioritas yang lebih tinggi. Scheduler kemudian hanya akan memilih proses dalam status `RUNNABLE` dengan prioritas tertinggi, tanpa melakukan *preemption* terhadap proses yang sedang berjalan.

---

## 🛠️ Rincian Implementasi

1. Menambahkan field `priority` ke dalam struktur `proc` pada file `proc.h`.
2. Memberi nilai awal (default) pada `priority` dalam fungsi `allocproc()` di `proc.c`.
3. Menambahkan system call baru `set_priority(int)` untuk memungkinkan proses mengatur nilai prioritasnya.
4. Melakukan penyesuaian pada:
   - `syscall.h`, `syscall.c`, `user.h`, dan `usys.S` untuk mendaftarkan syscall.
   - `sysproc.c` untuk mengimplementasikan fungsi `sys_set_priority()`.
5. Mengubah logika dalam fungsi `scheduler()` di `proc.c` agar memilih proses `RUNNABLE` dengan prioritas tertinggi.
6. Menyusun program pengujian `ptest.c` untuk menguji hasil penjadwalan berdasarkan prioritas.
7. Mendaftarkan `ptest` pada bagian `UPROGS` di dalam file `Makefile`.

---

## ✅ Pengujian Fungsionalitas

Program uji `ptest` dirancang untuk mengamati urutan eksekusi proses berdasarkan nilai prioritas:

- Proses **Child 2** diberikan prioritas lebih tinggi (misalnya `10`).
- Proses **Child 1** diberikan prioritas lebih rendah (misalnya `90`).
- **Output yang diharapkan**: Proses dengan prioritas lebih tinggi (Child 2) akan menyelesaikan eksekusi terlebih dahulu, diikuti oleh Child 1.

---

## 📷 Dokumentasi Hasil Uji

### 📍 Contoh Output `ptest`:

```
Child 2 selesai
Child 1 selesai
Parent selesai
```

---

## ⚠️ Tantangan dan Solusi

1. **Prioritas Tidak Digunakan oleh Scheduler**  
   Meskipun field `priority` telah ditambahkan, scheduler belum mempertimbangkan nilainya karena bagian seleksi proses belum dimodifikasi.

2. **Proses Tetap Dieksekusi Secara Round Robin**  
   Terjadi karena loop scheduler tidak melakukan pemilihan berdasarkan nilai prioritas, sehingga perilaku sistem tetap seperti semula.

3. **Fungsi set_priority() Tidak Berfungsi**  
   Terjadi karena nilai `priority` tidak benar-benar diubah dalam struct proses, misalnya lupa menuliskan `p->priority = n`, atau tidak diterapkan pada proses turunan.

4. **Kesalahan Penomoran Syscall**  
   Gagal mendaftarkan syscall baru dengan benar di `syscall.h`, `syscall.c`, dan `usys.S`, menyebabkan fungsi tidak dikenali.

5. **Kernel Panic atau Gagal Kompilasi**  
   Masalah muncul akibat kesalahan dalam penanganan pointer atau struktur data pada `proc.c`, terutama ketika mengakses proses yang belum terinisialisasi atau bernilai NULL.

---

## 📚 Referensi

- Buku xv6 – MIT: [https://pdos.csail.mit.edu/6.828/2018/xv6/book-rev11.pdf](https://pdos.csail.mit.edu/6.828/2018/xv6/book-rev11.pdf)  
- Repositori xv6-public: [https://github.com/mit-pdos/xv6-public](https://github.com/mit-pdos/xv6-public)  
- Forum diskusi seperti Stack Overflow, GitHub Issues, serta tanya jawab saat praktikum

---

