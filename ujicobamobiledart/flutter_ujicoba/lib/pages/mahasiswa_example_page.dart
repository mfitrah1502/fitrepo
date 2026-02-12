import 'package:flutter/material.dart';
import 'package:flutter_ujicoba/models/mahasiswa.dart';
import 'package:flutter_ujicoba/services/mahasiswa_service.dart';

/// Contoh halaman yang mendemonstrasikan berbagai pola Async/Future/Await
/// dalam Dart dan Flutter untuk studi kasus Mahasiswa
class MahasiswaExamplePage extends StatefulWidget {
  const MahasiswaExamplePage({super.key});

  @override
  State<MahasiswaExamplePage> createState() => _MahasiswaExamplePageState();
}

class _MahasiswaExamplePageState extends State<MahasiswaExamplePage> {
  final MahasiswaService _service = MahasiswaService();

  // State untuk contoh 1: Fetch semua mahasiswa
  List<Mahasiswa> _allMahasiswa = [];
  bool _loadingAllMahasiswa = false;
  String _errorAllMahasiswa = '';

  // State untuk contoh 2: Search mahasiswa
  List<Mahasiswa> _searchResults = [];
  bool _loadingSearch = false;
  String _errorSearch = '';
  final TextEditingController _searchController = TextEditingController();

  // State untuk contoh 3: Fetch dengan timeout
  String _timeoutResult = '';
  bool _loadingTimeout = false;

  // State untuk contoh 4: Multiple futures (stats)
  Map<String, dynamic> _stats = {};
  bool _loadingStats = false;
  String _errorStats = '';

  // CONTOH 1: Simple Future dengan Async/Await
  Future<void> _fetchAllMahasiswa() async {
    setState(() {
      _loadingAllMahasiswa = true;
      _errorAllMahasiswa = '';
    });

    try {
      // Await untuk menunggu hasil dari Future
      final mahasiswa = await _service.fetchAllMahasiswa();

      if (mounted) {
        setState(() {
          _allMahasiswa = mahasiswa;
          _loadingAllMahasiswa = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorAllMahasiswa = 'Error: ${e.toString()}';
          _loadingAllMahasiswa = false;
        });
      }
    }
  }

  // CONTOH 2: Future dengan delay dan error handling
  Future<void> _searchMahasiswa(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    setState(() {
      _loadingSearch = true;
      _errorSearch = '';
    });

    try {
      // Await untuk search dengan delay 1 detik
      final results = await _service.searchMahasiswa(query);

      if (mounted) {
        setState(() {
          _searchResults = results;
          _loadingSearch = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorSearch = 'Error: ${e.toString()}';
          _loadingSearch = false;
        });
      }
    }
  }

  // CONTOH 3: Future dengan Timeout
  Future<void> _fetchWithTimeout() async {
    setState(() {
      _loadingTimeout = true;
      _timeoutResult = '';
    });

    try {
      // Await dengan timeout - jika > 5 detik maka TimeoutException
      final mahasiswa = await _service.fetchMahasiswaWithTimeout();

      if (mounted) {
        setState(() {
          _timeoutResult = 'Berhasil fetch ${mahasiswa.length} mahasiswa!';
          _loadingTimeout = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _timeoutResult = 'Timeout Error: ${e.toString()}';
          _loadingTimeout = false;
        });
      }
    }
  }

  // CONTOH 4: Multiple Futures dengan Future.wait (Concurrent)
  Future<void> _fetchStats() async {
    setState(() {
      _loadingStats = true;
      _errorStats = '';
    });

    try {
      // Await Future.wait untuk jalankan multiple futures secara bersamaan
      final stats = await _service.getMahasiswaStats();

      if (mounted) {
        setState(() {
          _stats = stats;
          _loadingStats = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorStats = 'Error: ${e.toString()}';
          _loadingStats = false;
        });
      }
    }
  }

