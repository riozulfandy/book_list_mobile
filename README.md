# Book List

Halo, namaku Rio dan ini Repository untuk tugas Flutter individu pada matkul PBP.

# Tugas PBP Flutter
Berikut adalah detail pengembangan pada setiap tugas.

<details>
    <summary>
        Tugas 9
    </summary>

## Apakah bisa kita melakukan pengambilan data JSON tanpa membuat model terlebih dahulu? Jika iya, apakah hal tersebut lebih baik daripada membuat model sebelum melakukan pengambilan data JSON?

Ya, kita bisa melakukan pengambilan data JSON tanpa membuat model terlebih dahulu di Flutter. Kita bisa menggunakan `dart:convert` untuk mengubah JSON menjadi Map. Contohnya:

```dart
import 'dart:convert';

void main() {
  String jsonString = '{"name":"John", "age":30, "city":"New York"}';
  Map<String, dynamic> user = jsonDecode(jsonString);
  print('Name: ${user['name']}, Age: ${user['age']}, City: ${user['city']}');
}
```

Namun, pendekatan ini biasanya kurang disukai dibandingkan dengan membuat model terlebih dahulu. Membuat model memberikan beberapa keuntungan seperti:

1. **Type Safety**: Dengan model, kita mendapatkan keuntungan dari sistem tipe Dart, yang dapat membantu mencegah bug.
2. **Autocomplete dan Tooling**: Dengan model, IDE kita dapat memberikan autocomplete dan tooling lainnya, yang membuat lebih mudah untuk bekerja dengan data.
3. **Readability dan Maintenance**: Model membuat kode kita lebih mudah dibaca dan dipelihara.

Jadi, meskipun mungkin untuk bekerja dengan JSON tanpa model, biasanya lebih baik untuk membuat model terlebih dahulu.

## Jelaskan fungsi dari CookieRequest dan jelaskan mengapa instance CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter!

Manajemen cookie umumnya digunakan untuk menyimpan informasi di sisi klien (di perangkat pengguna) dan seringkali digunakan dalam konteks otentikasi atau penyimpanan sesi. Kelas seperti "CookieRequest" bertanggung jawab untuk membuat, mengelola, atau memodifikasi cookie yang terkait dengan permintaan HTTP.

Mengapa instance "CookieRequest" perlu dibagikan ke semua komponen di aplikasi Flutter, ini dapat disebabkan oleh beberapa alasan:

- Konsistensi Data: Dengan menggunakan instance yang dibagikan, kita dapat memastikan bahwa data cookie yang digunakan di seluruh aplikasi konsisten dan dapat diakses dengan mudah oleh setiap komponen.

- Pemeliharaan State Aplikasi: Jika data cookie memegang informasi otentikasi atau status sesi, memiliki instance yang dibagikan memungkinkan setiap komponen untuk merespons dengan benar terhadap perubahan status tanpa perlu berkomunikasi langsung antar komponen.

- Efisiensi dan Kinerja: Dengan menggunakan instance yang dibagikan, kita dapat menghindari membuat instansi baru setiap kali komponen membutuhkan akses ke data cookie. Ini dapat meningkatkan efisiensi dan kinerja aplikasi.

## Jelaskan mekanisme pengambilan data dari JSON hingga dapat ditampilkan pada Flutter!

Mekanisme pengambilan data dari JSON hingga dapat ditampilkan pada Flutter melibatkan beberapa langkah:

1. **Membuat Permintaan HTTP**: Pertama, kita perlu membuat permintaan HTTP ke endpoint yang mengembalikan data JSON. Kita bisa menggunakan package seperti `http` untuk melakukan ini.

```dart
import 'package:http/http.dart' as http;

final response = await http.get('https://api.example.com/data');
```

2. **Decoding JSON**: Setelah kita menerima respons, kita perlu decode JSON menjadi struktur data Dart. Kita bisa menggunakan `dart:convert` untuk melakukan ini.

```dart
import 'dart:convert';

final data = jsonDecode(response.body);
```

3. **Membuat Model**: Meskipun ini opsional, biasanya lebih baik untuk mengubah data yang telah di-decode menjadi model yang lebih mudah digunakan. Kita bisa membuat class untuk model dan menggunakan factory constructor untuk membuat instance dari data JSON.

```dart
class Data {
  final String name;
  // other fields...

  Data({required this.name /*, other fields...*/});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      name: json['name'],
      // other fields...
    );
  }
}

final dataModel = Data.fromJson(data);
```

