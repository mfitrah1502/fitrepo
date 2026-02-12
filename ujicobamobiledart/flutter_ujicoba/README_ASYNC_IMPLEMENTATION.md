# Async/Future/Await - Studi Kasus Mahasiswa

## 📋 Overview

Implementasi lengkap **Async, Future, dan Await** dalam Dart/Flutter untuk studi kasus sistem manajemen mahasiswa. Project ini mendemonstrasikan berbagai pola penggunaan asynchronous programming dalam Flutter dengan contoh praktis.

---

## 📁 File Structure

```
lib/
├── main.dart                          # Entry point aplikasi
├── loginpage.dart                     # Login dengan async/await ⭐
├── registerpage.dart                  # Register dengan async/await ⭐
├── models/
│   └── mahasiswa.dart                 # Model data mahasiswa
├── services/
│   └── mahasiswa_service.dart         # Service layer dengan Future ⭐⭐⭐
├── pages/
│   └── mahasiswa_example_page.dart    # Demo 4 contoh async patterns ⭐⭐
└── docs/
    └── ASYNC_FUTURE_AWAIT_GUIDE.md    # Dokumentasi lengkap 📚

```

---

## 🎯 Yang Telah Diimplementasikan

### 1. **MahasiswaService** (`services/mahasiswa_service.dart`)
Service layer yang mendemonstrasikan berbagai pola Future:

#### ✅ Simple Future dengan Async/Await
```dart
Future<bool> loginMahasiswa(String email, String password) async {
  await Future.delayed(Duration(seconds: 2));
  return email == 'test@example.com' && password == 'password123';
}
```

#### ✅ Future dengan Error Handling
```dart
Future<bool> registerMahasiswa(Mahasiswa mahasiswa) async {
  await Future.delayed(Duration(seconds: 3));
  
  bool emailExists = _database.any((m) => m.email == mahasiswa.email);
  if (emailExists) {
    throw Exception('Email sudah terdaftar!');
  }
  
  _database.add(mahasiswa);
  return true;
}
```

#### ✅ Search dengan Delay
```dart
Future<List<Mahasiswa>> searchMahasiswa(String query) async {
  await Future.delayed(Duration(seconds: 1));
  return _database.where((m) => ...).toList();
}
```

#### ✅ Multiple Futures dengan Future.wait()
```dart
Future<Map<String, dynamic>> getMahasiswaStats() async {
  final results = await Future.wait([
    fetchAllMahasiswa(),
    _countMahasiswaByYear(),
    _getTopStudents(),
  ]);
  return {...};
}
```

#### ✅ Timeout Handling
```dart
Future<List<Mahasiswa>> fetchMahasiswaWithTimeout() async {
  try {
    return await fetchAllMahasiswa().timeout(Duration(seconds: 5));
  } on TimeoutException {
    throw Exception('Request timeout!');
  }
}
```

---

### 2. **LoginPage** (`lib/loginpage.dart`)
Implementasi login dengan async/await dan loading state:

```dart
Future<void> _login() async {
  setState(() => _isLoading = true);
  
  try {
    bool success = await _mahasiswaService.loginMahasiswa(email, password);
    
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login berhasil!'))
      );
    }
  } catch (e) {
    // Error handling
  } finally {
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }
}
```

**Features:**
- ✅ Async login dengan delay simulasi 2 detik
- ✅ Loading indicator saat proses login
- ✅ Error handling dengan try-catch-finally
- ✅ Check `mounted` sebelum setState
- ✅ Loading state untuk disable button

---

### 3. **RegisterPage** (`lib/registerpage.dart`)
Implementasi register dengan async/await:

```dart
Future<void> _register() async {
  setState(() => _isLoading = true);
  
  try {
    final newMahasiswa = Mahasiswa(...);
    bool success = await _mahasiswaService.registerMahasiswa(newMahasiswa);
    
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Register berhasil!'))
      );
      await Future.delayed(Duration(seconds: 2));
      Navigator.pop(context);
    }
  } catch (e) {
    // Error handling
  } finally {
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }
}
```

**Features:**
- ✅ Async register dengan delay simulasi 3 detik
- ✅ Validasi email belum terdaftar
- ✅ Validasi username belum terdaftar
- ✅ Field tambahan: username, NIM, address
- ✅ Loading indicator pada button
- ✅ Auto-navigate kembali ke login setelah register sukses

---

### 4. **Example Page** (`lib/pages/mahasiswa_example_page.dart`)
Halaman demo interaktif yang menampilkan 4 contoh async patterns:

1. **Simple Future dengan Async/Await** - Fetch semua mahasiswa
2. **Future dengan Error Handling** - Real-time search
3. **Timeout Handling** - Fetch dengan timeout 5 detik
4. **Multiple Futures** - Fetch stats dengan Future.wait()

