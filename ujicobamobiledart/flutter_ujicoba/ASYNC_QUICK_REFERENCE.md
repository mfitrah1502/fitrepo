# 🚀 Async/Future/Await Quick Reference - Mahasiswa

## Basic Syntax

### Return Future from Function
```dart
// Returns Future<String>
Future<String> fetchName() async {
  await Future.delayed(Duration(seconds: 1));
  return 'Ahmad';
}

// Usage
String name = await fetchName();
```

---

## Common Patterns

### ✅ Pattern 1: Simple Async/Await with Try-Catch

```dart
Future<void> loadData() async {
  try {
    final data = await fetchData();
    setState(() => _data = data);
  } catch (e) {
    print('Error: $e');
  } finally {
    print('Done');
  }
}
```

**Digunakan untuk:** Operasi sederhana dengan error handling

---

### ✅ Pattern 2: Loading State Management

```dart
Future<void> operation() async {
  setState(() => _isLoading = true);
  
  try {
    final result = await service.operation();
    setState(() => _result = result);
  } catch (e) {
    setState(() => _error = e.toString());
  } finally {
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }
}
```

**Digunakan untuk:** UI dengan loading indicator

---

### ✅ Pattern 3: Sequential Operations

```dart
Future<void> registerUser(User user) async {
  try {
    // Step 1
    bool isValid = await validate(user);
    if (!isValid) throw Exception('Invalid');
    
    // Step 2
    bool emailExists = await checkEmail(user.email);
    if (emailExists) throw Exception('Email exists');
    
    // Step 3
    bool saved = await saveToDb(user);
    if (saved) print('Success');
  } catch (e) {
    print('Error: $e');
  }
}
```

**Digunakan untuk:** Multiple dependent operations

---

### ✅ Pattern 4: Concurrent Operations (Future.wait)

```dart
Future<void> loadStats() async {
  try {
    final results = await Future.wait([
      fetchUsers(),        // Future 1
      fetchPosts(),        // Future 2
      fetchComments(),     // Future 3
    ]);
    
    final users = results[0];
    final posts = results[1];
    final comments = results[2];
  } catch (e) {
    print('Error: $e');
  }
}
```

**Digunakan untuk:** Operasi independen yang bisa berjalan parallel

---

### ✅ Pattern 5: Timeout Handling

```dart
Future<void> fetchWithTimeout() async {
  try {
    final data = await fetchData()
        .timeout(Duration(seconds: 5));
    print('Success: $data');
  } on TimeoutException {
    print('Request timeout!');
  } catch (e) {
    print('Error: $e');
  }
}
```

**Digunakan untuk:** Network requests dengan timeout

---

### ✅ Pattern 6: FutureBuilder Widget

```dart
FutureBuilder<List<Mahasiswa>>(
  future: fetchMahasiswa(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      return Center(child: Text('Error: ${snapshot.error}'));
    } else if (snapshot.hasData) {
      return ListView(
        children: snapshot.data!.map((m) => 
          ListTile(title: Text(m.fullname))
        ).toList(),
      );
    } else {
      return Center(child: Text('No data'));
    }
  },
)
```

**Digunakan untuk:** UI yang display Future result directly

---

### ✅ Pattern 7: Error Retry

```dart
Future<T> retryWithFallback<T>(
  Future<T> Function() operation, {
  int maxRetries = 3,
}) async {
  for (int i = 0; i < maxRetries; i++) {
    try {
      return await operation();
    } catch (e) {
      if (i == maxRetries - 1) rethrow;
      await Future.delayed(Duration(seconds: 1 * (i + 1)));
    }
  }
  throw Exception('Failed after $maxRetries retries');
}

// Usage
final data = await retryWithFallback(
  () => fetchData(),
  maxRetries: 3,
);
```

**Digunakan untuk:** Reliable network operations dengan retry

---

## Mahasiswa Service Methods

### Login
```dart
Future<bool> loginMahasiswa(String email, String password) async {
  // Returns: true/false
  // Delay: 2 seconds
}
```

### Register
```dart
Future<bool> registerMahasiswa(Mahasiswa mahasiswa) async {
  // Throws: Exception jika email/username sudah ada
  // Delay: 3 seconds
}
```

