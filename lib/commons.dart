import 'package:flutter/material.dart';
import 'package:kickflip/constants.dart';
import 'package:kickflip/models.dart';

class MyText extends StatelessWidget {
  String content;
  Color? color;
  double? size;
  double? spacing, wordSpacing;
  List<Shadow>? shadowList;
  FontWeight? weight;
  TextOverflow? overflow;
  int? maxLines;

  MyText(this.content,
      {super.key,
      this.color,
      this.size,
      this.spacing,
      this.wordSpacing,
      this.shadowList,
      this.weight,
      this.overflow,
      this.maxLines}) {
    color ??= Colors.black;
    size ??= 16;
    spacing ??= 0;
    wordSpacing ??= 0;
    shadowList ??= [];
    weight ??= FontWeight.normal;
    overflow ??= TextOverflow.clip;
    maxLines ??= null;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      maxLines: maxLines,
      style: TextStyle(
        color: color,
        fontSize: size,
        letterSpacing: spacing,
        wordSpacing: wordSpacing,
        shadows: shadowList,
        fontWeight: weight,
        overflow: overflow,
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  MyTextField({
    required this.controller,
    required this.label,
    super.key,
    this.obscureText,
    this.hint,
    this.maxLength,
    this.maxLines,
    this.height,
  }) {
    obscureText ??= false;
    maxLines ??= 1;
  }
  TextEditingController controller;
  String label;
  String? hint;
  bool? obscureText = false;
  int? maxLength, maxLines, height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (height != null) ? height!.toDouble() : 70,
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
      decoration: BoxDecoration(
        color: ThemeColors().light,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: TextField(
          maxLength: (maxLength != null) ? maxLength : null,
          maxLines: (maxLines != null) ? maxLines : null,
          controller: controller,
          style: const TextStyle(
              color: Colors.black, fontSize: 14, letterSpacing: 2),
          obscureText: obscureText!,

          // decoration
          decoration: InputDecoration(
            hintText: ' $hint',
            hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
            label: MyText(
              label,
              size: 13,
              spacing: 2,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}

class SneakerTile extends StatelessWidget {
  SneakerTile({super.key, required this.sneaker});

  Sneakers sneaker;

  // Sneakers(
  //   pID: 12335324,
  //   title: 'Jordan 1 Retro Low 85',
  //   desc: 'Jordan 1 Retro Low 85 shoeeeesss',
  //   status: 'listed',
  //   imgURL: ['Jordan 1 Retro Low 85.webp'],
  //   sellingPrice: 12,
  //   sID: 32124,
  // )

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 272.5,
      constraints: const BoxConstraints(maxWidth: 272.5, minHeight: 300),
      margin: const EdgeInsets.fromLTRB(0, 0, 25, 20),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        // border: Border.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(106, 158, 158, 158),
            offset: Offset(10, 10),
            blurRadius: 7.5,
            spreadRadius: 2.5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // image
          Container(
            height: 200, width: 272.5 - 32,
            // child: Image.asset(sneaker.imgURL[0]),
            child: Placeholder(),
          ),
          const SizedBox(height: 10),

          // title
          MyText(
            sneaker.title,
            size: 11,
            weight: FontWeight.bold,
            spacing: 0.25,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 3.5),

          // desc
          MyText(
            sneaker.desc,
            size: 11,
            spacing: 0.1,
            maxLines: 2,
            color: const Color.fromARGB(255, 111, 111, 111),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class CommonFunctions {
  double maxSize(double a, double b) {
    return (a < b) ? b : a;
  }

  double minSize(double a, double b) {
    return (a > b) ? b : a;
  }
}
