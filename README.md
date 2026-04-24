README - Studi Kasus Validasi Data Akademik dengan Blok Prosedural MySQL
Deskripsi Proyek

Proyek ini merupakan implementasi blok prosedural dalam MySQL menggunakan stored procedure untuk melakukan validasi dan analisis data akademik mahasiswa. Sistem ini dirancang untuk mensimulasikan proses pengecekan kelayakan pengisian KRS (Kartu Rencana Studi).

Program mampu:

Menampilkan identitas mahasiswa
Memvalidasi data akademik
Mengelompokkan beban studi
Menentukan performa akademik
Menentukan kelayakan KRS
Membandingkan dua mahasiswa
Struktur Program

Program terdiri dari 4 stored procedure utama:

1. bagian_a (Identitas Mahasiswa)

Menampilkan informasi dasar mahasiswa:

Nama
NIM
Program Studi
Semester
Nama kampus (konstanta)

Output berupa kalimat identitas mahasiswa.

2. bagian_b (Validasi Data Akademik)

Melakukan:

Validasi data (UKT, semester, SKS)
Kategori beban studi:
1–12 → Ringan
13–18 → Sedang
19–24 → Padat
Kategori performa akademik:
≥ 3.50 → Sangat Baik
≥ 3.00 → Baik
≥ 2.50 → Cukup
< 2.50 → Perlu Pembinaan
3. bagian_c (Kelayakan KRS)

Menggabungkan:

Identitas mahasiswa
Validasi data akademik
Penentuan kelayakan KRS

Output:

Kelayakan (Layak / Tidak Layak)
Alasan
Ringkasan hasil analisis
4. bagian_d (Perbandingan Mahasiswa)

Membandingkan dua mahasiswa berdasarkan:

IPK (prioritas utama)
SKS (jika IPK sama)

Output:

Tabel perbandingan
Kesimpulan otomatis
Skenario Pengujian
Skenario 1 - Data Valid
UKT: Lunas
Semester: Valid (>0)
SKS: Valid (>0)

Hasil:

Data valid
Layak mengambil KRS
Performa akademik tinggi
Skenario 2 - Tidak Valid (UKT Belum Lunas)
UKT: Belum lunas

Hasil:

Status data: Tidak Valid
Tidak layak KRS
Analisis akademik tetap berjalan
Skenario 3 - Tidak Valid (Data Tidak Logis)
SKS = 0
Semester = 0

Hasil:

Data tidak valid
Sistem mendeteksi kesalahan input
Tidak layak KRS
Konsep yang Digunakan
Stored Procedure MySQL
Blok prosedural (BEGIN...END)
Variabel (DECLARE, SET)
Percabangan (IF-ELSEIF-ELSE)
Fungsi:
CONCAT() → menggabungkan string
UPPER() → normalisasi input
Operator logika (AND, BETWEEN)
Cara Menjalankan Program
Jalankan seluruh script SQL di MySQL (MySQL Workbench / phpMyAdmin).
Pastikan setiap procedure berhasil dibuat.
Jalankan perintah CALL sesuai skenario:

Contoh:

CALL bagian_a('Sitti Rahma', 'IK2411048', 4, 'Informatika');
CALL bagian_b(21, 4.00, 'LUNAS', 4);
CALL bagian_c('Sitti Rahma', 'IK2411048', 4, 'Informatika', 21, 4.00, 'LUNAS');
Kesimpulan Singkat

Program ini menunjukkan bahwa penggunaan blok prosedural dalam MySQL dapat membantu membangun sistem yang:

Terstruktur
Mudah digunakan kembali
Mampu melakukan analisis dan pengambilan keputusan

Semakin kompleks prosedur yang dibuat, semakin tinggi kemampuan sistem dalam mengolah dan mengevaluasi data.

Kalau kamu mau, aku bisa bantu juga:
