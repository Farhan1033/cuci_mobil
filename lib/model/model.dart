import 'package:flutter/material.dart';

class CarWash {
  String namaTempat;
  String alamatTempat;
  String ratingTempat;
  String imgUrl;

  CarWash({
    required this.namaTempat,
    required this.alamatTempat,
    required this.ratingTempat,
    required this.imgUrl,
  });
}

List<CarWash> CarWash_List = [
  CarWash(
      namaTempat: "Clean Snow Wash",
      alamatTempat: "Jl. Flamboyan I No.2 Rt 03/Rw 09",
      ratingTempat: "5.0 (500 reviewers)",
      imgUrl:
          "https://img.freepik.com/free-photo/man-washing-his-car-garage_1157-26046.jpg?t=st=1715603049~exp=1715606649~hmac=d9664ff542aa8e8809a9fdf36d2db054d781b2582d1046f58c642ecdc7b7dd15&w=1060"),
  CarWash(
      namaTempat: "Getwashed Car Wash",
      alamatTempat: "Jl. Jati Asih No.65 Rt 07/Rw 07",
      ratingTempat: "4.5 (400 reviewers)",
      imgUrl:
          "https://img.freepik.com/free-photo/professional-washer-blue-uniform-washing-luxury-car-with-water-gun-open-air-car-wash_496169-333.jpg?t=st=1715603154~exp=1715606754~hmac=20b433bad37a82b391775e0093acbad757eb501aecf2b436e984de779bfdd76b&w=1060"),
  CarWash(
      namaTempat: "Berkah Car Wash",
      alamatTempat: "Jl. Sentosa No.18 Rt 03/Rw 05",
      ratingTempat: "4.7 (450 reviewers)",
      imgUrl:
          "https://img.freepik.com/free-photo/beautiful-car-washing-service_23-2149212221.jpg?t=st=1715257802~exp=1715261402~hmac=8b9cb8fa19b62d42397c834277357c1f047029870044bbf7ae150377b8b3e330&w=740")
];
