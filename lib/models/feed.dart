class FieldsLocation {
  final String title;
  final String description;
  final String url;
  final String imageUrl;

  FieldsLocation({
    required this.imageUrl,
    this.title = 'title',
    this.description = 'description',
    this.url = 'link',
  });
}

class Feed {
  final String name;
  final String url;
  final FieldsLocation fieldsLocation;

  Feed({required this.name, required this.url, required this.fieldsLocation});
}
