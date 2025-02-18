class UserModel {
  const UserModel({
    required this.userID,
    required this.username,
    required this.email,
    this.fluency,
    this.profilePicture,
    this.level = 1,
    this.exp = 0,
    this.maxExp = 100, // TODO: Update this to a more appropriate value
  });

  final String userID;
  final String username;
  final String email;
  final String? fluency;
  final String? profilePicture;
  final int level;
  final int exp;
  final int maxExp;
}
