import 'dart:io';

void main() {
  final String iconsPath = "assets/icons"; // Apne icons ka folder set karein
  final Map<String, List<String>> categories = {
    "actions": ["add", "delete", "edit", "save", "download", "upload"],
    "navigation": ["home", "back", "next", "forward", "menu", "close"],
    "user": ["profile", "settings", "logout", "account", "person"],
    "notifications": ["bell", "alert", "warning", "error", "info"],
    "files": ["folder", "file", "document", "pdf", "image"],
    "devices": ["mobile", "desktop", "laptop", "tablet", "watch"],
    "social": ["like", "heart", "share", "comment", "message"],
  };

  final Directory dir = Directory(iconsPath);
  if (!dir.existsSync()) {
    print("Error: $iconsPath directory not found!");
    return;
  }

  // Sabhi SVG icons ko process karo
  for (var file in dir.listSync()) {
    if (file is File && file.path.endsWith(".svg")) {
      String fileName = file.uri.pathSegments.last.toLowerCase();
      String newFileName = "ic_${fileName.replaceAll(' ', '_')}";
      String category = "misc";

      // Category detect karo
      for (var entry in categories.entries) {
        if (entry.value.any((keyword) => fileName.contains(keyword))) {
          category = entry.key;
          break;
        }
      }

      // Category folder banao agar nahi hai to
      String newFolderPath = "$iconsPath/$category";
      Directory(newFolderPath).createSync(recursive: true);

      // Naya path set karo
      String newFilePath = "$newFolderPath/$newFileName";
      file.renameSync(newFilePath);

      print("Moved: ${file.path} -> $newFilePath");
    }
  }

  print("✅ Icons organized successfully!");
}
