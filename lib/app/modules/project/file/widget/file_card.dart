import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FileCard extends StatelessWidget {
  final String? id;
  final String? url;
  final String? name;
  final String? role;
  final String? description;
  final String? file;
  final String? clientId;
  final String? createdBy;
  final String? updatedBy;
  final String? createdAt;
  final String? updatedAt;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onDelete;
  final GestureTapCallback? onEdit;

  const FileCard({
    super.key,
    this.url,
    this.id,
    this.name,
    this.role,
    this.description,
    this.file,
    this.clientId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.onTap,
    this.onDelete,
    this.onEdit,
  });

  String _getFileExtension(String filename) {
    return filename.split('.').last.toLowerCase();
  }

  bool _isImageFile(String extension) {
    return ['jpg', 'jpeg', 'png', 'gif'].contains(extension.toLowerCase());
  }

  void _showImagePreview(BuildContext context) {
    if (url == null) return;
    
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Stack(
          children: [
            InteractiveViewer(
              child: Image.network(
                url!,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Center(
                  child: Text('Failed to load image'),
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getFileIcon(String extension) {
    switch (extension) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'doc':
      case 'docx':
        return Icons.description;
      case 'xls':
      case 'xlsx':
        return Icons.table_chart;
      case 'ppt':
      case 'pptx':
        return Icons.slideshow;
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
        return Icons.image;
      default:
        return Icons.insert_drive_file;
    }
  }

  Color _getFileColor(String extension) {
    switch (extension) {
      case 'pdf':
        return Colors.red;
      case 'doc':
      case 'docx':
        return Colors.blue;
      case 'xls':
      case 'xlsx':
        return Colors.green;
      case 'ppt':
      case 'pptx':
        return Colors.orange;
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    Color textPrimary = Get.theme.colorScheme.onPrimary;
    Color textSecondary = Get.theme.colorScheme.onSecondary;
    double cardHeight = 100;

    // Get file extension and icon
    final extension = name != null ? _getFileExtension(name!) : '';
    final fileIcon = _getFileIcon(extension);
    final fileColor = _getFileColor(extension);
    final isImage = _isImageFile(extension);

    return GestureDetector(
      onTap: isImage ? () => _showImagePreview(context) : null,
      child: CrmCard(
        height: cardHeight,
        borderRadius: BorderRadius.circular(AppRadius.large),
        child: Row(
          children: [
            // File Preview/Icon Container
            Container(
              height: cardHeight,
              width: cardHeight,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: fileColor.withOpacity(0.1),
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(AppRadius.large),
                ),
              ),
              child: url != null && isImage
                  ? ClipRRect(
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(AppRadius.large),
                      ),
                      child: Image.network(
                        url!,
                        fit: BoxFit.cover,
                        width: cardHeight,
                        height: cardHeight,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          fileIcon,
                          size: 32,
                          color: fileColor,
                        ),
                      ),
                    )
                  : Icon(
                      fileIcon,
                      size: 32,
                      color: fileColor,
                    ),
            ),
            // File Details Container
            Expanded(
              child: Container(
                padding: EdgeInsets.all(AppPadding.medium),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // File Name
                    Text(
                      name ?? 'Unnamed File',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: textPrimary,
                      ),
                    ),
                    SizedBox(height: 8),
                    // File Type and Size
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: fileColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(AppRadius.small),
                          ),
                          child: Text(
                            extension.toUpperCase(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: fileColor,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          role ?? 'File',
                          style: TextStyle(
                            fontSize: 12,
                            color: textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Action Buttons
            Container(
              padding: EdgeInsets.symmetric(horizontal: AppPadding.small),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (onEdit != null)
                    CrmIc(
                      iconPath: ICRes.edit,
                      color: ColorRes.success,
                      onTap: onEdit,
                    ),
                  SizedBox(width: 8),
                  if (onDelete != null)
                    CrmIc(
                      iconPath: ICRes.delete,
                      color: ColorRes.error,
                      onTap: onDelete,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
