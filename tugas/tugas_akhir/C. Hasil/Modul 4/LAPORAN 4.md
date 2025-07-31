# 📝 Laporan Tugas Akhir

**Mata Kuliah**: Sistem Operasi  
**Semester**: Genap / Tahun Ajaran 2024–2025  
**Nama**: Ahmad sultoni   
**NIM**: 240202850  
**Modul yang Dikerjakan**:  
`Modul 4 – Subsistem Kernel Alternatif (chmod() dan /dev/random)`

---

## 📌 Deskripsi Singkat Tugas

Modul ini menambahkan dua fitur baru ke sistem operasi `xv6-public` sebagai bagian dari eksplorasi subsistem kernel lanjutan:

1. **System Call `chmod(path, mode)`**  
   Digunakan untuk mengatur mode akses file menjadi *read-only* (`mode = 1`) atau kembali ke *read-write* (`mode = 0`).

2. **Device File `/dev/random`**  
   Sebuah *character device* yang menghasilkan data acak setiap kali dibaca, layaknya `/dev/random` pada sistem UNIX modern.

---

## 🛠️ Rincian Implementasi

### 🔒 Fitur `chmod(path, mode)`

- Menambahkan implementasi syscall `chmod()` di `sysfile.c`.
- Menambahkan field `mode` pada struktur `inode` di `fs.h` untuk menyimpan status izin akses file.
- Memodifikasi fungsi `filewrite()` agar memeriksa nilai `f->ip->mode`. Jika `mode == 1`, maka operasi tulis akan diblokir.
- Mendaftarkan syscall ke dalam `syscall.c`, `syscall.h`, `user.h`, dan `usys.S`.

### 🔄 Fitur `/dev/random`

- Membuat file baru `random.c` yang berisi fungsi `randomread()` untuk menghasilkan byte acak.
- Mendaftarkan fungsi tersebut dalam tabel `devsw[]` pada `file.c`, agar dikenali sebagai device driver.
- Menambahkan node `/dev/random` melalui pemanggilan `mknod()` di `init.c` saat sistem boot.

---

## ✅ Pengujian Fungsionalitas

Dua program uji disusun untuk menguji kedua fitur utama:

### **1. chmodtest**  
Digunakan untuk memastikan bahwa file yang telah diubah menjadi *read-only* tidak dapat ditulis ulang oleh proses lain.
### **2. randomtest**  
Digunakan untuk memverifikasi bahwa `/dev/random` menghasilkan byte acak setiap kali dibaca.

** 📍Output yang Diharapkan:**

```
Write blocked as expected
```

**Output**
```
159 114 41 116 67 198 109 232
```


---

## ⚠️ Kendala yang Dihadapi

1. **Nilai Mode Tidak Persisten**  
   Field `mode` pada inode tidak disimpan ke disk sehingga nilainya hilang setelah reboot.

2. **Device Tidak Terdeteksi**  
   Terlupa menambahkan perintah `mknod("/dev/random", ...)` menyebabkan file device tidak dibuat sehingga `open()` gagal.

3. **Kesalahan Indeks pada `devsw[]`**  
   Jika posisi driver dalam array `devsw[]` tidak sesuai, maka fungsi pembacaan `randomread()` tidak dipanggil.

4. **Output Acak Tidak Bervariasi**  
   Menggunakan seed acak yang tetap (statis) menyebabkan data yang dihasilkan selalu sama setiap boot.

---

## 📚 Referensi

- Buku xv6 MIT: [https://pdos.csail.mit.edu/6.828/2018/xv6/book-rev11.pdf](https://pdos.csail.mit.edu/6.828/2018/xv6/book-rev11.pdf)  
- Repositori xv6-public: [https://github.com/mit-pdos/xv6-public](https://github.com/mit-pdos/xv6-public)  
- Diskusi praktikum, Stack Overflow, dan forum-forum pemrograman seperti GitHub Issues

---