4. **Menampilkan Data**: Akhirnya, kita bisa menampilkan data di UI Flutter kita. Kita bisa menggunakan `setState` untuk memperbarui state widget dan memicu rebuild.

```dart
setState(() {
  _data = dataModel;
});
```

Dan di dalam method `build` kita, Kita bisa merujuk ke `_data` untuk menampilkan data.

```dart
Text('Name: ${_data.name}')
```

## Jelaskan mekanisme autentikasi dari input data akun pada Flutter ke Django hingga selesainya proses autentikasi oleh Django dan tampilnya menu pada Flutter!

Mekanisme autentikasi dari input data akun pada Flutter ke Django hingga selesainya proses autentikasi oleh Django dan tampilnya menu pada Flutter melibatkan beberapa langkah:

1. **Input Data Akun**: Pengguna memasukkan data akun (biasanya username dan password) melalui form di aplikasi Flutter.

```dart
final _usernameController = TextEditingController();
final _passwordController = TextEditingController();
// dalam widget form
TextField(controller: _usernameController);
TextField(controller: _passwordController, obscureText: true);
```

2. **Kirim Data ke Server**: Aplikasi Flutter mengirim data akun ke server Django melalui permintaan HTTP POST. Ini biasanya dilakukan dengan package `http`.

```dart
final response = await http.post(
  'https://your-django-server.com/auth/login',
  body: {
    'username': _usernameController.text,
    'password': _passwordController.text,
  },
);
```

3. **Proses Autentikasi Django**: Server Django menerima data akun, memverifikasi data tersebut, dan jika valid, mengembalikan token autentikasi.

4. **Simpan Token**: Aplikasi Flutter menerima token dari server dan menyimpannya untuk digunakan dalam permintaan berikutnya.

```dart
final responseData = jsonDecode(response.body);
final token = responseData['token'];
// simpan token untuk digunakan nanti
```

5. **Tampilkan Menu**: Setelah autentikasi berhasil, aplikasi Flutter menampilkan menu atau halaman berikutnya.

```dart
if (response.statusCode == 200) {
  Navigator.pushReplacementNamed(context, '/menu');
}
```

## Sebutkan seluruh widget yang kamu pakai pada tugas ini dan jelaskan fungsinya masing-masing!

Dalam tugas ini, berikut adalah widget baru yang digunakan dan fungsinya:

1. **TextEditingController**: Widget ini digunakan untuk mengontrol teks yang ditampilkan dalam widget TextField atau TextFormField. Dalam konteks ini, digunakan untuk mengambil input username dan password dari pengguna.

2. **TextField**: Widget ini digunakan untuk menerima input teks dari pengguna. Dalam tugas ini, digunakan untuk memasukkan username dan password.

3. **Navigator**: Widget ini digunakan untuk mengelola stack route dalam aplikasi Flutter. Dalam tugas ini, digunakan untuk berpindah ke halaman menu setelah autentikasi berhasil.

## Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step! (bukan hanya sekadar mengikuti tutorial)!

1. **Memastikan deployment proyek tugas Django kamu telah berjalan dengan baik.**

- Membuat django-app baru bernama ```authentication```, menambahkan ```django-cors-headers``` pada ```requirements.txt```, menambahkan ```authentication``` dan ```corsheaders``` pada INSTALLED_APPS ```settings.py``` project, menambahkan ```corsheaders.middleware.CorsMiddleware``` pada Middleware ```settings.py``` project, dan menambahkan beberapa konstanta berikut pada ```settings.py```.

```python
CORS_ALLOW_ALL_ORIGINS = True
CORS_ALLOW_CREDENTIALS = True
CSRF_COOKIE_SECURE = True
SESSION_COOKIE_SECURE = True
CSRF_COOKIE_SAMESITE = 'None'
SESSION_COOKIE_SAMESITE = 'None'
```

- Menambahkan beberapa fungsi pada ```views.py``` aplikasi ```authentication``` untuk login, logout, menambahkan user (register), dan menambahkan item.