  @override
  dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contoh Async/Future/Await - Mahasiswa'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // CONTOH 1: Fetch semua mahasiswa
            _buildExampleCard(
              title: 'CONTOH 1: Simple Future dengan Async/Await',
              description: 'Fetch semua data mahasiswa dari database',
              code: '''Future<void> _fetchAllMahasiswa() async {
  try {
    final mahasiswa = await _service.fetchAllMahasiswa();
    setState(() => _allMahasiswa = mahasiswa);
  } catch (e) {
    setState(() => _error = e.toString());
  }
}''',
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: _loadingAllMahasiswa ? null : _fetchAllMahasiswa,
                    child: _loadingAllMahasiswa
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : const Text('Fetch Semua Mahasiswa'),
                  ),
                  const SizedBox(height: 12),
                  if (_errorAllMahasiswa.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.red.shade100,
                      child: Text(
                        _errorAllMahasiswa,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  if (_allMahasiswa.isNotEmpty)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _allMahasiswa.length,
                      itemBuilder: (context, index) {
                        final m = _allMahasiswa[index];
                        return ListTile(
                          leading: const Icon(Icons.person),
                          title: Text(m.fullname),
                          subtitle: Text(m.email),
                        );
                      },
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // CONTOH 2: Search dengan await
            _buildExampleCard(
              title: 'CONTOH 2: Future dengan Error Handling',
              description: 'Search mahasiswa dengan validasi input',
              code: '''Future<void> _searchMahasiswa(String query) async {
  try {
    final results = await _service.searchMahasiswa(query);
    setState(() => _searchResults = results);
  } catch (e) {
    setState(() => _error = e.toString());
  }
}''',
              child: Column(
                children: [
                  TextField(
                    controller: _searchController,
                    enabled: !_loadingSearch,
                    onChanged: _searchMahasiswa,
                    decoration: InputDecoration(
                      hintText: 'Cari nama, email, atau username...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.search),
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (_loadingSearch)
                    const CircularProgressIndicator()
                  else if (_errorSearch.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.red.shade100,
                      child: Text(
                        _errorSearch,
                        style: const TextStyle(color: Colors.red),
                      ),
                    )
                  else if (_searchResults.isNotEmpty)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final m = _searchResults[index];
                        return ListTile(
                          leading: const Icon(Icons.person),
                          title: Text(m.fullname),
                          subtitle: Text('${m.email} • ${m.nim}'),
                        );
                      },
                    )
                  else if (_searchController.text.isNotEmpty)
                    const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text('Tidak ada hasil ditemukan'),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // CONTOH 3: Timeout handling
            _buildExampleCard(
              title: 'CONTOH 3: Future dengan Timeout',
              description: 'Fetch data dengan timeout 5 detik (TimeoutException)',
              code: '''Future<void> _fetchWithTimeout() async {
  try {
    final data = await _service.fetchMahasiswaWithTimeout()
        .timeout(Duration(seconds: 5));
  } on TimeoutException {
    setState(() => _error = 'Timeout!');
  }
}''',
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: _loadingTimeout ? null : _fetchWithTimeout,
                    child: _loadingTimeout
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : const Text('Fetch dengan Timeout'),
                  ),
                  const SizedBox(height: 12),
                  if (_timeoutResult.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(8),
                      color: _timeoutResult.contains('Timeout')
                          ? Colors.red.shade100
                          : Colors.green.shade100,
                      child: Text(
                        _timeoutResult,
                        style: TextStyle(
                          color: _timeoutResult.contains('Timeout')
                              ? Colors.red
                              : Colors.green,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // CONTOH 4: Multiple futures dengan Future.wait
            _buildExampleCard(
              title: 'CONTOH 4: Multiple Futures dengan Future.wait()',
              description:
                  'Jalankan 3 futures secara bersamaan (concurrent execution)',
              code: '''Future<void> _fetchStats() async {
  try {
    final stats = await Future.wait([
      _service.fetchAllMahasiswa(),
      _service._countMahasiswaByYear(),
      _service._getTopStudents(),
    ]);
  } catch (e) {
    setState(() => _error = e.toString());
  }
}''',
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: _loadingStats ? null : _fetchStats,
                    child: _loadingStats
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : const Text('Fetch Stats (3 Futures)'),
                  ),
                  const SizedBox(height: 12),
                  if (_errorStats.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.red.shade100,
                      child: Text(
                        _errorStats,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  if (_stats.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Mahasiswa: ${_stats['totalMahasiswa']}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'By Year: ${_stats['byYear']}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Top Students: ${(_stats['topStudents'] as List).join(', ')}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Info/Penjelasan
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.blue.shade50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Penjelasan Async/Future/Await:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '• async: Menandai function yang akan mengembalikan Future',
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    '• Future<T>: Objek yang merepresentasikan nilai yang akan datang',
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    '• await: Menunggu Future selesai sebelum lanjut ke baris berikutnya',
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    '• try-catch-finally: Untuk error handling saat menggunakan await',
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    '• Future.wait(): Jalankan multiple futures secara concurrent',
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    '• timeout(): Set batasan waktu untuk Future sebelum throw error',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExampleCard({
    required String title,
    required String description,
    required String code,
    required Widget child,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.grey.shade100,
              child: Text(
                code,
                style: const TextStyle(
                  fontFamily: 'Courier',
                  fontSize: 10,
                ),
              ),
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}
