import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kickflip/commons.dart';
import 'package:kickflip/constants.dart';
import 'package:kickflip/firebase/firestoreHandler.dart';
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
  final ScrollController _scrollController = ScrollController();

  // Controllers
  final _pNameController = TextEditingController();

  final _pDescController = TextEditingController();

  final _pBrandController = TextEditingController();

  final _pCategoryController = TextEditingController();

  final _pCostPriceController = TextEditingController();

  String gender = 'Unisex';

  List<File?> _pImages = [];

  File? _thumbnail;

  File? _receipt;

  int shoeSize = 4;

  Color _selectedColor = Colors.transparent;

  String _selectedColorName = '';

  String errorMessage = '';

  String validator() {
    if (_pNameController.text.trim().isEmpty ||
        _pDescController.text.isEmpty ||
        _pCategoryController.text.isEmpty ||
        _pCostPriceController.text.isEmpty ||
        _pBrandController.text.isEmpty ||
        _selectedColorName.isEmpty ||
        _thumbnail == null ||
        _pImages.isEmpty ||
        _receipt == null) {
      return 'All fields are mandatory';
    }
    if (_pImages.isNotEmpty && _pImages.length < 5) {
      return 'Provide 5 images of the sneaker';
    }

    try {
      int x = int.parse(_pCostPriceController.text.trim());
      return '';
    } catch (e) {
      print(e);
      return 'The cost price must be a number';
    }
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
                // print(_selectedColor);
                setState(
                  () {
                    // print(_selectedColorName.isEmpty);
                    _selectedColor = color;
                    _selectedColorName = Shaders().colorShades[color]!;
                    // print(_selectedColorName);
                    // print(_selectedColorName.isEmpty);
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

  void disposeControllers() {
    _pNameController.clear();
    _pBrandController.clear();
    _pCategoryController.clear();
    _pCostPriceController.clear();
    _pDescController.clear();
    gender = 'Unisex';
    _pImages = [];
    _thumbnail = null;
    _receipt = null;
    shoeSize = 4;
    _selectedColor = Colors.transparent;
    _selectedColorName = '';
    errorMessage = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KickFlipAppBar(showLeading: false),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              MyText(
                'Enter product details',
                weight: FontWeight.bold,
                spacing: 2,
              ),

              // Error Message
              if (errorMessage.isNotEmpty)
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: MyText(
                    errorMessage,
                    color: Colors.red,
                    size: 14,
                    weight: FontWeight.bold,
                    spacing: 1,
                  ),
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

              // Category
              const SizedBox(height: 10),
              MyTextField(
                controller: _pCategoryController,
                label: 'Category',
                hint: 'What kind of shoes are these?',
              ),

              // Gender
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
                        'Gender',
                        size: 13,
                        spacing: 2,
                      ),
                      DropdownButton<String>(
                        items: <String>['Unisex', 'Men', 'Women']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value.toString(),
                            child: MyText(value.toString(), size: 13),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          // Do something when the dropdown value changes
                          gender = newValue!;
                          setState(() {});
                        },
                        hint: MyText('$gender', size: 13),
                        underline: const SizedBox(), // Hide the underline
                        icon: const Icon(Icons.arrow_drop_down_rounded),
                      ),
                    ],
                  ),
                ),
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

              // Category
              const SizedBox(height: 10),
              MyTextField(
                controller: _pCostPriceController,
                label: 'Cost Price (number)',
                hint: 'How much did you get these for?',
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
                        imagePickerTileBuilder('thumbnail'),
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
                    Container(
                      height: 275,
                      child: GridView.count(
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 3,
                        children: [
                          for (int i = 0; i < 5; i++)
                            GestureDetector(
                              onTap: () {
                                buildPickImagePopup('otherImages');
                              },
                              child: (_pImages.isEmpty)
                                  ? Container(
                                      color: const Color.fromARGB(
                                          53, 158, 158, 158),
                                      child: const Icon(
                                        Icons.add_rounded,
                                        size: 35,
                                        color: Color(0xFF7C7C7C),
                                      ),
                                    )
                                  : (i < _pImages.length)
                                      ? Image.file(
                                          _pImages[i]!.absolute,
                                          fit: BoxFit.cover,
                                        )
                                      : Container(
                                          color: const Color.fromARGB(
                                              53, 158, 158, 158),
                                          child: const Icon(
                                            Icons.add_rounded,
                                            size: 35,
                                            color: Colors.grey,
                                          ),
                                        ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Receipt
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
                    MyText('Upload receipt', size: 13, spacing: 2),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        imagePickerTileBuilder('receipt'),
                      ],
                    ),
                  ],
                ),
              ),

              // Submit Button
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        print('Post object for listing');
                        errorMessage = validator();
                        if (errorMessage.isNotEmpty) {
                          setState(() {});
                          _scrollController.animateTo(
                            0.0,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          FirestoreService().postProductForVerification(
                            name: _pNameController.text.trim(),
                            desc: _pDescController.text,
                            brand: _pBrandController.text,
                            category: _pCategoryController.text,
                            gender: gender,
                            shoeSize: shoeSize,
                            shoeColor: _selectedColorName,
                            costPrice:
                                int.parse(_pCostPriceController.text.trim()),
                            thumbnail: _thumbnail!,
                            otherImages: _pImages,
                            receipt: _receipt!,
                            user: widget.user,
                          );
                          disposeControllers();
                          setState(() {});
                          return showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: MyText(
                                    'Your product has been sent for verification',
                                    color: Colors.green,
                                    weight: FontWeight.bold,
                                    size: 15,
                                    spacing: 0.5,
                                  ),
                                  content: SingleChildScrollView(
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          MyText(
                                            'It might take a few mins to reflect changes',
                                            size: 14,
                                            spacing: 1,
                                            color: Colors.blue,
                                          ),
                                          const SizedBox(height: 20),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              MyText(
                                                '✔',
                                                color: Colors.black,
                                                size: 100,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  actions: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: MyText(
                                        'Go Back',
                                        spacing: 1,
                                        weight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                );
                              });
                        }
                      },
                      child: Container(
                        height: 70,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/graphics/op-02.jpeg'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: MyText(
                            'Send for Verification',
                            color: Colors.white,
                            weight: FontWeight.bold,
                            spacing: 1,
                            wordSpacing: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
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

  imagePickerFunction(String type, ImageSource source) async {
    if (type == 'thumbnail' || type == 'receipt') {
      var x = await ImagePicker()
          .pickImage(source: source, requestFullMetadata: false);
      if (x != null) {
        File temp = File(x.path);
        // // print(temp.path);
        if (type == 'thumbnail') {
          _thumbnail = temp;
        } else {
          _receipt = temp;
        }
      } else {
        print('No file chosen!');
      }
    } else {
      if (source == ImageSource.gallery) {
        var x = await ImagePicker().pickMultiImage(requestFullMetadata: false);
        if (x.isNotEmpty) {
          for (var i = 0; i < x.length; i++) {
            File temp = File(x[i].path);
            _pImages.add(temp);
          }
        } else {
          print('No file chosen!');
        }
      } else {
        var x = await ImagePicker().pickImage(source: source);
        if (x != null) {
          File temp = File(x.path);
          _pImages.add(temp);
        } else {
          print('No file chosen!');
        }
      }
    }
  }

  Widget imagePickerTileBuilder(String type) {
    return GestureDetector(
      key: UniqueKey(),
      onTap: () {
        buildPickImagePopup(type);
      },
      child: Container(
        color: const Color.fromARGB(53, 158, 158, 158),
        child: SizedBox(
          height: 150,
          width: 150,
          child: (type == 'thumbnail' && _thumbnail != null)
              ? Image.file(
                  _thumbnail!.absolute,
                  fit: BoxFit.cover,
                )
              : (type == 'receipt' && _receipt != null)
                  ? Image.file(
                      _receipt!.absolute,
                      fit: BoxFit.cover,
                    )
                  : const Icon(
                      Icons.add_rounded,
                      size: 35,
                      color: Color(0xFF7C7C7C),
                    ),
        ),
      ),
    );
  }

  Future<dynamic> buildPickImagePopup(String type) {
    return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: AlertDialog(
            title: MyText('Pick an image'),
            actions: [
              // Camera Option
              GestureDetector(
                onTap: () async {
                  // print('camera option chosen');
                  await imagePickerFunction(type, ImageSource.camera);
                  Navigator.pop(context);
                  setState(() {});
                  // print(_thumbnail);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage('assets/graphics/op-02.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt_rounded, color: Colors.white),
                      MyText(
                        '  Camera',
                        size: 14,
                        spacing: 1,
                        color: Colors.white,
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              ),

              // Gallery Option
              GestureDetector(
                onTap: () async {
                  // print('gallery option chosen');
                  await imagePickerFunction(type, ImageSource.gallery);
                  // // print('-------------> $_thumbnail');
                  Navigator.pop(context);
                  setState(() {});
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage('assets/graphics/op-02.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.photo_rounded, color: Colors.white),
                      MyText(
                        '  Gallery',
                        size: 14,
                        spacing: 1,
                        color: Colors.white,
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
