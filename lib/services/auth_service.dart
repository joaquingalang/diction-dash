import 'package:firebase_auth/firebase_auth.dart';

// TODO: Add Delete Account
// TODO: Add Email Verification
// TODO: Add Forgot Password Functionality

class AuthService {

  // Initialize Firebase Authentication Instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get Current In User
  User? get currentUser => _auth.currentUser;

  // Get User ID
  String get currentUserID => _auth.currentUser!.uid;

  // Listen To Authentication Changes
  Stream<User?> get authListener => _auth.authStateChanges();

  // Register w/ Email & Password
  Future<UserCredential?> registerUser({required String email, required String password}) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else {
        print('FirebaseAuthException: $e');
      }
    } catch (e) {
      print('Register User Error: $e');
    }
    return null;
  }

  // Login w/ Email & Password
  Future<UserCredential?> loginUser({required String email, required String password}) async {
    // TODO: Consider returning the user credential if necessary
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found with that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else {
        print('FirebaseAuthException: $e');
      }
    } catch (e) {
      print('Login User Error: $e');
    }
    return null;
  }

  // Logout
  Future<void> logout() async {
    await _auth.signOut();
  }

  // Update Password
  Future<void> updatePassword({required String currentPassword, required String newPassword}) async {
    try {
      // Re-authenticate user
      User user = _auth.currentUser!;
      AuthCredential credential = EmailAuthProvider.credential(email: user.email!, password: currentPassword);
      await user.reauthenticateWithCredential(credential);
      // Update Password
      await user.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        // TODO: Let the user know that they inputted the wrong password
        print('Incorrect password');
      } else {
        print('FirebaseAuthException: $e');
      }
    } catch (e) {
      print('Update Password Error: $e');
    }
  }

  // Delete User Account
  Future<void> deleteUser({required String password}) async {
    try {
      // Re-authenticate user
      User user = _auth.currentUser!;
      print(user.email);
      print(password);
      AuthCredential credential = EmailAuthProvider.credential(email: user.email!, password: password);
      await user.reauthenticateWithCredential(credential);
      // Update Password
      await user.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        // TODO: Let the user know that they inputted the wrong password
        print('Incorrect password');
      } else {
        print('FirebaseAuthException: $e');
      }
    } catch (e) {
      print('Delete Password Error: $e');
    }
  }

  // Password Reset
  Future<void> passwordReset({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      print('Email sent!');
    } catch (e) {
      print('Password Reset Error: $e');
    }
  }

}