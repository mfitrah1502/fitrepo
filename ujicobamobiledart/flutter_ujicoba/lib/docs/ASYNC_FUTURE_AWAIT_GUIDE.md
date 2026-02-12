# Async, Future, dan Await dalam Dart - Studi Kasus Mahasiswa

## 📚 Daftar Isi
1. [Konsep Dasar](#konsep-dasar)
2. [Future](#future)
3. [Async dan Await](#async-dan-await)
4. [Pattern dan Best Practices](#pattern-dan-best-practices)
5. [Contoh Code untuk Mahasiswa](#contoh-code-untuk-mahasiswa)

---

## Konsep Dasar

Dalam Dart, operasi asynchronous (async) memungkinkan program untuk melakukan tugas-tugas yang memakan waktu tanpa memblokir thread utama. Ini sangat penting dalam Flutter untuk:
- Network requests (fetch data dari API)
- File I/O (baca/tulis file)
- Database operations (query database)
- Timer dan delayed operations

---

## Future

### Apa itu Future?

`Future<T>` adalah objek yang merepresentasikan nilai dari tipe `T` yang akan tersedia di masa depan. Future dapat berakhir dalam dua state:

1. **Completed** (Selesai dengan sukses)
2. **Error** (Selesai dengan error)

### Contoh Dasar:

```dart
// Future yang selesai setelah 2 detik
Future<String> fetchMahasiswa() {
  return Future.delayed(Duration(seconds: 2), () {
    return 'Ahmad Wijaya';
  });
}

// Menggunakan callback .then()
void main() {
  fetchMahasiswa().then((value) {
    print('Nama: $value');
  }).catchError((error) {
    print('Error: $error');
  });
}
```

---

## Async dan Await

### Apa itu Async?

Keyword `async` ditambahkan ke function untuk menunjukkan bahwa function tersebut bersifat asynchronous dan akan mengembalikan `Future`.

### Apa itu Await?

Keyword `await` digunakan di dalam function `async` untuk:
- Menunggu Future selesai
- Extract nilai dari Future
- Membuat code terlihat seperti synchronous

### Contoh:

```dart
// Tanpa async/await (menggunakan .then())
void loginWithoutAsync() {
  loginUser('test@example.com', 'password123')
    .then((success) {
      if (success) {
        print('Login berhasil!');
      } else {
        print('Login gagal!');
      }
    })
    .catchError((error) {
      print('Error: $error');
    });
}

// Dengan async/await (lebih clean dan readable)
Future<void> loginWithAsync() async {
  try {
    bool success = await loginUser('test@example.com', 'password123');
    if (success) {
      print('Login berhasil!');
    } else {
      print('Login gagal!');
    }
  } catch (error) {
    print('Error: $error');
  }
}

// Function yang di-await
Future<bool> loginUser(String email, String password) async {
  // Simulasi network request
  await Future.delayed(Duration(seconds: 2));
  
  if (email == 'test@example.com' && password == 'password123') {
    return true;
  }
  return false;
}
```

---

## Pattern dan Best Practices

### 1. Simple Async/Await dengan Try-Catch

```dart
Future<void> fetchAndDisplayMahasiswa() async {
  try {
    final mahasiswa = await mahasiswaService.fetchAllMahasiswa();
    setState(() {
      _mahasiswaList = mahasiswa;
    });
  } catch (e) {
    // Handle error
    print('Error: $e');
  } finally {
    // Cleanup
    print('Done fetching');
  }
}
```

### 2. Multiple Futures dengan Future.wait()

Jalankan multiple futures secara bersamaan (concurrent):

```dart
Future<void> getCompleteStats() async {
  try {
    // Jalankan 3 futures secara concurrent
    final results = await Future.wait([
      mahasiswaService.fetchAllMahasiswa(),
      mahasiswaService.countByYear(),
      mahasiswaService.getTopStudents(),
    ]);

    final allMahasiswa = results[0];
    final countByYear = results[1];
    final topStudents = results[2];

    print('Total: ${(allMahasiswa as List).length}');
    print('By Year: $countByYear');
    print('Top: $topStudents');
  } catch (e) {
    print('Error: $e');
  }
}
```

### 3. Timeout Handling

Set batasan waktu untuk Future:

```dart
Future<void> fetchWithTimeout() async {
  try {
    final mahasiswa = await mahasiswaService
        .fetchAllMahasiswa()
        .timeout(Duration(seconds: 5));
    
    print('Success: ${mahasiswa.length} mahasiswa');
  } on TimeoutException {
    print('Request timeout setelah 5 detik!');
  } catch (e) {
    print('Error: $e');
  }
}
```

### 4. Sequential Futures

Menjalankan futures secara berurutan:

```dart
Future<void> registerMahasiswa(Mahasiswa mahasiswa) async {
  try {
    // Langkah 1: Validasi
    bool isValid = await validateMahasiswa(mahasiswa);
    
    if (!isValid) {
      throw Exception('Validasi gagal');
    }

    // Langkah 2: Check email belum terdaftar
    bool emailExists = await checkEmailExists(mahasiswa.email);
    
    if (emailExists) {
      throw Exception('Email sudah terdaftar');
    }

    // Langkah 3: Simpan ke database
    bool saved = await saveMahasiswaToDb(mahasiswa);
    
    if (saved) {
      print('Register berhasil!');
    }
  } catch (e) {
    print('Error: $e');
  }
}
```

### 5. Custom Future Builder Widget

```dart
FutureBuilder<List<Mahasiswa>>(
  future: mahasiswaService.fetchAllMahasiswa(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      return Center(child: Text('Error: ${snapshot.error}'));
    } else if (snapshot.hasData) {
      final mahasiswa = snapshot.data!;
      return ListView.builder(
        itemCount: mahasiswa.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(mahasiswa[index].fullname),
          );
        },
      );
    } else {
      return const Center(child: Text('No data'));
    }
  },
)
```

---

## Contoh Code untuk Mahasiswa

### mahasiswa_service.dart

```dart
import 'dart:async';
import '../models/mahasiswa.dart';

class MahasiswaService {
  static final List<Mahasiswa> _database = [];

  // Simple Future dengan await
  Future<bool> loginMahasiswa(String email, String password) async {
    await Future.delayed(Duration(seconds: 2));
    if (email == 'test@example.com' && password == 'password123') {
      return true;
    }
    return false;
  }

  // Future yang throw error + await
  Future<bool> registerMahasiswa(Mahasiswa mahasiswa) async {
    await Future.delayed(Duration(seconds: 3));

    bool emailExists = _database.any((m) => m.email == mahasiswa.email);
    if (emailExists) {
      throw Exception('Email sudah terdaftar!');
    }

    _database.add(mahasiswa);
    return true;
  }

  // Fetch dengan delay
  Future<List<Mahasiswa>> fetchAllMahasiswa() async {
    await Future.delayed(Duration(milliseconds: 1500));
    return _database;
  }

  // Search dengan error handling
  Future<List<Mahasiswa>> searchMahasiswa(String query) async {
    await Future.delayed(Duration(seconds: 1));

    return _database
        .where((m) => m.fullname.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  // Multiple futures dengan Future.wait
  Future<Map<String, dynamic>> getMahasiswaStats() async {
    try {
      final results = await Future.wait([
        fetchAllMahasiswa(),
        _countMahasiswaByYear(),
        _getTopStudents(),
      ]);

      return {
        'total': (results[0] as List).length,
        'byYear': results[1],
        'topStudents': results[2],
      };
    } catch (e) {
      throw Exception('Gagal get stats: $e');
    }
  }

  // Helper futures
  Future<Map<String, int>> _countMahasiswaByYear() async {
    await Future.delayed(Duration(milliseconds: 800));
    return {'2022': 5, '2023': 8, '2024': 3};
  }

  Future<List<String>> _getTopStudents() async {
    await Future.delayed(Duration(milliseconds: 1200));
    return ['Ahmad Wijaya', 'Siti Nurhaliza'];
  }

  // Timeout example
  Future<List<Mahasiswa>> fetchWithTimeout() async {
    return await fetchAllMahasiswa()
        .timeout(Duration(seconds: 5));
  }
}
```

### Penggunaan di LoginPage

```dart
class _LoginPageState extends State<LoginPage> {
  final MahasiswaService _service = MahasiswaService();
  bool _isLoading = false;

  Future<void> _login() async {
    setState(() => _isLoading = true);

    try {
      bool success = await _service.loginMahasiswa(email, password);
      
      if (success) {
        // Navigate ke halaman utama
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login gagal')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _isLoading ? null : _login,
      child: _isLoading
          ? const CircularProgressIndicator()
          : const Text('Login'),
    );
  }
}
```

---

## Tips dan Tricks

### 1. Selalu gunakan `mounted` untuk state changes setelah async

```dart
Future<void> fetchData() async {
  final data = await api.getData();
  
  if (mounted) {  // Cek apakah widget masih di tree
    setState(() {
      _data = data;
    });
  }
}
```

### 2. Gunakan `finally` untuk cleanup

```dart
Future<void> operation() async {
  try {
    // Operasi
  } finally {
    // Cleanup resources
  }
}
```

### 3. Hindari floating Future (Future tanpa await)

```dart
// BURUK - floating future
_service.fetchData();  // ❌ Tidak ada error handling

// BAIK - await atau handle error
await _service.fetchData();  // ✅
_service.fetchData().then(...).catchError(...);  // ✅
```

### 4. Gunakan FutureBuilder untuk UI yang lebih simple

```dart
FutureBuilder<List<Mahasiswa>>(
  future: _service.fetchAllMahasiswa(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const LoadingWidget();
    }
    if (snapshot.hasError) {
      return ErrorWidget(error: snapshot.error);
    }
    return DataWidget(data: snapshot.data);
  },
)
```

---

## Diagram Flow

```
┌─────────────────────────────────────────────────────┐
│           Execution Flow: Future<String>             │
├─────────────────────────────────────────────────────┤
│                                                      │
│  main() async {                                      │
│    print('Start');           ← Line 1                │
│    String name = await fetchName();  ← Wait here    │
│    print(name);              ← Line 3 (setelah Future selesai) │
│  }                                                   │
│                                                      │
│  Future<String> fetchName() async {                  │
│    await Future.delayed(Duration(seconds: 2));      │
│    return 'Ahmad';  ← Future completed              │
│  }                                                   │
│                                                      │
│  Output:                                             │
│  Start                                               │
│  (wait 2 seconds...)                                 │
│  Ahmad                                               │
└─────────────────────────────────────────────────────┘
```

---

## Checklist Penggunaan Async/Await

- ✅ Gunakan `async` pada function yang melakukan operasi asynchronous
- ✅ Gunakan `await` untuk menunggu Future selesai
- ✅ Selalu gunakan try-catch-finally untuk error handling
- ✅ Check `mounted` sebelum setState setelah async operation
- ✅ Gunakan `Future.wait()` untuk concurrent operations
- ✅ Set timeout untuk network requests
- ✅ Hindari floating futures
- ✅ Gunakan FutureBuilder untuk UI yang lebih clean

---

## Resources dan Learning

- [Dart Async Documentation](https://dart.dev/guides/libraries/async-await)
- [Flutter FutureBuilder](https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html)
- [Dart Concurrency Guide](https://dart.dev/guides/language/concurrency)

---

**Dibuat untuk: Studi Kasus Mahasiswa dengan Async/Future/Await**