```python
import json
from django.contrib.auth import authenticate, login as auth_login
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth import logout as auth_logout
from django.contrib.auth.models import User
from main.models import Item

@csrf_exempt
def login(request):
    username = request.POST.get('username')
    password = request.POST.get('password')
    user = authenticate(username=username, password=password)
    if user is not None:
        if user.is_active:
            auth_login(request, user)
            # Status login sukses.
            return JsonResponse({
                "username": user.username,
                "id": user.id,
                "status": True,
                "message": "Login sukses!"
                # Tambahkan data lainnya jika ingin mengirim data ke Flutter.
            }, status=200)
        else:
            return JsonResponse({
                "status": False,
                "message": "Login gagal, akun dinonaktifkan."
            }, status=401)

    else:
        return JsonResponse({
            "status": False,
            "message": "Login gagal, periksa kembali username atau kata sandi."
        }, status=401)
    
@csrf_exempt
def logout(request):
    username = request.user.username

    try:
        auth_logout(request)
        return JsonResponse({
            "username": username,
            "status": True,
            "message": "Logout berhasil!"
        }, status=200)
    except:
        return JsonResponse({
        "status": False,
        "message": "Logout gagal."
        }, status=401)

@csrf_exempt
def create_product_flutter(request):
    if request.method == 'POST':
        data = json.loads(request.body)
        new_product = Item.objects.create(
            user_id = int(data["user"]),
            name = data["name"],
            amount = int(data["amount"]),
            description = data["description"]
        )

        new_product.save()

        return JsonResponse({"status": "success", "messages":"Berhasil menambahkan item!"}, status=200)
    else:
        return JsonResponse({"status": "error", "messages":"Gagal menambahkan item!"}, status=401)
    
@csrf_exempt
def create_user_flutter(request):
    if request.method == 'POST':
        data = json.loads(request.body)
        if User.objects.filter(username=data["username"]).exists():
            return JsonResponse({"status": "error", "messages":"Username telah digunakan!"}, status=401)
        elif len(data["password"]) < 8:
            return JsonResponse({"status": "error", "messages":"Password minimal 8 karakter!"}, status=401)
        elif data["password"] != data["password2"]:
            return JsonResponse({"status": "error", "messages":"Password dan Konfirmasi Password tidak sama!"}, status=401)
        else :
            user = User.objects.create_user(username=data["username"], password=data["password"])
            user.save()
            return JsonResponse({"status": "success"}, status=200)
    else:
        return JsonResponse({"status": "error", "messages":"Terdapat kesalahan pengisian, silahkan coba lagi!"}, status=401)
```

- Menambahkan url fungsi-fungsi tersebut pada ```urls.py``` aplikasi ```authentication```

```python
from django.urls import path
from authentication.views import login, logout, create_user_flutter, create_product_flutter

app_name = 'authentication'

urlpatterns = [
    path('login/', login, name='login'),
    path('logout/', logout, name='logout'),
    path('create-flutter/', create_product_flutter, name='create_product_flutter'),
    path('create-user-flutter/', create_user_flutter, name='create_user_flutter'),
]
```

- Include urls aplikasi pada ```urls.py``` project.
```python
path('auth/', include('authentication.urls')),
```

- Push perubahan ke github sehingga akan terdeploy secara otomatis.

2. **Membuat halaman login pada proyek tugas Flutter.**

Membuat file baru ```login.dart``` pada ```lib/screens```.
```dart
import 'package:book_list/screens/menu.dart';
import 'package:book_list/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}

int user = 0;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Login',
          ),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 31, 141, 29)),
                ),
                onPressed: () async {
                  String username = _usernameController.text;
                  String password = _passwordController.text;

                  // Cek kredensial
                  // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                  // Untuk menyambungkan Android emulator dengan Django pada localhost,
                  // gunakan URL http://10.0.2.2/
                  final response = await request.login(
                      "http://muhammad-mariozulfandy-tugas.pbp.cs.ui.ac.id/auth/login/",
                      {
                        'username': username,
                        'password': password,
                      });

                  if (request.loggedIn) {
                    user = response['id'];
                    String message = response['message'];
                    String uname = response['username'];
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    );
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(SnackBar(
                          content: Text("$message Selamat datang, $uname.")));
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Login Gagal'),
                        content: Text(response['message']),
                        actions: [
                          TextButton(
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                )),
            const SizedBox(height: 12.0),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 14, 104, 179)),
              ),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterFormPage()),
                );
              },
              child: const Text(
                'Register',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

3. **Mengintegrasikan sistem autentikasi Django dengan proyek tugas Flutter.**

Pada poin 1, telah ditambahkan fungsi login dan logout pada ```views.py``` aplikasi ```authentication``` django. Dengan mengakses url dari fungsi tersebut, dapat dilakukan request dari flutter ke django. Pada ```login.dart``` terdapat:
```dart
final response = await request.login(
"http://muhammad-mariozulfandy-tugas.pbp.cs.ui.ac.id/auth/login/",
{
  'username': username,
  'password': password,
});
```
yang menerima response dari request pada django. Request mengirimkan username dan password yang diisi pada mobile app flutter. Django akan melakukan autentikasi dan mengirimkan status sukses/gagal dari request tersebut.
```py
@csrf_exempt
def login(request):
    username = request.POST.get('username')
    password = request.POST.get('password')
    user = authenticate(username=username, password=password)
    if user is not None:
        if user.is_active:
            auth_login(request, user)
            # Status login sukses.
            return JsonResponse({
                "username": user.username,
                "id": user.id,
                "status": True,
                "message": "Login sukses!"
                # Tambahkan data lainnya jika ingin mengirim data ke Flutter.
            }, status=200)
        else:
            return JsonResponse({
                "status": False,
                "message": "Login gagal, akun dinonaktifkan."
            }, status=401)

    else:
        return JsonResponse({
            "status": False,
            "message": "Login gagal, periksa kembali username atau kata sandi."
        }, status=401)
