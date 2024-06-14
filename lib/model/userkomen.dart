class userKomen {
  String komenUser;
  String namaTempat;
  int ratingUser;
  String userID;
  String userEmail;
  String userName;

  userKomen(
      {required this.komenUser,
      required this.namaTempat,
      required this.ratingUser,
      required this.userID,
      required this.userEmail,
      required this.userName});

  Map<String, dynamic> toMap() {
    return {
      'komen': komenUser,
      'namaTempat': namaTempat,
      'rating': ratingUser,
      'user_id': userID,
      'userEmail': userEmail,
      'userName': userName,
    };
  }
}
