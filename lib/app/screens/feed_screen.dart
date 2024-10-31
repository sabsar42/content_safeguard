import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/content_controller.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Feed Screen'),
        elevation: 0,
      ),
      body: GetBuilder<ContentController>(
        builder: (controller) {
          final reversedTexts = controller.texts.reversed.toList();
          final reversedImages = controller.images.reversed.toList();
          final itemCount = reversedTexts.length + reversedImages.length;

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.only(bottom: 16.0),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey[200]!,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: Colors.green[400],
                                size: 20,
                              ),
                              const SizedBox(width: 8),

                              Text(

                                'Content ID: ${itemCount - index}',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 4.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green[400],
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'Approved',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    if (index < reversedTexts.length)
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          reversedTexts[index],
                          style: const TextStyle(
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                      )
                    else
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(12),
                        ),
                        child: Image.file(
                          File(reversedImages[index - reversedTexts.length].path),
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}