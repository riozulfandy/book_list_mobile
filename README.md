# Book List

Halo, namaku Rio dan ini Repository untuk tugas Flutter individu pada matkul PBP.

# Tugas PBP Flutter
Berikut adalah detail pengembangan pada setiap tugas.

<details>
    <summary>
        Tugas 8
    </summary>

## Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement(), disertai dengan contoh mengenai penggunaan kedua metode tersebut yang tepat!

1. **Navigator.push()**: Metode ini digunakan untuk menavigasi ke halaman baru sambil mempertahankan halaman sebelumnya dalam stack navigasi. Jadi, ketika pengguna menekan tombol kembali, mereka akan kembali ke halaman sebelumnya. Contoh penggunaannya:

```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => SecondPage()),
);
```

2. **Navigator.pushReplacement()**: Metode ini digunakan untuk menavigasi ke halaman baru dan menghapus halaman sebelumnya dari stack navigasi. Jadi, ketika pengguna menekan tombol kembali, mereka tidak akan kembali ke halaman sebelumnya. Metode ini biasanya digunakan untuk navigasi ke halaman "Home" atau "Login" setelah proses seperti "Sign Out". Contoh penggunaannya:

```dart
Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => HomePage()),
);
```
## Jelaskan masing-masing layout widget pada Flutter dan konteks penggunaannya masing-masing!

1. **Container**: Widget ini memungkinkan membuat elemen desain yang dapat disesuaikan, seperti padding, margin, dan background color. Biasanya digunakan ketika ingin mengubah beberapa aspek visual dari widget anak.

```dart
Container(
  margin: const EdgeInsets.all(15.0),
  padding: const EdgeInsets.all(3.0),
  decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
  child: Text('Hello World'),
)
```

2. **Row dan Column**: Widget ini memungkinkan untuk mengatur widget anak secara horizontal dan vertikal. `Row` digunakan untuk layout horizontal, sedangkan `Column` digunakan untuk layout vertikal.

```dart
Row(
  children: <Widget>[
    Icon(Icons.star, color: Colors.yellow[500]),
    Icon(Icons.star, color: Colors.yellow[500]),
    Icon(Icons.star, color: Colors.grey),
  ],
)
```

3. **Stack**: Widget ini memungkinkan untuk menumpuk sejumlah widget di atas satu sama lain. Biasanya digunakan ketika ingin menempatkan beberapa widget yang satu di atas yang lain.

```dart
Stack(
  alignment: const Alignment(0.6, 0.6),
  children: [
    CircleAvatar(
      backgroundImage: AssetImage('images/pic.jpg'),
      radius: 100,
    ),
    Container(
      decoration: BoxDecoration(
        color: Colors.black45,
      ),
      child: Text(
        'Mia B',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
  ],
)
```

4. **GridView**: Widget ini memungkinkan untuk mengatur widget anak dalam grid dua dimensi. Biasanya digunakan ketika ingin menampilkan koleksi item dalam bentuk grid.

```dart
GridView.count(
  crossAxisCount: 2,
  children: List.generate(100, (index) {
    return Center(
      child: Text(
        'Item $index',
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }),
)
```

5. **ListView**: Widget ini memungkinkan untuk mengatur widget anak dalam daftar yang dapat digulir. Biasanya digunakan ketika memiliki sejumlah widget yang lebih banyak dari yang dapat ditampilkan pada layar sekaligus.

```dart
ListView(
  children: <Widget>[
    ListTile(
      leading: Icon(Icons.map),
      title: Text('Map'),
    ),
    ListTile(
      leading: Icon(Icons.photo_album),
      title: Text('Album'),
    ),
    ListTile(
      leading: Icon(Icons.phone),
      title: Text('Phone'),
    ),
  ],
)
```

## Sebutkan apa saja elemen input pada form yang kamu pakai pada tugas kali ini dan jelaskan mengapa kamu menggunakan elemen input tersebut!

