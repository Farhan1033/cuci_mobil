class history {
  final String antrian;
  final String bookingDate;
  final String harga;
  final String jenisCuci;
  final String name;
  final String phoneNumber;

  history(
      {required this.antrian,
      required this.bookingDate,
      required this.harga,
      required this.jenisCuci,
      required this.name,
      required this.phoneNumber});

  Map<String, dynamic> toMap() {
    return {
      'antrian': antrian,
      'bookingDate': bookingDate,
      'harga': harga,
      'jenisCuci': jenisCuci,
      'name': name,
      'phoneNumber': phoneNumber,
    };
  }
}
