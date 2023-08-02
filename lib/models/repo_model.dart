class RepoModel {
  final String name, description, ownerName, avatar;
  final int stars;

  RepoModel(
      {required this.name,
      required this.description,
      required this.ownerName,
      required this.avatar,
      required this.stars});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'login': ownerName,
      'avatar_url': avatar,
      'stargazers_count': stars
    };
  }

  factory RepoModel.fromJson(Map<String, dynamic> json, bool isDb) {
    final owner = isDb ? json : json['owner'] ?? '';
    return RepoModel(
        name: json['name'] ?? '',
        description: json['description'] ?? '',
        ownerName: owner['login'] ?? '',
        avatar: owner['avatar_url'] ?? '',
        stars: json['stargazers_count'] ?? 0);
  }
}
