import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthService {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future signInAnonymous() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;

      return user;
    } catch (e) {
      print(e.toString());

      return null;
    }
  }

  static Future<void> saveBookingToFirebase(
      String name,
      String phoneNumber,
      String bookingDate,
      String jenisCuci,
      double harga,
      int counter,
      String placeName,
      String placeAddress) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      try {
        await _firestore.collection("booking").add({
          'userId': currentUser.uid,
          'name': name,
          'phoneNumber': phoneNumber,
          'bookingDate': bookingDate,
          'jenisCuci': jenisCuci,
          'harga': harga,
          'timestamp': FieldValue.serverTimestamp(),
          'namaTempat': placeName,
          'alamatTempat': placeAddress
        });
        print("Booking added successfully!");
      } catch (e) {
        print("Failed to add booking: $e");
      }
    } else {
      print("No user is currently signed in.");
    }
  }

  static Future<User?> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? firebaseUser = result.user;
      return firebaseUser;
    } catch (e) {
      print('Error saat masuk: $e');
      return null;
    }
  }

  static Future<User?> signUp(
      String nama, String nomor, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? firebaseUser = result.user;

      String uid = result.user!.uid;

      await _firestore.collection('users').doc(uid).set({
        'nama_user': nama,
        'nomor_telfon': nomor,
        'email': email,
      });

      return firebaseUser;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      print('User signed out successfully');
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  static Future<void> updateAverageRating(String placeName) async {
    try {
      var snapshot = await _firestore.collection('komen_user').get();

      double totalRating = 0.0;
      int count = snapshot.docs.length;

      for (var doc in snapshot.docs) {
        totalRating += doc['rating'] as num;
      }

      double averageRating = count > 0 ? totalRating / count : 0.0;
      int totalReview = count;

      QuerySnapshot querySnapshot = await _firestore
          .collection('car_wash_places')
          .where('place_name', isEqualTo: placeName)
          .get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        await _firestore.collection('car_wash_places').doc(doc.id).update({
          'place_rating': averageRating,
          'place_review' : totalReview
        });
      }
    } catch (e) {
      print("Error updating ratings: $e");
    }
  }

  static Future<String> uploadGambar(File imageFile) async {
    String fileName = basename(imageFile.path);
    Reference ref = FirebaseStorage.instance.ref().child(fileName);
    UploadTask task = ref.putFile(imageFile);
    TaskSnapshot snapshot = await task;
    return await snapshot.ref.getDownloadURL();
  }

  Future<Stream<QuerySnapshot>> getProduct() async {
    return await _firestore.collection('car_wash_places').snapshots();
  }

  Future<Stream<QuerySnapshot>> getAntrian() async {
    // return await _firestore.collection('booking').snapshots();
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        Stream<QuerySnapshot> stream = FirebaseFirestore.instance
            .collection('booking')
            .where(user.uid)
            .snapshots();
        return stream;
      } catch (e) {
        print(e.toString());
        return Stream.error(e);
      }
    } else {
      return Stream.error('User not logged in');
    }
  }

  static Stream<User?> get firebaseUserStream => _auth.authStateChanges();
}