```
Untuk logout dilakukan hal yang sama, saat pengguna menekan tombol logout pada mobile app flutter. Request dikirimkan ke django dan menunggu respon status sukses/gagal.

flutter:
```dart
else if (item.name == "Logout") {
  final response = await request.logout(
      // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
      "http://muhammad-mariozulfandy-tugas.pbp.cs.ui.ac.id/auth/logout/");
  String message = response["message"];
  if (response['status']) {
    String uname = response["username"];
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("$message Sampai jumpa, $uname."),
    ));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("$message"),
    ));
  }
}
```

django:
```py
@csrf_exempt
def logout(request):
  username = request.user.username
  try:
      auth_logout(request)
      return JsonResponse({
          "username": username,
          "status": True,
          "message": "Logout berhasil!"
      }, status=200)
  except:
      return JsonResponse({
      "status": False,
      "message": "Logout gagal."
      }, status=401)
```

4. **Membuat model kustom sesuai dengan proyek aplikasi Django.**

Membuat directory baru ```lib/models``` dan menambahkan file baru ```item.dart```. Mengisi file tersebut sesuai dengan json database api website kita. Menggunakan https://app.quicktype.io/ sebagai bantuan untuk generate kode dartnya.
```dart
// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);

import 'dart:convert';

List<Item> itemFromJson(String str) =>
    List<Item>.from(json.decode(str).map((x) => Item.fromJson(x)));

String itemToJson(List<Item> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Item {
  String model;
  int pk;
  Fields fields;

  Item({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  int user;
  String name;
  DateTime dateAdded;
  int amount;
  String description;

  Fields({
    required this.user,
    required this.name,
    required this.dateAdded,
    required this.amount,
    required this.description,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        name: json["name"],
        dateAdded: DateTime.parse(json["date_added"]),
        amount: json["amount"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "name": name,
        "date_added":
            "${dateAdded.year.toString().padLeft(4, '0')}-${dateAdded.month.toString().padLeft(2, '0')}-${dateAdded.day.toString().padLeft(2, '0')}",
        "amount": amount,
        "description": description,
      };
}
```
5. **Membuat halaman yang berisi daftar semua item yang terdapat pada endpoint JSON di Django yang telah kamu deploy.**

Memodifikasi file yang sudah dibuat sebelumnya pada ```lib/screens``` yaitu ```booklist_items.dart```. Pada tugas sebelumnya, ```booklist_items.dart``` berisi item yang disimpan dilist pada saat menambahkan item di mobile app. Sekarang, akan mengambil data dari api django web yang sudah kita buat. Serta melakukan filtering user untuk menampilkan data dari user yang sedang login saja (implementasi bonus).
```dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:book_list/models/item.dart';
import 'package:book_list/widgets/left_drawer.dart';
import 'package:book_list/screens/login.dart';
import 'package:book_list/screens/book_details.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({Key? key}) : super(key: key);

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  Future<List<Item>> fetchItem() async {
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    var url =
        Uri.parse('http://muhammad-mariozulfandy-tugas.pbp.cs.ui.ac.id/json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<Item> list_item = [];
    for (var d in data) {
      if (d != null && d['fields']['user'] == user) {
        list_item.add(Item.fromJson(d));
      }
    }
    return list_item;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Lihat Buku',
            ),
          ),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        drawer: const LeftDrawer(),
        body: FutureBuilder(
            future: fetchItem(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.data!.length == 0) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Belum ada buku yang disimpan.",
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 20),
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) => InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BookDetailPage(
                                    snapshot.data![index].fields.name,
                                    snapshot.data![index].fields.amount,
                                    snapshot.data![index].fields.description)));
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${snapshot.data![index].fields.name}",
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text("${snapshot.data![index].fields.amount}"),
                              const SizedBox(height: 10),
                              Text(
                                  "${snapshot.data![index].fields.description}")
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
              }
            }));
  }
}
```

6. **Membuat halaman detail untuk setiap item yang terdapat pada halaman daftar Item.**

Membuat file baru pada ```lib/screens``` dengan nama ```book_details.dart```. Pada poin 5, setiap item ditampilkan dalam bentuk card dengan container InkWell yang dapat di-tap. Saat di tap, akan menampilkan halaman ```BookDetailPage``` yang dibuat pada ```book_details.dart```. Isi dari ```book_details.dart```:
```dart
import 'package:flutter/material.dart';