- `Form` => untuk membuat dan mengelola formulir juga untuk validasi input dan menyimpan input pengguna apabila sudah sesuai.
- `SingleChildScrollView` => untuk page dapat discroll apabila konten lebih besar dari ukuran screen.
- `Column` => untuk mengatur widget childnya dalam kolom vertikal.
- `Padding` => untuk mengatur jarak (padding) di sekitar widget childnya.
- `TextFormField` => untuk tempat pengguna memberikan input, kemudian akan diproses oleh program untuk validasi input dan menyimpannya.
- `Text` => untuk menampilkan teks pada page.
- `TextStyle` => untuk kustomisasi teks pada page (color, size, etc.) juga untuk mengubah warna text pada `TextFormField`.
- `InputDecoration` => untuk mengatur dekorasi elemen input seperti label, icon, dan text style.
- `OutlineInputBorder` => untuk memberikan outline pada `TextFormField`.
- `Align` => untuk mengatur posisi (alignment) widget childrennya.
- `ElevatedButton` => untuk efek peninggian dan memberikan respon ketika diklik.
- `ButtonStyle` => untuk menentukan style button.
- `TextButton` => untuk menampilkan button `OK`.

## Bagaimana penerapan clean architecture pada aplikasi Flutter?

Clean Architecture pada aplikasi Flutter dapat diterapkan dengan membagi kode menjadi beberapa lapisan yang saling terpisah. Lapisan-lapisan tersebut meliputi entitas bisnis (domain), use cases, lapisan interface (interface adaptors) yang berkomunikasi dengan luar, dan lapisan framework yang mengatur detail implementasi seperti UI dan database. Dengan memisahkan secara jelas antara ketiga lapisan ini, Clean Architecture memungkinkan pengembang untuk menciptakan kode yang bersih, terpisah, dan mudah diuji. Penggunaan fitur-fitur Flutter seperti Provider atau Riverpod dapat membantu dalam menyusun lapisan-lapisan tersebut, memastikan bahwa logika bisnis tidak terikat erat dengan implementasi UI atau teknologi tertentu, dan mempermudah pemeliharaan serta pengembangan fitur baru pada aplikasi.

## Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step! (bukan hanya sekadar mengikuti tutorial)

1. **Membuat Halaman Form dan Membuat List yang berisi Item yang diinput pada Form**

```dart
import 'package:flutter/material.dart';
// TODO: Impor drawer yang sudah dibuat sebelumnya
import 'package:book_list/widgets/left_drawer.dart';
import 'package:book_list/widgets/book_card.dart';

class BookFormPage extends StatefulWidget {
  const BookFormPage({super.key});

  @override
  State<BookFormPage> createState() => _BookFormPageState();
}

List<Item> items = [];

class _BookFormPageState extends State<BookFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  int _amount = 0;
  String _description = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Form Tambah Buku',
          ),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      // TODO: Tambahkan drawer yang sudah dibuat di sini
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Nama Buku",
                labelText: "Nama Buku",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              onChanged: (String? value) {
                setState(() {
                  _name = value!;
                });
              },
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Nama tidak boleh kosong!";
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Jumlah",
                labelText: "Jumlah",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              // TODO: Tambahkan variabel yang sesuai
              onChanged: (String? value) {
                setState(() {
                  _amount = int.parse(value!);
                });
              },
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Jumlah tidak boleh kosong!";
                }
                if (int.tryParse(value) == null) {
                  return "Jumlah harus berupa angka!";
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Deskripsi",
                labelText: "Deskripsi",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              onChanged: (String? value) {
                setState(() {
                  // TODO: Tambahkan variabel yang sesuai
                  _description = value!;
                });
              },
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Deskripsi tidak boleh kosong!";
                }
                return null;
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.indigo),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    items.add(Item(
                      name: _name,
                      amount: _amount,
                      description: _description,
                    ));
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Buku berhasil tersimpan'),
                          content: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Nama Buku: $_name'),
                                // TODO: Munculkan value-value lainnya
                                Text('Jumlah: $_amount'),
                                Text('Deskripsi: $_description'),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                    _formKey.currentState!.reset();
                  }
                },
                child: const Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ])),
      ),
    );
  }
}
```

2. **Membuat halaman daftar Item yang sudah diinput**

```dart
import 'package:flutter/material.dart';
import 'package:book_list/widgets/left_drawer.dart';
import 'package:book_list/screens/booklist_form.dart';

class ItemsPage extends StatefulWidget {
  const ItemsPage({super.key});

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Item List'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      drawer: LeftDrawer(),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index].name),
            subtitle: Text(
                'Amount: ${items[index].amount}\nDescription: ${items[index].description}'),
            // Add an onTap handler if you want to do something when the user taps a product
            onTap: () {},
          );
        },
      ),
    );
  }
}
```

