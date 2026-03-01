import 'package:flutter/material.dart';

void main() {
  runApp(const MyStatelessApp());
}

class MyStatelessApp extends StatelessWidget {
  const MyStatelessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Row, Column & Stack Stateless"),
          backgroundColor: Colors.teal,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row
              const Text("1️⃣ Row"),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                    color: Colors.blue,
                    alignment: Alignment.center,
                    child: const Text(
                      "Biru",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
