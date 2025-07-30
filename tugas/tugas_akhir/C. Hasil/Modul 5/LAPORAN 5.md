# 📝 Laporan Tugas Akhir

**Mata Kuliah**: Sistem Operasi  
**Semester**: Genap / Tahun Ajaran 2024–2025  
**Nama**: Bagus Alldiansyah  
**NIM**: 240202830  
**Modul yang Dikerjakan**:  
`Modul 5 – Audit dan Keamanan Sistem`

---

## 📌 Deskripsi Singkat Tugas

Modul ini bertujuan menambahkan fitur audit log ke dalam kernel `xv6-public`. Fitur ini mencatat setiap pemanggilan system call yang dilakukan oleh proses selama sistem berjalan.  
Hanya proses dengan **PID 1** yang dapat mengakses log ini melalui system call `get_audit_log()`, yang kemudian dapat ditampilkan oleh program `audit` pada level user-space.

---

## 🛠️ Rincian Implementasi

1. Membuat struktur `struct audit_entry` untuk menyimpan informasi syscall: `pid`, `syscall_num`, dan `tick`.
2. Menambahkan buffer audit log di kernel beserta variabel indeks untuk menyimpan entri.
3. Menyusun fungsi `log_syscall()` yang dipanggil di setiap syscall agar tercatat otomatis.
4. Menambahkan system call `get_audit_log()` yang memungkinkan PID 1 membaca isi log.
5. Mendaftarkan syscall baru ke dalam `sysproc.c`, `syscall.c`, `syscall.h`, `usys.S`, dan `user.h`.
6. Membuat program `audit.c` di user-space untuk menampilkan isi audit log.
7. Menambahkan `audit` ke daftar `UPROGS` dalam `Makefile`.

---

## ✅ Pengujian Fungsionalitas

Program uji `audit` digunakan untuk menampilkan isi audit log berdasarkan hak akses proses:

### **1. audit**
- Menjalankan `audit` dari proses dengan PID selain 1 → akses ditolak.
- Menjalankan `audit` dari proses PID 1 → isi log ditampilkan.
- Semua system call otomatis tercatat ke dalam log saat dipanggil.

---

## 📷 Dokumentasi Hasil Uji

### 📍 Output dari `audit` saat dijalankan oleh proses selain PID 1:

```
$ audit
Access denied or error.
```

### 📍 Output dari `audit` saat dijalankan oleh proses PID 1:

```
=== Audit Log ===
[0] PID=1 SYSCALL=5 TICK=2
[1] PID=1 SYSCALL=6 TICK=2
[2] PID=1 SYSCALL=10 TICK=3
```


---

## ⚠️ Kendala yang Dihadapi

1. **Akses Log Terbatas ke PID 1**  
   Untuk melakukan pengujian, perlu memodifikasi `init.c` agar `audit` dijalankan oleh proses pertama (PID 1).

2. **Log Kosong di Awal**  
   Jika belum ada syscall dilakukan, maka audit log masih kosong saat dibaca.

3. **Kapasitas Log Terbatas**  
   Audit buffer memiliki batasan jumlah entri (misalnya 128); perlu pengelolaan agar tidak terjadi overflow.

4. **Kesalahan Penanganan Pointer**  
   Bug pada penggunaan pointer atau argumen syscall dapat menyebabkan log tidak ditampilkan dengan benar.

---

## 📚 Referensi

- Buku xv6 MIT: [https://pdos.csail.mit.edu/6.828/2018/xv6/book-rev11.pdf](https://pdos.csail.mit.edu/6.828/2018/xv6/book-rev11.pdf)  
- Repositori xv6-public: [https://github.com/mit-pdos/xv6-public](https://github.com/mit-pdos/xv6-public)  
- Forum diskusi, Stack Overflow, GitHub Issues, dan materi praktikum

---

