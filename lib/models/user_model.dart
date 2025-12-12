// lib/models/user_model.dart
enum UserRole { client, admin }

class UserModel {
  final String uid;
  final String email;
  final UserRole role;

  UserModel({
    required this.uid,
    required this.email,
    required this.role,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String uid) {
    return UserModel(
      uid: uid,
      email: map['email'] ?? '',
      role: map['role'] == 'admin' ? UserRole.admin : UserRole.client,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'role': role == UserRole.admin ? 'admin' : 'client',
    };
  }
}
