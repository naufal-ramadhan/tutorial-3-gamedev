# Tutorial 3 & 5 Game-dev
Nama = Muhammad Naufal Ramadhan

NPM = 2306241700

# Latihan Mandiri: Eksplorasi Mekanika Pergerakan Platformer 2D (Tutorial 3)

## Fitur yang Diimplementasikan

* **Double Jump:** Karakter dapat melompat maksimal dua kali sebelum harus menyentuh tanah kembali.
* **Crouching:** Karakter dapat menunduk saat berada di tanah, yang akan mengubah status animasi.
* **Dashing (Double Tap):** Karakter akan melesat cepat ke arah horizontal apabila pemain menekan tombol panah arahmsebanyak dua kali secara beruntun dalam jeda waktu yang singkat.

---

## Proses Implementasi Tutorial 3

### 1. Double Jump
Implementasi double jump dengan memodifikasi logika lompat dasar dengan menambahkan variabel `jump_count` dan batas maksimal `max_jumps` (yang diatur ke 2). 
Setiap kali input lompat (`ui_up`) ditekan, sistem akan mengecek apakah karakter berada di lantai, dan mengecek apakah `jump_count < max_jumps`. Jika syarat terpenuhi, `velocity.y` diberikan nilai negatif (`jump_speed`) sehingga bergerak ke atas. Variabel `jump_count` secara otomatis di-reset menjadi 0 ketika sistem mendeteksi karakter menyentuh lantai dengan `is_on_floor()`.

### 2. Crouching
Mekanika jongkok bergantung pada pengecekan input `ui_down` yang digabungkan dengan pengecekan `is_on_floor()`. 
Ketika pemain menahan tombol bawah, variabel *boolean* `is_crouching` diubah menjadi `true`.

### 3. Dashing dengan Mekanika Double Tap
Implementasi *dash* dilakukan dengan mendeteksi penekanan tombol arah dua kali secara cepat.
* **Deteksi Double Tap:** Saat tombol arah ditekan, sebuah timer singkat dimulai. Jika tombol yang sama ditekan lagi sebelum timer habis, maka *dash* akan terpicu.
* **Eksekusi Dash:** Karakter akan melesat cepat ke arah yang dituju selama durasi singkat. Selama *dash*, pergerakan normal dan gravitasi untuk sementara diabaikan. Setelah durasi selesai, kontrol karakter kembali seperti semula.

---

# Latihan Mandiri: Assets Creation & Integration (Tutorial 5)

## Fitur yang Diimplementasikan
* **Objek Interaktif (Koin):** Penambahan objek *collectible* berupa koin yang memiliki animasi berputar menggunakan *spritesheet*.
* **Background Music (BGM):** Implementasi musik latar yang otomatis diputar berulang (*looping*) saat permainan berjalan.
* **Audio Feedback (SFX):** Implementasi efek suara spesifik yang terpicu ketika pemain berinteraksi (mengambil) koin.

---

## Proses Implementasi Tutorial 5

### 1. Pembuatan Objek Interaktif (Koin)
Objek koin dibuat dalam *scene* terpisah dengan `Area2D` sebagai *root node*, yang dilengkapi dengan `AnimatedSprite2D` dan `CollisionShape2D`. 
Animasi koin dibuat dengan mengimpor *spritesheet* dan memotongnya sesuai *grid*. Agar animasi langsung berputar ketika *scene* dimuat, pemanggilan metode `play()` ditambahkan ke dalam fungsi `_ready()` pada *script* koin tersebut. Koin ini kemudian di-*instance* beberapa kali ke dalam *main scene*.

### 2. Penambahan BGM (Background Music)
Musik latar ditambahkan ke dalam *main scene* menggunakan *node* `AudioStreamPlayer`. Berkas audio `FunkyBgm.wav` dimasukkan ke dalam properti *stream*. Agar musik terus berulang, pengaturan *Loop Mode* pada tab *Import* diubah menjadi *Forward* lalu di-*reimport*. Properti `Autoplay` juga diaktifkan agar musik langsung berbunyi saat permainan dimulai.

### 3. Implementasi Audio Feedback dan Interaksi Koin
Efek suara saat mengambil koin (*coin pickup*) menggunakan file format `.wav` yang dimasukkan ke dalam *node* `AudioStreamPlayer` di dalam *scene* Koin. 
Interaksi diimplementasikan dengan menghubungkan *signal* `body_entered` dari `Area2D` ke *script* koin. Logikanya adalah sebagai berikut:
* Sistem memverifikasi apakah objek yang menabrak *Area2D* adalah karakter pemain.
* Jika benar, `AudioStreamPlayer` akan memutar efek suara.
* Wujud koin disembunyikan dengan mengubah `visible = false` dan *collision* dimatikan secara *deferred* agar tidak terpicu dua kali.
* Menggunakan instruksi `await`, sistem menunggu hingga efek suara selesai diputar secara utuh sebelum akhirnya memanggil `queue_free()` untuk menghapus objek koin dari memori.

---

## Referensi

* **[2D sprite animation (Godot Docs):](https://docs.godotengine.org/en/stable/tutorials/2d/2d_sprite_animation.html)** Panduan animasi dasar karakter dan objek.
* **[Freesound:](https://freesound.org/)** Sumber aset audio.
* **[TotusLotus:](https://itch.io/game-assets/free/tag-coin)** Sumber aset gambar koin.