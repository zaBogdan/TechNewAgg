import 'package:uuid/uuid.dart';

class User {
  String? id;
  String username;
  String profilePicture;
  Set<String> websites;

  User({
    this.id,
    required this.username,
    required this.profilePicture,
    required this.websites,
  });

  set setUsername(String? _username) => username = _username ?? username;
  set setWebsites(List<String>? _websites) =>
      websites = Set.from(_websites ?? websites);
  addWebsite(String _website) => websites.add(_website);

  static User newEmptyUser() => User.fromJson({});

  static User fromJson(Map<String, dynamic> map) => User(
      id: map['id'] ?? const Uuid().v4(),
      username: map['username'] ?? '',
      profilePicture: map['profilePicture'] ?? 'bunny.jpg',
      websites: Set.from(map['websites'] ?? []));

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'profilePicture': profilePicture,
        'websites': websites.toList(),
      };
}
