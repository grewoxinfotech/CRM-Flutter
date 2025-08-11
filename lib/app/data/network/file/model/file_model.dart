class FileModel {
  final String url;
  final String filename;

  FileModel({
    required this.url,
    required this.filename,
  });

  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
      url: json['url'] ?? '',
      filename: json['filename'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'filename': filename,
    };
  }
}
