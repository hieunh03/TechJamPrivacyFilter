import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_tutorial/constants.dart';
import 'package:tiktok_tutorial/views/screens/confirm_screen.dart';
import 'package:tiktok_tutorial/views/widgets/loading_animation.dart';
import 'package:video_player/video_player.dart';

class SensitiveInfoDetectScreen extends StatefulWidget {
  const SensitiveInfoDetectScreen({Key? key, required this.videoPath})
      : super(key: key);

  final String videoPath;

  @override
  State<SensitiveInfoDetectScreen> createState() =>
      _SensitiveInfoDetectScreenState();
}

class _SensitiveInfoDetectScreenState extends State<SensitiveInfoDetectScreen> {
  late VideoPlayerController vcontrollerRaw;
  late VideoPlayerController vcontrollerDetect;

  late ChewieController ccontrollerRaw;
  late ChewieController ccontrollerDetect;

  @override
  void initState() {
    super.initState();
    setState(() {
      vcontrollerRaw = VideoPlayerController.asset(rawVideoPath);
      vcontrollerDetect = VideoPlayerController.asset(detectVideoPath);

      ccontrollerRaw = ChewieController(
        videoPlayerController: vcontrollerRaw,
        autoPlay: true,
        looping: false,
      );
      ccontrollerDetect = ChewieController(
        videoPlayerController: vcontrollerDetect,
        autoPlay: true,
        looping: false,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    vcontrollerRaw.dispose();
    vcontrollerDetect.dispose();

    ccontrollerRaw.dispose();
    ccontrollerDetect.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            const Text("Your video"),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3,
              child: Chewie(controller: ccontrollerRaw),
            ),
            const SizedBox(
              height: 30,
            ),
            RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.white, fontSize: 14.0),
                children: <TextSpan>[
                  const TextSpan(
                      text: 'Warning! Sensitive information is detected. '),
                  TextSpan(
                    text: 'View here',
                    style: const TextStyle(color: Colors.red),
                    recognizer: TapGestureRecognizer()
                      ..onTap =
                          () => showDetectedListSensitiveInformation(context),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3,
              child: Chewie(controller: ccontrollerDetect),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  width: 10,
                ),
                _buildButton(
                  "Skip",
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ConfirmScreen(
                          videoPath: rawVideoPath,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                _buildButton(
                  "Blur",
                  onTap: () {
                    showLoading(context);
                    Future.delayed(const Duration(seconds: 5)).then(
                      (value) {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ConfirmScreen(
                              videoPath: blurVideoPath,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  showDetectedListSensitiveInformation(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.5,
          alignment: Alignment.center,
          child: const Material(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Information detected"),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Paper"),
                      Text(
                        "Show at: 0.46 - 3.04",
                        style: TextStyle(fontSize: 12),
                      ),
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("ID card"),
                      Text(
                        "Show at: 0.23 - 4.14",
                        style: TextStyle(fontSize: 12),
                      ),
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Paper"),
                      Text(
                        "Show at: 9.95 - 16.96",
                        style: TextStyle(fontSize: 12),
                      ),
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("ID Card"),
                      Text(
                        "Show at: 8.22 - 17.37",
                        style: TextStyle(fontSize: 12),
                      ),
                    ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("ID Card"),
                    Text(
                      "Show at: 20.92 - 26.03",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Paper"),
                    Text(
                      "Show at: 29.4 - 31.14",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
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

  List<Widget> _buildSensitiveInformation() {
    return [];
  }

  Widget _buildButton(String text, {required Function onTap}) {
    return GestureDetector(
      onTap: () => onTap.call(),
      child: Container(
        width: 150,
        height: 50,
        decoration: BoxDecoration(color: buttonColor),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
