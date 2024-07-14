class UserModel {
  final String uid;
  final String email;

  UserModel({
    required this.uid,
    required this.email,
  });

  // Method to convert Firebase snapshot to Message object
  factory UserModel.fromSnapshot(snapshot) {
    return UserModel(
      email: snapshot['email'] ?? '',
      uid: snapshot['uid'] ?? '',
    );
  }

  // Method to convert Message object to JSON map for storing in Firebase
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'uid': uid,
    };
  }
}
