import 'dart:convert';

class FileModel {
  final String filename;
  final String url;

  FileModel({required this.filename, required this.url});

  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
      filename: json['filename'] ?? '',
      url: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'filename': filename,
    'url': url,
  };

  static List<FileModel> listFromJsonString(String jsonString) {
    final decoded = jsonDecode(jsonString);
    return List<FileModel>.from(decoded.map((x) => FileModel.fromJson(x)));
  }
}
