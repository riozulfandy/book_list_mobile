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
