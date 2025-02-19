import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  // Constructor
  const UserModel({
    required this.username,
    required this.email,
    this.fluency,
    this.profilePicture,
    this.level = 1,
    this.exp = 0,
    this.maxExp = 100, // TODO: Update this to a more appropriate value
  });

  // Attributes
  final String? username;
  final String? email;
  final String? fluency;
  final String? profilePicture;
  final int level;
  final int exp;
  final int maxExp;

  factory UserModel.fromFirestore(DocumentSnapshot snapshot) {
    Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
    return UserModel(
      username: userData['username'] ?? 'Unknown',
      email: userData['email'] ?? 'Unknown',
      fluency: userData['fluency'],
      profilePicture: userData['profile_picture'],
      level: userData['level'],
      exp: userData['exp'],
      maxExp: userData['max_exp'],
    );
  }
}
