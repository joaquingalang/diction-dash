import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diction_dash/models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get User Data
  Future<UserModel> getUserData({required String userID}) async {
    // Get Users Collection Reference & New User Document Reference
    CollectionReference users = _firestore.collection('users');
    DocumentReference user = users.doc(userID);

    // Get User Data
    late Map<String, dynamic> userData;
    await user.get().then(
      (DocumentSnapshot doc) {
        userData = doc.data() as Map<String, dynamic>;
      },
      onError: (e) => print('Get User Data Error: $e'),
    );

    // Store User Data in User Model
    UserModel userModel = UserModel(
      userID: userID,
      username: userData['username'],
      email: userData['email'],
    );

    // Return User Model
    return userModel;
  }

  // Add New User (Username & Email)
  void addNewUser(
      {required String userID,
      required String username,
      required String email}) async {
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
    await newUser.set(userData);

    // Initializes spelling subcollection to store game data
    final spelling = newUser.collection('spelling').doc('spelling_data');
    await spelling.set({
      'level': 1,
      'exp': 0,
      'previous_max_exp': 0,
    });

    // Initializes vocabulary subcollection to store game data
    final vocabulary = newUser.collection('vocabulary').doc('vocabulary_data');
    await vocabulary.set({
      'level': 1,
      'exp': 0,
      'previous_max_exp': 0,
    });

    // Initializes grammar subcollection to store game data
    final grammar = newUser.collection('grammar').doc('grammar_data');
    await grammar.set({
      'level': 1,
      'exp': 0,
      'previous_max_exp': 0,
    });

    // Initializes comprehension subcollection to store game data
    final comprehension =
        newUser.collection('comprehension').doc('comprehension_data');
    await comprehension.set({
      'level': 1,
      'exp': 0,
      'previous_max_exp': 0,
    });
  }

// Update Username

// Update Profile Picture
}