class BookDetailPage extends StatelessWidget {
  final String name;
  final int amount;
  final String description;
  const BookDetailPage(this.name, this.amount, this.description, {Key? key})
      : super(key: key); // Constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(name),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Amount: ${amount}'),
            SizedBox(height: 8),
            Text('Description: ${description}'),
          ],
        ),
      ),
    );
  }
}
```
Pemanggilan constructor saat di-tap:
```dart
InkWell(
onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => BookDetailPage(
          snapshot.data![index].fields.name,
          snapshot.data![index].fields.amount,
          snapshot.data![index].fields.description)));
},
...
)
```

7. **Implementasi Bonus**

- Filtering user. Sudah dijelaskan pada poin 5.

- Register

Membuat file ```register.dart``` pada ```lib/screens```. File tersebut berisi page yang berisi form registrasi pengguna. Data dari form tersebut akan dikirimkan ke django dan menambahkan user baru pada server.

Flutter:
```dart
import 'dart:convert';

import 'package:book_list/screens/login.dart';
import 'package:flutter/material.dart';
// TODO: Impor drawer yang sudah dibuat sebelumnya
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class RegisterFormPage extends StatefulWidget {
  const RegisterFormPage({super.key});

  @override
  State<RegisterFormPage> createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _username = "";
  String _password = "";
  String _password2 = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Form Registrasi',
          ),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Username",
                labelText: "Username",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              onChanged: (String? value) {
                setState(() {
                  _username = value!;
                });
              },
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Username tidak boleh kosong!";
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Password",
                labelText: "Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              obscureText: true,
              onChanged: (String? value) {
                setState(() {
                  _password = value!;
                });
              },
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Password tidak boleh kosong!";
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Konfirmasi Password",
                labelText: "Konfirmasi Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              obscureText: true,
              onChanged: (String? value) {
                setState(() {
                  _password2 = value!;
                });
              },
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Konfirmasi Password tidak boleh kosong!";
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
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 31, 141, 29)),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Kirim ke Django dan tunggu respons
                    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                    final response = await request.postJson(
                        "http://muhammad-mariozulfandy-tugas.pbp.cs.ui.ac.id/auth/create-user-flutter/",
                        jsonEncode(<String, String>{
                          'username': _username,
                          'password': _password,
                          'password2': _password2,
                          // TODO: Sesuaikan field data sesuai dengan aplikasimu
                        }));
                    if (response['status'] == 'success') {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Berhasil mendaftar!"),
                      ));
                      Navigator.pop(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(response['messages']),
                      ));
                    }
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

Django:
```py
@csrf_exempt
def create_user_flutter(request):
    if request.method == 'POST':
        data = json.loads(request.body)
        if User.objects.filter(username=data["username"]).exists():
            return JsonResponse({"status": "error", "messages":"Username telah digunakan!"}, status=401)
        elif len(data["password"]) < 8:
            return JsonResponse({"status": "error", "messages":"Password minimal 8 karakter!"}, status=401)
        elif data["password"] != data["password2"]:
            return JsonResponse({"status": "error", "messages":"Password dan Konfirmasi Password tidak sama!"}, status=401)
        else :
            user = User.objects.create_user(username=data["username"], password=data["password"])
            user.save()
            return JsonResponse({"status": "success"}, status=200)
    else:
        return JsonResponse({"status": "error", "messages":"Terdapat kesalahan pengisian, silahkan coba lagi!"}, status=401)
```

</details>


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
Pada poin 1, telah dibuat fungsi login pada ```views.py``` aplikasi ```authentication```.

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

</details>

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