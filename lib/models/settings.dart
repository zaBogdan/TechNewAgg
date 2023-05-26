class Settings {
  final bool firstTime;

  Settings({required this.firstTime});

  static Settings fromJson(Map<String, dynamic> json) => Settings(
        firstTime: json['firstTime'] ?? false,
      );

  static Settings getDefaultSettings() => Settings(firstTime: true);

  Map<String, dynamic> toJson() => {
        'firstTime': firstTime,
      };
}
