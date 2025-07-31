# 📝 Laporan Tugas Akhir

**Mata Kuliah**: Sistem Operasi  
**Semester**: Genap / Tahun Ajaran 2024–2025  
**Nama**: Ahmad sultoni   
**NIM**: 240202850  
**Modul yang Dikerjakan**:  
`Modul 3 – Copy-on-Write Fork dan Shared Memory ala System V`

---

## 📌 Deskripsi Singkat Tugas

Modul ini berfokus pada penerapan dua fitur penting manajemen memori di kernel `xv6-public`:

1. **Copy-on-Write (CoW)**  
   Setelah proses melakukan `fork()`, memori antar parent dan child tidak langsung disalin. Sebaliknya, mereka berbagi halaman memori yang sama dalam mode read-only. Penyalinan hanya terjadi jika salah satu proses melakukan penulisan ke halaman tersebut.

2. **Shared Memory ala System V**  
   Dua atau lebih proses dapat saling bertukar data dengan memanfaatkan halaman memori bersama. Fitur ini diakses menggunakan system call `shmget()` dan dilepaskan melalui `shmrelease()` berdasarkan ID unik.

---

## 🛠️ Rincian Implementasi

### 📌 Fitur Copy-on-Write:

- Modifikasi fungsi `fork()` agar tidak menyalin semua halaman secara langsung.
- Halaman memori disetel menjadi read-only dan dibagikan antara parent dan child.
- Ketika terjadi penulisan ke halaman tersebut, sistem memicu page fault dan menciptakan salinan halaman baru.
- Fungsi baru `cowuvm()` ditambahkan, serta penanganan page fault diperbarui dalam `trap.c`.

### 📌 Fitur Shared Memory:

- Menambahkan dua buah syscall: `shmget()` untuk alokasi dan `shmrelease()` untuk pelepasan shared memory.
- ID shared memory dikelola secara unik (misal ID 0 hingga 7).
- Alamat alokasi ditentukan dari atas memori user (`USERTOP - PGSIZE * (id + 1)`).
- Status pemakaian dan reference count dari shared memory disimpan untuk sinkronisasi antar proses.

### 📌 File yang Dimodifikasi:

- `vm.c`, `trap.c`, `proc.c`, `syscall.c`, `sysproc.c`, `usys.S`,  
  `defs.h`, `memlayout.h`, `user.h`, `syscall.h`, dan lainnya.

---

## ✅ Program Pengujian

### **1. `cowtest`**  
Digunakan untuk menguji apakah proses parent dan child benar-benar berbagi halaman dan hanya menyalin saat penulisan terjadi.

### **2. `shmtest`**  
Memverifikasi bahwa dua proses dapat berbagi data melalui halaman yang sama menggunakan ID shared memory.

** 📍Contoh Output:**

```
  Child sees: Y
  
  Parent sees: X
```  
```
  Child reads: A
  
  Parent reads: B
```

---

## ⚠️ Kendala yang Dihadapi

1. **Panic saat Page Fault**  
   Terjadi karena kesalahan pengaturan bit proteksi halaman (read-only tidak diatur dengan benar).

2. **Halaman Tidak Disalin saat Write**  
   Sistem gagal melakukan duplikasi halaman saat menulis karena lupa memeriksa flag Copy-on-Write.

3. **Offset Salah pada USERTOP**  
   Perhitungan alamat shared memory yang salah menyebabkan halaman berbenturan dengan stack proses.

4. **Syscall `shmget()` Tidak Berfungsi**  
   Biasanya terjadi jika syscall tidak didaftarkan secara lengkap di semua file terkait atau mapping halaman tidak dilakukan.

---

## 📚 Referensi

- Buku xv6 MIT: [https://pdos.csail.mit.edu/6.828/2018/xv6/book-rev11.pdf](https://pdos.csail.mit.edu/6.828/2018/xv6/book-rev11.pdf)  
- Repositori xv6-public: [https://github.com/mit-pdos/xv6-public](https://github.com/mit-pdos/xv6-public)  
- Forum diskusi seperti Stack Overflow, GitHub Issues, serta diskusi selama praktikum

---


