import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diction_dash/models/user_model.dart';
import 'package:diction_dash/models/minigame_stats.dart';

class FirestoreService {

  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');

  // Get User Stream
  Stream<UserModel> getUserData({required String userID}) {
    Stream<UserModel> userData=  _users
        .doc(userID)
        .snapshots()
        .map(UserModel.fromFirestore);
    print(userData);
    return userData;
  }

  Stream<SpellingStats> getSpellingData({required String userID}) {
      return _users
          .doc(userID)
          .collection('spelling')
          .doc('spelling_data')
          .snapshots()
          .map(SpellingStats.fromFirestore);
  }

  Stream<VocabularyStats> getVocabularyData({required String userID}) {
    return _users
        .doc(userID)
        .collection('vocabulary')
        .doc('vocabulary_data')
        .snapshots()
        .map(VocabularyStats.fromFirestore);
  }

  Stream<GrammarStats> getGrammarData({required String userID}) {
    return _users
        .doc(userID)
        .collection('grammar')
        .doc('grammar_data')
        .snapshots()
        .map(GrammarStats.fromFirestore);
  }

  Stream<ComprehensionStats> getComprehensionData({required String userID}) {
    return _users
        .doc(userID)
        .collection('comprehension')
        .doc('comprehension_data')
        .snapshots()
        .map(ComprehensionStats.fromFirestore);
  }

  // Add New User (Username & Email)
  void addNewUser(
      {required String userID,
      required String username,
      required String email}) async {
    // New User Document Reference
    DocumentReference newUser = _users.doc(userID);

    // Store User Data In A Map & Set Document Content to userData
    Map<String, dynamic> userData = {
      'username': username,
      'email': email,
      'profile_picture': null,
      'fluency': null,
      'level': 1,
      'exp': 0,
      'max_exp': 100, // TODO: Change maxExp to something more appropriate
    };
    await newUser.set(userData);

    // Initializes spelling subcollection to store game data
    final spelling = newUser.collection('spelling').doc('spelling_data');
    await spelling.set({
      'level': 1,
      'exp': 0,
      'max_exp': 100,
    });

    // Initializes vocabulary subcollection to store game data
    final vocabulary = newUser.collection('vocabulary').doc('vocabulary_data');
    await vocabulary.set({
      'level': 1,
      'exp': 0,
      'max_exp': 100,
    });

    // Initializes grammar subcollection to store game data
    final grammar = newUser.collection('grammar').doc('grammar_data');
    await grammar.set({
      'level': 1,
      'exp': 0,
      'max_exp': 100,
    });

    // Initializes comprehension subcollection to store game data
    final comprehension =
        newUser.collection('comprehension').doc('comprehension_data');
    await comprehension.set({
      'level': 1,
      'exp': 0,
      'max_exp': 100,
    });
  }

  // Update Username
  Future<void> updateUsername({required String userID, required String newUsername}) async {
    // User Document Reference
    DocumentReference user = _users.doc(userID);
    await user.update({'username': newUsername});
  }

// Update Profile Picture
}
