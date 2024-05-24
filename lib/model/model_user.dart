class UserModel {
  String namaUser;
  double ratingUser;
  String komenUser;
  String imgProfile;

  UserModel({
    required this.namaUser,
    required this.ratingUser,
    required this.komenUser,
    required this.imgProfile,
  });
}

List<UserModel> UserModel_List = [
  UserModel(
      namaUser: "Alex",
      ratingUser: 5.0,
      komenUser: "Sangat nyaman tempatnya dan juga pelayananya sangat baik",
      imgProfile:
          "https://img.freepik.com/free-photo/portrait-joyful-young-man-white-shirt_171337-17467.jpg?t=st=1716106767~exp=1716110367~hmac=5bc66f6f058ef73fa757cd5729987515736a1dcfd12c740fd6a728c4262af57c&w=1060"),
  UserModel(
      namaUser: "Brian Heard",
      ratingUser: 5.0,
      komenUser: "Terbaik sekali pelayanannya",
      imgProfile:
          "https://img.freepik.com/free-photo/african-american-man-wearing-white-t-shirt_273609-14647.jpg?t=st=1716106801~exp=1716110401~hmac=56464bdac205c2fa64a5ad23f9f9faadcebd767bc4eb72d8a8933f51bcda2ee3&w=1060"),
  UserModel(
      namaUser: "Charlie",
      ratingUser: 5.0,
      komenUser: "Harga terjangkau dan cepat",
      imgProfile:
          "https://img.freepik.com/free-photo/lifestyle-people-emotions-casual-concept-confident-nice-smiling-asian-woman-cross-arms-chest-confident-ready-help-listening-coworkers-taking-part-conversation_1258-59335.jpg?t=st=1716106827~exp=1716110427~hmac=125361bf1275022fd8aafcf1567c593d2bb5ac7ab3056b3cf2b3771f287f9f86&w=1060")
];
