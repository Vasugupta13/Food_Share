import 'package:flutter/material.dart';
import 'package:food_share/Navigations/click_picture.dart';
import 'package:food_share/misc/consts.dart';
import 'package:google_fonts/google_fonts.dart';

class LandPage extends StatelessWidget {
  const LandPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: double.maxFinite,
              color: Colors.transparent,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ClickPicture()));
              },
              style: ElevatedButton.styleFrom(
                elevation: 5,
                shadowColor: Colors.black,
                backgroundColor: kGreenColor,
                padding: const EdgeInsets.fromLTRB(20, 7, 20, 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Share your meal',
                style: GoogleFonts.andika(fontSize: 25, color: kGreyColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
