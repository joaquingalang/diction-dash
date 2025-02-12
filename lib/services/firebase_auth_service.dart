import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  // Initialize Firebase Authentication Instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Listen To Authentication Changes
  Stream<User?> authListener() {
    return _auth.authStateChanges();
  }

  // Register w/ Email & Password
  Future<void> registerUser({required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  // Login w/ Email & Password
  Future<void> loginUser({required String email, required String password}) async {
    // TODO: Consider returning the user credential if necessary
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found with that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  // Logout
  Future<void> logout() async {
    await _auth.signOut();
  }

  // Get Current In User
  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

}