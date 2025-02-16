import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add New User (Username & Email)
  void addNewUser({required String userID, required String username, required String email}) {
    // Get Users Collection Reference & New User Document Reference
    CollectionReference users = _firestore.collection('users');
    DocumentReference newUser = users.doc(userID);

    // Store User Data In A Map & Set Document Content to userData
    Map<String, dynamic> userData = {
      'username': username,
      'email': email,
      'profile_picture': null,
      'fluency': null,
      'level': 1,
      'exp': 0,
      'maxExp': 0, // TODO: Change maxExp to something more appropriate
    };
    newUser.set(userData);
    // TODO: Add Minigame Level, EXP, and MaxEXP
  }

  // Update Username

  // Update Profile Picture

}