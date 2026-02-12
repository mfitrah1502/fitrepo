import 'package:flutter/material.dart';
import 'package:flutter_ujicoba/models/mahasiswa.dart';
import 'package:flutter_ujicoba/services/mahasiswa_service.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();
  final MahasiswaService _mahasiswaService = MahasiswaService();

  bool _obscurePassword = true;
  bool _isLoading = false;

  // Focus nodes
  late final FocusNode _nameFocusNode;
  late final FocusNode _phoneFocusNode;
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;

  bool _showNameError = true;
  bool _showPhoneError = true;
  bool _showEmailError = true;
  bool _showPasswordError = true;

  // Async function untuk register dengan await
  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      if (_nameController.text.isEmpty ||
          _phoneController.text.isEmpty ||
          _emailController.text.isEmpty ||
          _passwordController.text.isEmpty ||
          _usernameController.text.isEmpty ||
          _addressController.text.isEmpty ||
          _nimController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Semua field wajib diisi!'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      // Set loading state
      setState(() {
        _isLoading = true;
      });

      try {
        // Buat objek Mahasiswa baru
        final newMahasiswa = Mahasiswa(
          fullname: _nameController.text,
          username: _usernameController.text,
          email: _emailController.text,
          address: _addressController.text,
          phone: _phoneController.text,
          nim: _nimController.text,
        );

        // Await untuk simulasi register ke server (3 detik)
        bool registerSuccess =
            await _mahasiswaService.registerMahasiswa(newMahasiswa);

        // Tunggu response dari server
        if (registerSuccess && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Register berhasil! Silahkan login.'),
              backgroundColor: Colors.green,
            ),
          );

          // Tunggu 2 detik kemudian kembali ke login page
          await Future.delayed(Duration(seconds: 2));
          if (mounted) {
            Navigator.pop(context);
          }
        }
      } catch (e) {
        // Error handling
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Register gagal: ${e.toString().replaceAll('Exception: ', '')}'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      } finally {
        // Set loading state kembali ke false
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Validasi form gagal!'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _nameFocusNode = FocusNode();
    _phoneFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();

    _nameFocusNode.addListener(() {
      if (_nameFocusNode.hasFocus) {
        setState(() => _showNameError = false);
      } else {
        setState(() => _showNameError = true);
        _formKey.currentState?.validate();
      }
    });

    _phoneFocusNode.addListener(() {
      if (_phoneFocusNode.hasFocus) {
        setState(() => _showPhoneError = false);
      } else {
        setState(() => _showPhoneError = true);
        _formKey.currentState?.validate();
      }
    });

    _emailFocusNode.addListener(() {
      if (_emailFocusNode.hasFocus) {
        setState(() => _showEmailError = false);
      } else {
        setState(() => _showEmailError = true);
        _formKey.currentState?.validate();
      }
    });

    _passwordFocusNode.addListener(() {
      if (_passwordFocusNode.hasFocus) {
        setState(() => _showPasswordError = false);
      } else {
        setState(() => _showPasswordError = true);
        _formKey.currentState?.validate();
      }
    });
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _phoneFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _addressController.dispose();
    _nimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register Page')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Name Field
                TextFormField(
                  focusNode: _nameFocusNode,
                  controller: _nameController,
                  enabled: !_isLoading,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                    helperText: ' ',
                  ),
                  validator: (value) {
                    if (value != null && value.isNotEmpty) return null;
                    if (!_showNameError) return null;
                    return 'Name wajib diisi';
                  },
                ),
                const SizedBox(height: 20),

                //Username Field
                TextFormField(
                  controller: _usernameController,
                  enabled: !_isLoading,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.account_box),
                    helperText: ' ',
                  ),
                  validator: (value) {
                    if (value != null && value.isNotEmpty) return null;
                    return 'Username wajib diisi';
                  },
                ),
                const SizedBox(height: 20),

                //NIM Field
                TextFormField(
                  controller: _nimController,
                  enabled: !_isLoading,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'NIM (Nomor Induk Mahasiswa)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.badge),
                    helperText: ' ',
                  ),
                  validator: (value) {
                    if (value != null && value.isNotEmpty) return null;
                    return 'NIM wajib diisi';
                  },
                ),
                const SizedBox(height: 20),

                //Phone Field
                TextFormField(
                  focusNode: _phoneFocusNode,
                  controller: _phoneController,
                  enabled: !_isLoading,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Phone',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.phone),
                    helperText: ' ',
                  ),
                  validator: (value) {
                    if (value != null && value.isNotEmpty) return null;
                    if (!_showPhoneError) return null;
                    return 'Phone wajib diisi';
                  },
                ),
                const SizedBox(height: 20),

                //Address Field
                TextFormField(
                  controller: _addressController,
                  enabled: !_isLoading,
                  keyboardType: TextInputType.text,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.home),
                    helperText: ' ',
                  ),
                  validator: (value) {
                    if (value != null && value.isNotEmpty) return null;
                    return 'Address wajib diisi';
                  },
                ),
                const SizedBox(height: 20),

                // Email Field
                TextFormField(
                  focusNode: _emailFocusNode,
                  controller: _emailController,
                  enabled: !_isLoading,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                    helperText: ' ',
                  ),
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Email tidak valid';
                      }
                      return null;
                    }
                    if (!_showEmailError) return null;
                    return 'Email wajib diisi';
                  },
                ),
                const SizedBox(height: 20),

                // Password Field
                TextFormField(
                  focusNode: _passwordFocusNode,
                  controller: _passwordController,
                  enabled: !_isLoading,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: _isLoading
                          ? null
                          : () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                    ),
                    helperText: ' ',
                  ),
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      if (value.length < 6) {
                        return 'Password minimal 6 karakter';
                      }
                      return null;
                    }
                    if (!_showPasswordError) return null;
                    return 'Password wajib diisi';
                  },
                ),
                const SizedBox(height: 24),

                // Register Button dengan loading state
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _register,
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : const Text('Register'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
