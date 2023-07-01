import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_share/Navigations/message.dart';
import 'package:food_share/Widget/reusable_button.dart';
import 'package:food_share/service/notification.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../misc/consts.dart';

class ClickPicture extends StatefulWidget {
  const ClickPicture({super.key});

  @override
  State<ClickPicture> createState() => _ClickPictureState();
}

class _ClickPictureState extends State<ClickPicture> {
  File? selectedFileName;
  XFile? file;
  pickImage(ImageSource imageFrom) async {
    try {
      file = await ImagePicker().pickImage(source: imageFrom);
      if (file == null) return;
      final temp = File(file!.path);
      setState(() {
        selectedFileName = temp;
      });
      Get.back();
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
  }

  _uploadFile() async {
    try {
      firebase_storage.UploadTask? uploadTask;
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('food')
          .child('/${file!.name}');
      uploadTask = ref.putFile(File(file!.path));
      await uploadTask.whenComplete(() => null);
      String imageUrl = await ref.getDownloadURL();
      if (kDebugMode) {
        print('Uploaded Image url$imageUrl');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Stack(alignment: Alignment.center, children: <Widget>[
          Positioned(
            top: MediaQuery.of(context).size.height * 0.05,
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(kBabyPng),
                ),
              ),
            ),
          ),
          Positioned(
            top: 60,
            left: 20,
            child: Row(
              children: [
                ResponsiveButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  image: Image.asset(kArrowPng),
                  color: kGreenColor,
                )
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.38,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: kGreyColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.445,
            child: selectedFileName != null
                ? Image.asset(
                    (kCornersPng),
                    scale: 0,
                  )
                : Image.asset(
                    kCornersPng,
                  ),
          ),
          Positioned(
            height: MediaQuery.of(context).size.height * 0.24,
            width: MediaQuery.of(context).size.width * 0.5,
            top: MediaQuery.of(context).size.height * 0.445,
            child: ClipOval(
              child: selectedFileName != null
                  ? Image.file(
                      selectedFileName!,
                      fit: BoxFit.cover,
                    )
                  : const Image(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        kVectorPng,
                      ),
                    ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.47,
            child: selectedFileName != null
                ? Image.asset(
                    kCutleryPng,
                    scale: 0,
                  )
                : Image.asset(
                    kCutleryPng,
                  ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.7,
            child: selectedFileName != null
                ? Text(
                    'Will you eat this?',
                    style: GoogleFonts.andika(
                      fontSize: 28,
                    ),
                  )
                : Text(
                    'Click your Meal',
                    style: GoogleFonts.andika(
                      fontSize: 28,
                    ),
                  ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.8,
            child: selectedFileName != null
                ? ResponsiveButton(
                    onPressed: () {
                      _uploadFile();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ShowMessage(),
                        ),
                      );
                      NotificationService().simpleNotificationShow();
                    },
                    image: Image.asset(
                      kTickPng,
                      height: 45,
                    ),
                    color: kGreenColor,
                  )
                : ResponsiveButton(
                    onPressed: () {
                      pickImage(ImageSource.camera);
                    },
                    image: Image.asset(
                      kCameraPng,
                      height: 45,
                    ),
                    color: kGreenColor,
                  ),
          ),
        ]),
      ),
    );
  }
}
