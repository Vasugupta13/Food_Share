import 'package:flutter/material.dart';
import '../misc/consts.dart';

class ResponsiveButton extends StatelessWidget {
  final void Function()? onPressed;
  final double? height;
  final Color? color;
  final Image image;
  const ResponsiveButton(
      {super.key,
      required this.onPressed,
      this.height = 45,
      this.color = kGreenColor,
        required this.image});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          elevation: 6,
          shadowColor: Colors.black,
          backgroundColor: color,
          padding: const EdgeInsets.all(13),
          shape: const CircleBorder()),
      child: image,
    );
  }
}
