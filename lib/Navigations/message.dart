import 'package:flutter/material.dart';
import 'package:food_share/misc/consts.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowMessage extends StatelessWidget {
  const ShowMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "GOOD JOB",
          style: GoogleFonts.lilitaOne(
            fontSize: 60,
            color: kGreenColor,
            wordSpacing: 4,
            letterSpacing: 5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
