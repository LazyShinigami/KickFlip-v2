import 'package:flutter/material.dart';
import 'package:kickflip/constants.dart';
import 'package:kickflip/models.dart';
import 'package:kickflip/screens/buyers/productDetailPage.dart';

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
  SneakerTile({super.key, required this.sneaker, required this.user});

  KFProduct sneaker;
  KFUser user;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(sneaker.pID);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(
              sneaker: sneaker,
              user: user,
            ),
          ),
        );
      },
      child: Container(
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
              height: 185,
              decoration: BoxDecoration(
                // color: Colors.pink,
                image: DecorationImage(
                  image: NetworkImage(sneaker.thumbnailImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // title
            MyText(
              sneaker.name,
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
      ),
    );
  }
}

class GetImage extends StatefulWidget {
  const GetImage({super.key, required this.url});
  final String url;

  @override
  State<GetImage> createState() => _GetImageState();
}

class _GetImageState extends State<GetImage> {
  @override
  Widget build(BuildContext context) {
    return Image.network(
      widget.url,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        print('Error while loading an image: $error');
        return MyText('Error loading image');
      },
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
