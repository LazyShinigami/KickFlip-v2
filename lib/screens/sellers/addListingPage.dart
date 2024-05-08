import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kickflip/commons.dart';
import 'package:kickflip/constants.dart';
import 'package:kickflip/models.dart';
import 'package:kickflip/screens/commonElements/appbar.dart';
import 'package:kickflip/screens/commonElements/bottomNavBar.dart';

class AddListingPage extends StatefulWidget {
  AddListingPage({super.key, required this.user});
  final KFUser user;

  @override
  State<AddListingPage> createState() => _AddListingPageState();
}

class _AddListingPageState extends State<AddListingPage> {
  final int _currentIndex = 1;

  // Controllers
  final _pNameController = TextEditingController();

  final _pDescController = TextEditingController();

  final _pBrandController = TextEditingController();

  final _pImages = [];

  File? _tempThumbnail;

  File? _receipt;

  Color _selectedColor = Colors.transparent;
  String _selectedColorName = '';
  String validator(String brand, String size, String color,
      String thumbnailImage, List moreImages, String receipt) {
    if (brand.isEmpty ||
        size.isEmpty ||
        color.isEmpty ||
        thumbnailImage.isEmpty ||
        moreImages.isEmpty ||
        receipt.isEmpty) {
      return '';
    }
    return '';
  }

  void openColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: MyText('Pick a color'),
          content: Container(
            child: BlockPicker(
              pickerColor: Colors.white,
              availableColors: Shaders().colorShades.keys.toList(),
              onColorChanged: (Color color) {
                print(_selectedColor);
                setState(
                  () {
                    print(_selectedColorName.isEmpty);
                    _selectedColor = color;
                    _selectedColorName = Shaders().colorShades[color]!;
                    print(_selectedColorName);
                    print(_selectedColorName.isEmpty);
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: MyText('Cancel'),
            ),
          ],
        );
      },
    );
  }

  int shoeSize = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KickFlipAppBar(showLeading: false),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              MyText(
                'Enter product details',
                weight: FontWeight.bold,
                spacing: 2,
              ),

              // Name
              const SizedBox(height: 20),
              MyTextField(
                controller: _pNameController,
                label: 'Product Name',
                hint: 'Name of the shoes',
              ),

              // Desc - text field
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ThemeColors().light,
                ),
                child: Center(
                  child: TextFormField(
                    style: const TextStyle(fontSize: 13, letterSpacing: 2),
                    controller: _pDescController,
                    maxLength: 300,
                    maxLines: 5,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      hintText: 'Tell us about the product',
                      hintStyle:
                          const TextStyle(fontSize: 12, color: Colors.grey),
                      label: MyText(
                        'Description',
                        size: 13,
                        spacing: 2,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.transparent, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.transparent, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),

              // Brand
              const SizedBox(height: 10),
              MyTextField(
                controller: _pBrandController,
                label: 'Brand',
                hint: 'Name of the brand',
              ),

              // Shoe Size
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                height: 70,
                decoration: BoxDecoration(
                  color: ThemeColors().light,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(
                        'Shoe size (UK)',
                        size: 13,
                        spacing: 2,
                      ),
                      DropdownButton<String>(
                        items: <int>[4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
                            .map((int value) {
                          return DropdownMenuItem<String>(
                            value: value.toString(),
                            child: MyText(value.toString(), size: 13),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          // Do something when the dropdown value changes
                          shoeSize = int.parse(newValue!);
                          print('Newly chosen size: $shoeSize');
                          setState(() {});
                        },
                        hint: MyText('$shoeSize', size: 13),
                        underline: const SizedBox(), // Hide the underline
                        icon: const Icon(Icons.arrow_drop_down_rounded),
                      ),
                    ],
                  ),
                ),
              ),

              // Color Picker
              const SizedBox(height: 10),
              Container(
                height: 70,
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                decoration: BoxDecoration(
                  color: ThemeColors().light,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        MyText('Shoe color', size: 13, spacing: 2),
                        if (_selectedColorName.isNotEmpty)
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0, 1),
                                  blurRadius: 2,
                                  spreadRadius: 1.25,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                width: 0.25,
                                color: Colors.black,
                              ),
                              color: _selectedColor,
                            ),
                          ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        openColorPicker();
                      },
                      icon: const Icon(Icons.color_lens_rounded),
                    ),
                  ],
                ),
              ),

              // Thumbnail
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ThemeColors().light,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText('Choose a thumbnail image', size: 13, spacing: 2),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        imagePickerTileBuilder(),
                      ],
                    ),
                  ],
                ),
              ),

              // More 5 photos
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ThemeColors().light,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText('Choose 5 more images', size: 13, spacing: 2),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        imagePickerTileBuilder(),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _currentIndex,
        accountType: 'seller',
        user: widget.user,
      ),
    );
  }

  Widget imagePickerTileBuilder() {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return Center(
              child: AlertDialog(
                title: MyText('Pick an image'),
                actions: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // getImageGallery(type: 'camera');
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Container(
        color: const Color.fromARGB(53, 158, 158, 158),
        child: SizedBox(
          height: 150,
          width: 150,
          // child: (_tempThumbnail != null)
          //     ? Image.file(
          //         _tempThumbnail!.absolute,
          //         fit: BoxFit.cover,
          //       )
          //     : const Icon(
          //         Icons.add_rounded,
          //         size: 35,
          //         color: Color(0xFF7C7C7C),
          //       ),
        ),
      ),
    );
  }
}
