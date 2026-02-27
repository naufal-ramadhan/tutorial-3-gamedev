# Tutorial 3 Game-dev
Nama = Muhammad Naufal Ramadhan

NPM = 2306241700

# Latihan Mandiri: Eksplorasi Mekanika Pergerakan Platformer 2D

## Fitur yang Diimplementasikan

* **Double Jump:** Karakter dapat melompat maksimal dua kali sebelum harus menyentuh tanah kembali.
* **Crouching:** Karakter dapat menunduk saat berada di tanah, yang akan mengubah status animasi.
* **Dashing (Double Tap):** Karakter akan melesat cepat ke arah horizontal apabila pemain menekan tombol panah arahmsebanyak dua kali secara beruntun dalam jeda waktu yang singkat.

---

## Proses Implementasi

### 1. Double Jump
Implementasi double jump dengan memodifikasi logika lompat dasar dengan menambahkan variabel `jump_count` dan batas maksimal `max_jumps` (yang diatur ke 2). 
Setiap kali input lompat (`ui_up`) ditekan, sistem akan mengecek apakah karakter berada di lantai, dan mengecek apakah `jump_count < max_jumps`. Jika syarat terpenuhi, `velocity.y` diberikan nilai negatif (`jump_speed`) sehingga bergerak ke atas. Variabel `jump_count` secara otomatis di-reset menjadi 0 ketika sistem mendeteksi karakter menyentuh lantai dengan `is_on_floor()`.

### 2. Crouching
Mekanika jongkok bergantung pada pengecekan input `ui_down` yang digabungkan dengan pengecekan `is_on_floor()`. 
Ketika pemain menahan tombol bawah, variabel *boolean* `is_crouching` diubah menjadi `true`.

### 3. Dashing dengan Mekanika Double Tap
Implementasi *dash* dilakukan dengan mendeteksi penekanan tombol arah dua kali secara cepat.
*   **Deteksi Double Tap:** Saat tombol arah ditekan, sebuah timer singkat dimulai. Jika tombol yang sama ditekan lagi sebelum timer habis, maka *dash* akan terpicu.
*   **Eksekusi Dash:** Karakter akan melesat cepat ke arah yang dituju selama durasi singkat. Selama *dash*, pergerakan normal dan gravitasi untuk sementara diabaikan. Setelah durasi selesai, kontrol karakter kembali seperti semula.

---

## Referensi

* **[2D sprite animation:](https://docs.godotengine.org/en/stable/tutorials/2d/2d_sprite_animation.html)**