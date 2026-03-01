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
  // Warna dan teks kotak
  Color rowColor = Colors.red;
  String rowText = "Merah";

  Color colColor = Colors.yellow;
  String colText = "Kuning";

  Color stackColor = Colors.blue;
  String stackText = "Biru";

  // Fungsi ubah warna dan teks
  void changeColorRow() {
    setState(() {
      if (rowColor == Colors.red) {
        rowColor = Colors.green;
        rowText = "Hijau";
      } else {
        rowColor = Colors.red;
        rowText = "Merah";
      }
    });
  }

  void changeColorCol() {
    setState(() {
      if (colColor == Colors.yellow) {
        colColor = Colors.orange;
        colText = "Oranye";
      } else {
        colColor = Colors.yellow;
        colText = "Kuning";
      }
    });
  }

  void changeColorStack() {
    setState(() {
      if (stackColor == Colors.blue) {
        stackColor = Colors.purple;
        stackText = "Ungu";
      } else {
        stackColor = Colors.blue;
        stackText = "Biru";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const Text("Row, Column & Stack Sederhana"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Row
              const Text("1️⃣ Row"),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: changeColorRow,
                child: Container(
                  width: 100,
                  height: 50,
                  color: rowColor,
                  alignment: Alignment.center,
                  child: Text(
                    rowText,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Column
              const Text("2️⃣ Column"),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: changeColorCol,
                child: Container(
                  width: 100,
                  height: 50,
                  color: colColor,
                  alignment: Alignment.center,
                  child: Text(
                    colText,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Stack
              const Text("3️⃣ Stack"),
              const SizedBox(height: 10),
              Stack(
                alignment: Alignment.center,
                children: [
                  GestureDetector(
                    onTap: changeColorStack,
                    child: Container(
                      width: 100,
                      height: 100,
                      color: stackColor,
                      alignment: Alignment.center,
                      child: Text(
                        stackText,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const Text("Tengah", style: TextStyle(color: Colors.black)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
