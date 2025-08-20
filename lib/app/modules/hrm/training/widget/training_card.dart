import 'package:flutter/material.dart';

import '../../../../data/network/hrm/training/training_model.dart';

class TrainingCard extends StatelessWidget {
  final TrainingData training;

  const TrainingCard({Key? key, required this.training}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            // Icon Placeholder
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                width: 60,
                height: 60,
                color: Colors.purple[100],
                child: Icon(
                  Icons.school, // training icon
                  color: Colors.purple[700],
                  size: 32,
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Training Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Training Title
                  Text(
                    training.title ?? 'Untitled Training',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),

                  // Category
                  if (training.category != null &&
                      training.category!.isNotEmpty)
                    Text(
                      training.category!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.blueGrey,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                  const SizedBox(height: 4),

                  // Links (only show first one for preview)
                  if (training.links != null &&
                      training.links!.urls != null &&
                      training.links!.urls!.isNotEmpty)
                    Text(
                      'Link: ${training.links!.urls!.first}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