### Fetch All
```dart
Future<List<Mahasiswa>> fetchAllMahasiswa() async {
  // Returns: List of all mahasiswa
  // Delay: 1.5 seconds
}
```

### Search
```dart
Future<List<Mahasiswa>> searchMahasiswa(String query) async {
  // Returns: Filtered list
  // Delay: 1 second
}
```

### Get Stats
```dart
Future<Map<String, dynamic>> getMahasiswaStats() async {
  // Returns: {totalMahasiswa, byYear, topStudents}
  // Uses: Future.wait() for concurrent operations
}
```

---

## Key Keywords

| Keyword | Usage |
|---------|-------|
| `async` | Tandai function yang return Future |
| `await` | Tunggu Future selesai (hanya di dalam async) |
| `Future<T>` | Type yang represent nilai di masa depan |
| `.then()` | Callback setelah Future selesai |
| `.catchError()` | Handle error dari Future |
| `Future.wait()` | Jalankan multiple futures secara concurrent |
| `Future.delayed()` | Create Future yang delay X waktu |
| `.timeout()` | Set timeout untuk Future |
| `TimeoutException` | Exception jika Future exceed timeout |

---

## Anti-Patterns ❌

### ❌ Floating Future (Tanpa await/then)
```dart
// BURUK
_service.fetchData();  // No error handling!

// BAIK
await _service.fetchData();  // ✅
```

### ❌ setState Tanpa Check Mounted
```dart
// BURUK
final data = await fetchData();
setState(() => _data = data);  // Bisa crash jika widget disposed!

// BAIK
final data = await fetchData();
if (mounted) {
  setState(() => _data = data);  // ✅
}
```

### ❌ Blocking Main Thread
```dart
// BURUK
List data = fetchDataSync();  // Freeze UI

// BAIK
List data = await fetchDataAsync();  // ✅ Smooth UI
```

### ❌ Multiple Awaits (Saat Bisa Concurrent)
```dart
// BURUK - Sequential (slow)
var user = await getUser();       // Wait 2s
var posts = await getPosts();     // Wait 2s
// Total: 4 seconds

// BAIK - Concurrent (fast)
var results = await Future.wait([
  getUser(),    // Wait 2s
  getPosts(),   // Wait 2s (in parallel)
]);
// Total: 2 seconds
```

---

## Common Mistakes & Fixes

| ❌ Mistake | ✅ Fix |
|-----------|--------|
| Forget `await` | Add `await` before Future |
| No try-catch | Wrap in try-catch-finally |
| No mounted check | Check `if (mounted)` before setState |
| Floating futures | Await atau use .then().catchError() |
| Block main thread | Use async operation |
| No timeout | Add `.timeout(Duration)` |

---

## Debug Tips

### Check if Function Returns Future
```dart
// If function is async, it always returns Future
Future<void> myFunc() async { }  // ✅ Returns Future<void>
  
// If function is not async, need to return Future explicitly
Future<String> getData() {
  return Future.value('data');  // ✅ Explicit Future
}
```

### Understanding ConnectionState
```dart
FutureBuilder<Data>(
  future: _future,
  builder: (context, snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:        // No future
      case ConnectionState.waiting:     // Loading
      case ConnectionState.active:      // Stream only
      case ConnectionState.done:        // Complete
    }
  },
)
```

### Print Debug Info
```dart
Future<void> debug() async {
  print('Start: ${DateTime.now()}');
  await Future.delayed(Duration(seconds: 2));
  print('End: ${DateTime.now()}');
}
```

---

## Performance Tips

1. **Gunakan Future.wait() untuk concurrent operations** (lebih cepat)
2. **Set timeout pada network requests** (avoid hanging)
3. **Implement caching** untuk reduce API calls
4. **Use FutureBuilder** untuk automatic loading states
5. **Implement retry mechanism** untuk reliability

---

## Test Credentials

- **Email:** test@example.com
- **Password:** password123

---

## Related Files

- `lib/services/mahasiswa_service.dart` - Service implementation
- `lib/loginpage.dart` - Login async example
- `lib/registerpage.dart` - Register async example
- `lib/pages/mahasiswa_example_page.dart` - Interactive demo
- `lib/docs/ASYNC_FUTURE_AWAIT_GUIDE.md` - Full documentation

---

**Quick Reference v1.0** | Last updated: Feb 2026
