import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diction_dash/utils/minigames.dart';
import 'package:diction_dash/models/user_model.dart';
import 'package:diction_dash/models/minigame_stats.dart';

class FirestoreService {
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');

  // Get User Stream
  Stream<UserModel> getUserData({required String userID}) {
    Stream<UserModel> userData =
        _users.doc(userID).snapshots().map(UserModel.fromFirestore);
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
  Future<void> addNewUser(
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
      'fluency': 'BEGINNER',
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
      'performance_ratio': 0,
    });

    // Initializes vocabulary subcollection to store game data
    final vocabulary = newUser.collection('vocabulary').doc('vocabulary_data');
    await vocabulary.set({
      'level': 1,
      'exp': 0,
      'max_exp': 100,
      'performance_ratio': 0,
    });

    // Initializes grammar subcollection to store game data
    final grammar = newUser.collection('grammar').doc('grammar_data');
    await grammar.set({
      'level': 1,
      'exp': 0,
      'max_exp': 100,
      'performance_ratio': 0,
    });

    // Initializes comprehension subcollection to store game data
    final comprehension =
        newUser.collection('comprehension').doc('comprehension_data');
    await comprehension.set({
      'level': 1,
      'exp': 0,
      'max_exp': 100,
      'performance_ratio': 0,
    });
  }

  // Delete User
  Future<void> deleteUser({required String userID}) async {
    // User Document Reference
    DocumentReference user = _users.doc(userID);
    await user.delete();
  }

  // Update Username
  Future<void> updateUsername(
      {required String userID, required String newUsername}) async {
    // User Document Reference
    DocumentReference user = _users.doc(userID);
    await user.update({'username': newUsername});
  }

  // Update Fluency
  Future<void> updateFluency(
      {required String userID, required String fluency}) async {
    // User Document Reference
    DocumentReference user = _users.doc(userID);
    await user.update({'fluency': fluency});
  }

  // Check Performance Ratio Of ALl Minigames
  Future<bool> checkPerformanceRatio({required String userID}) async {

    DocumentReference userDocument = _users.doc(userID);

    // Returns false if even one of the games performance ratio is less than 9
    for (var game in Minigame.values) {
      Map<String, dynamic>? gameData;
      DocumentReference gameDocument =
      userDocument.collection(game.name).doc('${game.name}_data');

      await gameDocument.get().then(
            (DocumentSnapshot doc) {
          gameData = doc.data() as Map<String, dynamic>;
        },
        onError: (e) => print('Error Fetching ${game.name} Data'),
      );

      if (gameData!['performance_ratio'] < 9) {
        return false;
      }
    }
    // Returns true if all the game performance ratio are 9 or above
    return true;
  }

  // Reset Performance Ratio Of All Minigames
  Future<void> resetPerformanceRatio({required String userID}) async {

    DocumentReference userDocument = _users.doc(userID);

    for (var game in Minigame.values) {
      Map<String, dynamic>? gameData;
      DocumentReference gameDocument =
      userDocument.collection(game.name).doc('${game.name}_data');

      await gameDocument.get().then(
            (DocumentSnapshot doc) {
          gameData = doc.data() as Map<String, dynamic>;
        },
        onError: (e) => print('Error Fetching ${game.name} Data'),
      );

      gameData!['performance_ratio'] = 0;

      await gameDocument.update(gameData!);
    }
  }

  // Add EXP To Specific Minigame (Increments Level Once Over Max EXP Threshold)
  Future<void> addGameEXP(
      {required String userID, required Minigame game, required int exp}) async {

    DocumentReference userDocument = _users.doc(userID);

    Map<String, dynamic>? gameData;
    DocumentReference gameDocument =
    userDocument.collection(game.name).doc('${game.name}_data');

    await gameDocument.get().then(
          (DocumentSnapshot doc) {
        gameData = doc.data() as Map<String, dynamic>;
      },
      onError: (e) => print('Error Fetching ${game.name} Data'),
    );

    gameData!['exp'] += exp;
    if (gameData!['exp'] > gameData!['max_exp']) {
      gameData!['level']++;
      gameData!['exp'] = gameData!['exp'] - gameData!['max_exp'];
      gameData!['max_exp'] = gameData!['max_exp'] + (100 * gameData!['level']);
    }

    await gameDocument.update(gameData!);

    Map<String, dynamic>? userData;

    await userDocument.get().then(
          (DocumentSnapshot doc) {
        userData = doc.data() as Map<String, dynamic>;
      },
      onError: (e) => print('Error Fetching User Data: $e'),
    );

    userData!['exp'] += exp;
    if (userData!['exp'] > userData!['max_exp']) {

      // Update exp and level
      userData!['level']++;
      userData!['exp'] = userData!['exp'] - userData!['max_exp'];
      userData!['max_exp'] = userData!['max_exp'] + (100 * userData!['level']);

      // Check if eligible for fluency promotion
      String fluency = userData!['fluency'];
      bool isFluent = await checkPerformanceRatio(userID: userID);
      if (isFluent) {
        switch (fluency) {
          case 'BEGINNER':
            userData!['fluency'] = 'ELEMENTARY';
            break;
          case 'ELEMENTARY':
            userData!['fluency'] = 'INTERMEDIATE';
            break;
          case 'INTERMEDIATE':
            userData!['fluency'] = 'ADVANCED';
            break;
          case 'ADVANCED':
            userData!['fluency'] = 'EXPERT';
            break;
        }
        await resetPerformanceRatio(userID: userID);
      }

    }

    await userDocument.update(userData!);
  }

  Future<void> setGamePerformanceRatio(
      {required String userID,
        required Minigame game,
        required int score}) async {

    Map<String, dynamic>? gameData;
    DocumentReference gameDocument =
    _users.doc(userID).collection(game.name).doc('${game.name}_data');

    await gameDocument.get().then(
          (DocumentSnapshot doc) {
        gameData = doc.data() as Map<String, dynamic>;
      },
      onError: (e) => print('Error Fetching ${game.name} Data'),
    );

    gameData!['performance_ratio'] = (gameData!['performance_ratio'] + score) / 2;

    await gameDocument.update(gameData!);
  }

// Update Profile Picture
}
