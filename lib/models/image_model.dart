class ImageModel {
  final int id;
  final String imageUrl;
  final String originalUrl;
  final String photographer;
  final String altText;

  ImageModel({
    required this.id,
    required this.imageUrl,
    required this.originalUrl,
    required this.photographer,
    required this.altText,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'] as int,
      imageUrl: json['src']['large'] as String? ?? json['src']['original'] as String? ?? '', // Fallback to original
      originalUrl: json['url'] as String? ?? '',
      photographer: json['photographer'] as String? ?? 'Unknown',
      altText: json['alt'] as String? ?? 'No description',
    );
  }

  // Convert to Map for sqflite insertion
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'originalUrl': originalUrl,
      'photographer': photographer,
      'altText': altText,
    };
  }

  // Create from Map from sqflite query
  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      id: map['id'] as int,
      imageUrl: map['imageUrl'] as String,
      originalUrl: map['originalUrl'] as String,
      photographer: map['photographer'] as String,
      altText: map['altText'] as String,
    );
  }
}
