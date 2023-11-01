# Book List

Halo, namaku Rio dan ini Repository untuk tugas Flutter individu pada matkul PBP.

# Tugas PBP Flutter
Berikut adalah detail pengembangan pada setiap tugas.

<details>
    <summary>
        Tugas 7
    </summary>

## Apa perbedaan utama antara stateless dan stateful widget dalam konteks pengembangan aplikasi Flutter?

= Dalam pengembangan aplikasi Flutter, perbedaan utama antara Stateless dan Stateful widget adalah:

Stateless Widget: Widget ini digunakan ketika bagian UI (User Interface) yang kita buat tidak memerlukan perubahan state atau kondisi. Dengan kata lain, Stateless widget tidak dapat berubah setelah di-render pertama kali. Contoh dari Stateless widget adalah Text, Icon, dan RaisedButton.

Stateful Widget: Widget ini digunakan ketika bagian UI yang kita buat memerlukan perubahan state atau kondisi. Stateful widget dapat berubah sepanjang lifecycle-nya. Contoh dari Stateful widget adalah Checkbox, Radio Button, Slider, InkWell, Form, dan TextField.

## Sebutkan seluruh widget yang kamu gunakan untuk menyelesaikan tugas ini dan jelaskan fungsinya masing-masing.

- MyApp: Ini adalah widget utama yang merupakan StatelessWidget. Widget ini mendefinisikan tampilan utama aplikasi.

- MaterialApp: Widget ini biasanya digunakan sebagai root dari aplikasi Flutter dan menyediakan berbagai fungsi seperti navigasi, tema, dan judul aplikasi.

- ThemeData: Widget ini digunakan untuk mendefinisikan tema global untuk aplikasi. Dalam kasus ini, menggunakan ColorScheme.fromSeed(seedColor: Colors.indigo) untuk menghasilkan skema warna dari warna benih, dan useMaterial3: true untuk menggunakan sistem desain Material 3.

- MyHomePage: Ini adalah widget yang ditampilkan ketika aplikasi dimulai. Widget ini menyediakan kerangka dasar Material Design untuk layout aplikasi. Ini mencakup AppBar dan Body.

- Scaffold: Widget ini menyediakan kerangka dasar Material Design untuk layout aplikasi. Ini mencakup AppBar dan Body.

- AppBar: Widget ini menampilkan bar aplikasi di bagian atas Scaffold.

- Text: Widget ini digunakan untuk menampilkan teks.

- SingleChildScrollView: Widget ini memungkinkan kontennya dapat digulir jika konten tersebut melebihi ruang yang tersedia.

- Padding: Widget ini digunakan untuk memberikan padding ke widget anaknya.

- Column: Widget ini digunakan untuk menampilkan daftar widget anaknya dalam tata letak vertikal.

- GridView.count: Widget ini digunakan untuk menampilkan grid item.

- ShopCard: Ini adalah widget kustom yang buat untuk menampilkan item toko.

- Material: Widget ini memberikan efek visual Material Design ke widget anaknya.

- InkWell: Widget ini membuat area pada layar yang dapat merespons sentuhan pengguna.

- Container: Widget ini memungkinkan untuk menyesuaikan detail visual anaknya.

- Icon: Widget ini digunakan untuk menampilkan ikon.

## Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step (bukan hanya sekadar mengikuti tutorial)

### 1. Membuat sebuah program Flutter baru dengan tema inventory seperti tugas-tugas sebelumnya.

Generate proyek Flutter baru dengan nama book_list. Book list merupakan aplikasi inventori buku.
```
flutter create <APP_NAME>
cd <APP_NAME>
```

### 2. Membuat tiga tombol sederhana dengan ikon dan teks untuk: Melihat daftar item (Lihat Item), Menambah item (Tambah Item), Logout (Logout). Serta implementasi bonus dengan membedakan warna tiga tombol tersebut.

- Membuat file baru pada ```lib``` dengan nama ```menu.dart```
- Menambahkan kelas baru bernama ```ShopItem``` untuk ketiga item yang akan ditampilkan sebagai button.
```dart
class ShopItem {
  final String name;
  final IconData icon;
  final Color color;

  ShopItem(this.name, this.icon, this.color);
}
```
- Membuat list ```items``` yang berisi objek-objek dari kelas ```ShopItem```.
```dart
final List<ShopItem> items = [
    ShopItem("Lihat Item", Icons.checklist, Colors.blue),
    ShopItem("Tambah Item", Icons.add, Colors.green),
    ShopItem("Logout", Icons.logout, Colors.red),
];
```
- Membuat class ```ShopCard``` untuk menampilkan item-item ```ShopItem``` tersebut sebagai card. Card tersebut memiliki warna yang sesuai dengan atribut ```color``` masing-masing item (implementasi bonus).
```dart
class ShopCard extends StatelessWidget {
  final ShopItem item;

  const ShopCard(this.item, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      child: InkWell(
        // Area responsive terhadap sentuhan
        onTap: () {
          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!")));
        },
        child: Container(
          // Container untuk menyimpan Icon dan Text
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```
- Membuat container card pada ```build``` widget ```MyHomePage``` dan melakukan iterasi pada list ```items``` yang berisi objek ```ShopItem``` untuk ditampilkan sebagai card dengan menggunakan class ```ShopCard``` yang telah didefinisikan sebelumnya.
```dart
GridView.count(
    // Container pada card kita.
    primary: true,
    padding: const EdgeInsets.all(20),
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
    crossAxisCount: 3,
    shrinkWrap: true,
    children: items.map((ShopItem item) {
        // Iterasi untuk setiap item
        return ShopCard(item);
    }).toList(),
)
```
### 3. Memunculkan Snackbar dengan tulisan: "Kamu telah menekan tombol Lihat Item" ketika tombol Lihat Item ditekan, "Kamu telah menekan tombol Tambah Item" ketika tombol Tambah Item ditekan, "Kamu telah menekan tombol Logout" ketika tombol Logout ditekan.

Pada ```build``` widget ```ShopCard``` mendefinisikan card tersebut sebagai area responsif terhadap sentuhan. Dan mendefinisikan action onTap saat card diklik dengan memunculkan Snackbar.
```dart
Widget build(BuildContext context) {
    return Material(
        color: item.color,
        child: InkWell(
        // Area responsive terhadap sentuhan
            onTap: () {
                // Memunculkan SnackBar ketika diklik
                ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
                    content: Text("Kamu telah menekan tombol ${item.name}!")));
            },
            ...
        )
    )
}
```

</details>