**Cara menggunakan:**
```dart
// Di main.dart atau router
MaterialPageRoute(
  builder: (context) => const MahasiswaExamplePage()
)
```

---

## 📚 Dokumentasi

File `lib/docs/ASYNC_FUTURE_AWAIT_GUIDE.md` berisi:

- ✅ Penjelasan konsep Async/Future/Await
- ✅ 5 pattern umum dan best practices
- ✅ Contoh code yang dapat langsung digunakan
- ✅ Tips dan tricks
- ✅ Diagram flow execution
- ✅ Checklist penggunaan

---

## 🚀 Cara Menggunakan

### 1. Login dengan Async (Test di LoginPage)
```
Email: test@example.com
Password: password123
```

### 2. Register Mahasiswa Baru (Test di RegisterPage)
```
- Isi semua field
- Klik "Register" untuk simulasi async register
- Tunggu 3 detik loading
- Lihat loading indicator pada button
```

### 3. Lihat Demo Semua Patterns (Test di MahasiswaExamplePage)
```dart
// Navigasi ke example page
Navigator.push(context, MaterialPageRoute(
  builder: (context) => const MahasiswaExamplePage()
));
```

---

## 🎓 Key Learning Points

### 1. **Perbedaan Sync vs Async**
```dart
// Synchronous - Blocking
List<Mahasiswa> mahasiswa = fetchMahasiswa();  // Tunggu sampai selesai

// Asynchronous - Non-blocking
Future<List<Mahasiswa>> mahasiswa = fetchMahasiswa();  // Lanjut tanpa tunggu
```

### 2. **Menggunakan Await**
```dart
// Jadi synchronous di dalam async function
Future<void> loadData() async {
  List<Mahasiswa> data = await fetchMahasiswa();  // Tunggu selesai
  print(data);  // Jalan setelah await selesai
}
```

### 3. **Error Handling**
```dart
Future<void> operation() async {
  try {
    var result = await someAsyncOperation();
  } catch (error) {
    // Handle error
  } finally {
    // Cleanup
  }
}
```

### 4. **Multiple Concurrent Operations**
```dart
// Sequential
var user = await getUser();
var posts = await getPosts(user.id);

// Concurrent (lebih cepat)
var results = await Future.wait([
  getUser(),
  getPosts(userId),
]);
```

---

## 🧪 Testing

### Simulasi Network Request
Service sudah mensimulasikan delay:
- Login: 2 detik
- Register: 3 detik
- Fetch: 1.5 detik
- Search: 1 detik

Setiap operasi akan menampilkan loading indicator.

### Error Simulation
Register memiliki:
- Validasi email sudah terdaftar
- Validasi username sudah terdaftar
- Random error (10% chance) untuk simulasi network failure

---

## 💡 Best Practices yang Diterapkan

✅ **Selalu gunakan try-catch-finally**
```dart
try {
  await operation();
} catch (e) {
  // Handle error
} finally {
  // Cleanup
}
```

✅ **Check mounted sebelum setState**
```dart
if (mounted) {
  setState(() => _isLoading = false);
}
```

✅ **Disable UI saat loading**
```dart
ElevatedButton(
  onPressed: _isLoading ? null : _login,
  child: _isLoading ? LoadingIndicator() : Text('Login'),
)
```

✅ **Gunakan Future.wait untuk concurrent operations**
```dart
final results = await Future.wait([...]);  // Lebih cepat
```

✅ **Set timeout untuk network requests**
```dart
await request.timeout(Duration(seconds: 5));
```

---

## 🔄 Diagram Execution Flow

```
LoginPage._login()
    ↓
setState(_isLoading = true)
    ↓
await _mahasiswaService.loginMahasiswa(...)
    ↓ (Tunggu 2 detik)
    ↓
return true/false
    ↓
if (mounted) setState(_isLoading = false)
    ↓
Show SnackBar
```

---

## 📖 Refrensi Dokumentasi

- [Dart Async Documentation](https://dart.dev/guides/libraries/async-await)
- [Flutter FutureBuilder](https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html)
- [Dart Concurrency Guide](https://dart.dev/guides/language/concurrency)

---

## 🎯 Next Steps

1. **Implementasi real API**
   - Replace simulasi dengan HTTP request menggunakan `http` atau `dio` package

2. **Tambah error handling yang lebih robust**
   - Retry mechanism
   - Connection timeout handling
   - Exponential backoff

3. **Tambah state management**
   - Provider
   - Riverpod
   - Bloc

4. **Implementasi caching**
   - Local database dengan SQLite
   - Shared preferences

---

**Created for: Learning Async/Future/Await dengan Studi Kasus Mahasiswa** 📚
