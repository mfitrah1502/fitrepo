import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> items = ["Item 1", "Item 2", "Item 3"];

  void tambahItem() {
    setState(() {
      items.add("Item ${items.length + 1}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
<<<<<<< HEAD
          title: const Text("Row, Column & Stack Stateless"),
          backgroundColor: const Color.fromARGB(255, 153, 112, 225),
=======
          title: const Text("Column + Tombol Tambah"),
          centerTitle: true,
>>>>>>> 6b8f3dc8fdea069753bc202d612a83bad38656e5
        ),
        body: Center(
          child: Column(
<<<<<<< HEAD
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Row
              const Text("1️⃣ Row"),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 80,
                    height: 50,
                    color: Colors.red,
                    alignment: Alignment.center,
                    child: const Text(
                      "Merah",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 50,
                    color: Colors.green,
                    alignment: Alignment.center,
                    child: const Text(
                      "Hijau",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 50,
=======
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // List Item
              ...items.map(
                (item) => Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.all(15),
                  width: 200,
                  decoration: BoxDecoration(
>>>>>>> 6b8f3dc8fdea069753bc202d612a83bad38656e5
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    item,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 20),

<<<<<<< HEAD
              // Column
              const Text("2️⃣ Column"),
              const SizedBox(height: 10),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 100,
                    height: 50,
                    color: Colors.yellow,
                    alignment: Alignment.center,
                    child: const Text(
                      "Kuning",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 100,
                    height: 50,
                    color: Colors.orange,
                    alignment: Alignment.center,
                    child: const Text(
                      "Oranye",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 100,
                    height: 50,
                    color: Colors.purple,
                    alignment: Alignment.center,
                    child: const Text(
                      "Ungu",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Stack
              const Text("3️⃣ Stack"),
              const SizedBox(height: 10),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(width: 100, height: 100, color: Colors.pink),
                  Container(width: 70, height: 70, color: Colors.teal),
                  Container(width: 40, height: 40, color: Colors.brown),
                  const Text(
                    "Tengah",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                   // TAMBAHAN BARU
                  Positioned(
                    bottom: 4,
                    right: 4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      color: Colors.white,
                      child: const Text(
                        "NEW",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
=======
              // Tombol Tambah
              ElevatedButton(
                onPressed: tambahItem,
                child: const Text("Tambah Item"),
>>>>>>> 6b8f3dc8fdea069753bc202d612a83bad38656e5
              ),
            ],
          ),
        ),
      ),
    );
  }
<<<<<<< HEAD

}
=======
}
>>>>>>> 6b8f3dc8fdea069753bc202d612a83bad38656e5
