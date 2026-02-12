class Mahasiswa {
  String fullname;
  String username;
  String email;
  String address;
  String phone;
  String nim;
  Mahasiswa({
    required this.fullname,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.nim,
  });
  factory Mahasiswa.fromJson(Map<String, dynamic> json) => Mahasiswa(
        fullname: json['fullname'],
        username: json['username'],
        email: json['email'],
        address: json['address'],
        phone: json['phone'],
        nim: json['nim'],
      );
  Map<String, dynamic> toJson() => {
        'fullname': fullname,
        'username': username,
        'email': email,
        'address': address,
        'phone': phone,
        'nim': nim,
      };
      
  Map<String, dynamic> toMap() {
    return {
      'fullname': fullname,
      'username': username,
      'email': email,
      'address': address,
      'phone': phone,
      'nim': nim,
    };
}
}