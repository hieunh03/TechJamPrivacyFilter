import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_tutorial/constants.dart';
import 'package:tiktok_tutorial/views/screens/confirm_screen.dart';
import 'package:tiktok_tutorial/views/screens/sensitive_info_detect/sensitive_info_detect_screen.dart';
import 'package:tiktok_tutorial/views/widgets/loading_animation.dart';

class AddVideoScreen extends StatelessWidget {
  const AddVideoScreen({Key? key}) : super(key: key);

  Future<String?> pickVideo(ImageSource src, BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: src);
    return video?.path;
  }

  showLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return Center(
          child: Container(
            width: 52,
            height: 30,
            alignment: Alignment.center,
            child: const LoadingAnimation(),
          ),
        );
      },
    );
  }

  Future<String?> showOptionsDialog(BuildContext context) {
    return showDialog<String?>(
      context: context,
      builder: (context) => SimpleDialog(
        children: [
          SimpleDialogOption(
            onPressed: () async {
              final videoPath = await pickVideo(ImageSource.gallery, context);
              Navigator.of(context).pop(videoPath);
            },
            child: const Row(
              children: [
                Icon(Icons.image),
                Padding(
                  padding: EdgeInsets.all(7.0),
                  child: Text(
                    'Gallery',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () async {
              final videoPath = await pickVideo(ImageSource.camera, context);
              Navigator.of(context).pop(videoPath);
            },
            child: const Row(
              children: [
                Icon(Icons.camera_alt),
                Padding(
                  padding: EdgeInsets.all(7.0),
                  child: Text(
                    'Camera',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.of(context).pop(),
            child: const Row(
              children: [
                Icon(Icons.cancel),
                Padding(
                  padding: EdgeInsets.all(7.0),
                  child: Text(
                    'Cancel',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () async {
            final videoPath = await showOptionsDialog(context);
            if (videoPath == null) return;
            showLoading(context);
            Future.delayed(const Duration(seconds: 5)).then((value) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      SensitiveInfoDetectScreen(
                        videoPath: videoPath,
                      ),
                ),
              );
            });
          },
          child: Container(
            width: 190,
            height: 50,
            decoration: BoxDecoration(color: buttonColor),
            child: const Center(
              child: Text(
                'Add Video',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