3. **Menambahkan Routing ke Halaman Tersebut dari Tombol Card Halaman Utama**

```dart
if (item.name == "Tambah Buku") {
  // TODO: Gunakan Navigator.push untuk melakukan navigasi ke MaterialPageRoute yang mencakup ShopFormPage.
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => const BookFormPage()));
} else if (item.name == "Lihat Buku") {
  // TODO: Gunakan Navigator.push untuk melakukan navigasi ke MaterialPageRoute yang mencakup ShopFormPage.
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => const ItemsPage()));
}
```

4. **Membuat drawer**

```dart
import 'package:flutter/material.dart';
import 'package:book_list/screens/menu.dart';
// TODO: Impor halaman BookFormPage jika sudah dibuat
import 'package:book_list/screens/booklist_form.dart';
import 'package:book_list/screens/booklist_items.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            // TODO: Bagian drawer header
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              children: [
                Text(
                  'Book List',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text("Catat seluruh buku mu di sini!",
                    // TODO: Tambahkan gaya teks dengan center alignment, font ukuran 15, warna putih, dan weight biasa
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    )),
              ],
            ),
          ),
          // TODO: Bagian routing
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Halaman Utama'),
            // Bagian redirection ke MyHomePage
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Tambah Buku'),
            // Bagian redirection ke BookFormPage
            onTap: () {
              /*
              TODO: Buatlah routing ke BookFormPage di sini,
              setelah halaman BookFormPage sudah dibuat.
              */
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BookFormPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.checklist),
            title: const Text('Lihat Buku'),
            // Bagian redirection ke BookFormPage
            onTap: () {
              /*
              TODO: Buatlah routing ke BookFormPage di sini,
              setelah halaman BookFormPage sudah dibuat.
              */
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ItemsPage()));
            },
          )
        ],
      ),
    );
  }
}
```

6. **Menambahkan drawer pada setiap page**

```dart
drawer: const LeftDrawer(),
```

<details>

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

- BookCard: Ini adalah widget kustom yang buat untuk menampilkan item toko.

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
- Menambahkan kelas baru bernama ```BookItem``` untuk ketiga item yang akan ditampilkan sebagai button.
```dart
class BookItem {
  final String name;
  final IconData icon;
  final Color color;

  BookItem(this.name, this.icon, this.color);
}
```
- Membuat list ```items``` yang berisi objek-objek dari kelas ```BookItem```.
```dart
final List<BookItem> items = [
    BookItem("Lihat Item", Icons.checklist, Colors.blue),
    BookItem("Tambah Item", Icons.add, Colors.green),
    BookItem("Logout", Icons.logout, Colors.red),
];
```
- Membuat class ```BookCard``` untuk menampilkan item-item ```BookItem``` tersebut sebagai card. Card tersebut memiliki warna yang sesuai dengan atribut ```color``` masing-masing item (implementasi bonus).
```dart
class BookCard extends StatelessWidget {
  final BookItem item;

  const BookCard(this.item, {super.key}); // Constructor

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
- Membuat container card pada ```build``` widget ```MyHomePage``` dan melakukan iterasi pada list ```items``` yang berisi objek ```BookItem``` untuk ditampilkan sebagai card dengan menggunakan class ```BookCard``` yang telah didefinisikan sebelumnya.
```dart
GridView.count(
    // Container pada card kita.
    primary: true,
    padding: const EdgeInsets.all(20),
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
    crossAxisCount: 3,
    shrinkWrap: true,
    children: items.map((BookItem item) {
        // Iterasi untuk setiap item
        return BookCard(item);
    }).toList(),
)
```
### 3. Memunculkan Snackbar dengan tulisan: "Kamu telah menekan tombol Lihat Item" ketika tombol Lihat Item ditekan, "Kamu telah menekan tombol Tambah Item" ketika tombol Tambah Item ditekan, "Kamu telah menekan tombol Logout" ketika tombol Logout ditekan.

Pada ```build``` widget ```BookCard``` mendefinisikan card tersebut sebagai area responsif terhadap sentuhan. Dan mendefinisikan action onTap saat card diklik dengan memunculkan Snackbar.
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