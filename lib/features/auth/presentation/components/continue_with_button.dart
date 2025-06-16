import "package:flutter/material.dart";

class ContinueWithButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final String imagePath;
  const ContinueWithButton(
      {super.key,
      required this.onTap,
      required this.text,
      required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              Image(image: AssetImage(imagePath), height: 20),
              Text(text,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500)),
            ]),
      ),
    );
  }
}
