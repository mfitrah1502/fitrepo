import 'dart:async';
import '../models/mahasiswa.dart';

// Mahasiswa Service dengan implementasi Async/Future/Await
class MahasiswaService {
  
  // Simulasi database mahasiswa
  static final List<Mahasiswa> _databaseMahasiswa = [
    Mahasiswa(
      fullname: 'Ahmad Wijaya',
      username: 'ahmad_wijaya',
      email: 'ahmad@example.com',
      address: 'Jl. Raya No. 123',
      phone: '081234567890',
      nim: '2022001',
    ),
    Mahasiswa(
      fullname: 'Siti Nurhaliza',
      username: 'siti_nurh',
      email: 'siti@example.com',
      address: 'Jl. Sudirman No. 456',
      phone: '082345678901',
      nim: '2022002',
    ),
  ];

  // Future untuk simulasi login dengan delay
  Future<bool> loginMahasiswa(String email, String password) async {
    // Simulasi delay koneksi ke server (2 detik)
    await Future.delayed(Duration(seconds: 2));

    // Validasi login (contoh sederhana)
    if (email == 'test@example.com' && password == 'password123') {
      return true;
    }
    return false;
  }

  // Future untuk register mahasiswa baru
  Future<bool> registerMahasiswa(Mahasiswa mahasiswa) async {
    // Simulasi delay request ke server (3 detik)
    await Future.delayed(Duration(seconds: 3));

    // Validasi email belum terdaftar
    bool emailExists = _databaseMahasiswa
        .any((m) => m.email == mahasiswa.email);
    
    if (emailExists) {
      throw Exception('Email sudah terdaftar!');
    }

    // Validasi username belum terdaftar
    bool usernameExists = _databaseMahasiswa
        .any((m) => m.username == mahasiswa.username);
    
    if (usernameExists) {
      throw Exception('Username sudah terdaftar!');
    }

    // Simulasi error random (10% kemungkinan gagal)
    if (DateTime.now().millisecond % 10 == 0) {
      throw Exception('Koneksi server gagal. Silakan coba lagi.');
    }

    // Tambahkan mahasiswa baru ke database
    _databaseMahasiswa.add(mahasiswa);
    return true;
  }

  // Future untuk fetch semua mahasiswa
  Future<List<Mahasiswa>> fetchAllMahasiswa() async {
    // Simulasi delay query database (1.5 detik)
    await Future.delayed(Duration(milliseconds: 1500));
    
    // Return list mahasiswa
    return _databaseMahasiswa;
  }

  // Future untuk fetch mahasiswa by email
  Future<Mahasiswa?> fetchMahasiswaByEmail(String email) async {
    // Simulasi delay query database
    await Future.delayed(Duration(seconds: 1));

    try {
      return _databaseMahasiswa
          .firstWhere((m) => m.email == email);
    } catch (e) {
      return null;
    }
  }

  // Future untuk update profil mahasiswa
  Future<bool> updateMahasiswaProfil(
      String email, Mahasiswa updatedData) async {
    // Simulasi delay update database (2 detik)
    await Future.delayed(Duration(seconds: 2));

    try {
      int index = _databaseMahasiswa
          .indexWhere((m) => m.email == email);
      
      if (index != -1) {
        _databaseMahasiswa[index] = updatedData;
        return true;
      }
      return false;
    } catch (e) {
      throw Exception('Gagal update profil: ${e.toString()}');
    }
  }

  // Future untuk delete mahasiswa
  Future<bool> deleteMahasiswa(String email) async {
    // Simulasi delay delete dari database (1.5 detik)
    await Future.delayed(Duration(milliseconds: 1500));

    try {
      _databaseMahasiswa
          .removeWhere((m) => m.email == email);
      return true;
    } catch (e) {
      throw Exception('Gagal delete mahasiswa: ${e.toString()}');
    }
  }

  // Future untuk search mahasiswa dengan delay simulasi
  Future<List<Mahasiswa>> searchMahasiswa(String query) async {
    // Simulasi delay search (1 detik)
    await Future.delayed(Duration(seconds: 1));

    final results = _databaseMahasiswa.where((m) =>
        m.fullname.toLowerCase().contains(query.toLowerCase()) ||
        m.email.toLowerCase().contains(query.toLowerCase()) ||
        m.username.toLowerCase().contains(query.toLowerCase())).toList();
    
    return results;
  }

  // Future dengan timeout example
  Future<List<Mahasiswa>> fetchMahasiswaWithTimeout() async {
    try {
      return await fetchAllMahasiswa()
          .timeout(Duration(seconds: 5));
    } on TimeoutException {
      throw Exception('Request timeout! Server tidak merespons dalam 5 detik');
    }
  }

  // Multiple Future dengan Future.wait (Concurrent execution)
  Future<Map<String, dynamic>> getMahasiswaStats() async {
    try {
      // Jalankan 3 future secara bersamaan
      final results = await Future.wait([
        fetchAllMahasiswa(),
        _countMahasiswaByYear(),
        _getTopStudents(),
      ]);

      return {
        'totalMahasiswa': (results[0] as List).length,
        'byYear': results[1],
        'topStudents': results[2],
      };
    } catch (e) {
      throw Exception('Gagal get stats: ${e.toString()}');
    }
  }

  // Future helper untuk count mahasiswa
  Future<Map<String, int>> _countMahasiswaByYear() async {
    await Future.delayed(Duration(milliseconds: 800));
    return {'2022': 2, '2023': 0, '2024': 0};
  }

  // Future helper untuk get top students
  Future<List<String>> _getTopStudents() async {
    await Future.delayed(Duration(milliseconds: 1200));
    return const ['Ahmad Wijaya', 'Siti Nurhaliza'];
  }
}
