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
        backgroundColor: Colors.green,
        appBar: AppBar(backgroundColor: Color(0xffffff), title: Text("MyApps")),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(width: 100, height: 100, color: Colors.red),
                SizedBox(height: 20),
                Text("merah"),
              ],
            ),
            SizedBox(width: 20),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(width: 100, height: 100, color: Colors.yellow),
                SizedBox(height: 20),
                Text("kuning"),
              ],
            ),
            SizedBox(width: 20),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(width: 100, height: 100, color: Colors.blue),
                SizedBox(height: 20),
                Text("biru"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
