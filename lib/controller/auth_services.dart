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
          'userId': currentUser
              .uid, // Add user ID to identify the owner of the booking
          'name': name,
          'phoneNumber': phoneNumber,
          'bookingDate': bookingDate,
          'jenisCuci': jenisCuci,
          'harga': harga,
          'timestamp': FieldValue.serverTimestamp(),
          'antrian': counter,
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
