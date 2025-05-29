import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/all/crm/deal/model/deal_model.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FileCard extends StatelessWidget {
  final FileModel file;

  const FileCard({Key? key, required this.file}) : super(key: key);

  void _launchURL(BuildContext context) async {
    final url = file.url ?? '';
    if (url.isNotEmpty && await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Cannot open file URL')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return CrmCard(
      child: ListTile(
        leading: const Icon(Icons.insert_drive_file, color: Colors.blue),
        title: Text(file.filename ?? 'No file name'),
        subtitle: Text(
          file.url ?? 'No file URL',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.open_in_new, color: Colors.blue),
          onPressed: () => _launchURL(context),
          tooltip: 'Open File',
        ),
      ),
    );
  }
}
