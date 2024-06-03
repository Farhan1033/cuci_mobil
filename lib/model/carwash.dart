class CarWash {
  String ownerName;
  String ownerNumber;
  String placeName;
  String placeAddress;
  double? placeRating;
  String? placeReview;
  String about;
  String carWashImageUrl;
  String ownerProfileImageUrl;

  CarWash({
    required this.ownerName,
    required this.ownerNumber,
    required this.placeName,
    required this.placeAddress,
    this.placeRating,
    this.placeReview,
    required this.about,
    required this.carWashImageUrl,
    required this.ownerProfileImageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'ownerName': ownerName,
      'ownerNumber': ownerNumber,
      'placeName': placeName,
      'placeAddress': placeAddress,
      'placeRating': 0,
      'placeReview': "0",
      'about': about,
      'carWashImageUrl': carWashImageUrl,
      'ownerProfileImageUrl': ownerProfileImageUrl,
    };
  }
}
