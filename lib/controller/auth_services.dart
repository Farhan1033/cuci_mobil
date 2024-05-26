import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  static Stream<User?> get firebaseUserStream => _auth.authStateChanges();
}
