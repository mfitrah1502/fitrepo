import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const Text("Row, Column & Stack Demo"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1️⃣ ROW
              const Text(
                "1️⃣ Row (Horizontal Layout):",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(width: 60, height: 60, color: Colors.red),
                  const SizedBox(width: 10),
                  Container(width: 60, height: 60, color: Colors.yellow),
                  const SizedBox(width: 10),
                  Container(width: 60, height: 60, color: Colors.blue),
                ],
              ),
              const SizedBox(height: 30),

              // 2️⃣ COLUMN
              const Text(
                "2️⃣ Column (Vertical Layout):",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(width: 60, height: 60, color: Colors.red),
                  const SizedBox(height: 10),
                  Container(width: 60, height: 60, color: Colors.yellow),
                  const SizedBox(height: 10),
                  Container(width: 60, height: 60, color: Colors.blue),
                ],
              ),
              const SizedBox(height: 30),

              // 3️⃣ STACK
              const Text(
                "3️⃣ Stack (Menumpuk):",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(width: 100, height: 100, color: Colors.red),
                  Container(width: 70, height: 70, color: Colors.yellow),
                  Container(width: 40, height: 40, color: Colors.blue),
                  const Text(
                    "Tengah",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          blurRadius: 5,
                          offset: Offset(0, 0),
                        ),
                      ],
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
