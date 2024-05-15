import 'package:flutter/material.dart';
import 'package:kickflip/commons.dart';
import 'package:kickflip/models.dart';
import 'package:kickflip/screens/buyers/paymentOptions.dart';
import 'package:kickflip/screens/commonElements/appbar.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage(
      {super.key, required this.sneaker, required this.user});
  final KFProduct sneaker;
  final KFUser user;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final TextEditingController controller = TextEditingController();
  int currentImageIndex = 0;
  late List<String> allImages = [];

  @override
  void initState() {
    // TODO: fetch it from the servers
    super.initState();
    controller.text = '0';
    super.initState();
    allImages = [widget.sneaker.thumbnailImage];
    widget.sneaker.otherImages.forEach((imgUrl) {
      allImages.add(imgUrl);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: KickFlipAppBar(showLeading: true),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Image
              Container(
                color: Colors.grey,
                height: 300,
                child: PageView.builder(
                  onPageChanged: (value) {
                    currentImageIndex = value;
                    setState(() {});
                  },
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    currentImageIndex = index;
                    return Image.network(
                      allImages[index],
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Transform.scale(
                          scaleX: 0.5,
                          scaleY: 0.35,
                          child: Container(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.black,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Text('Error loading image');
                      },
                    );
                  },
                ),
              ),

              // Image Progress Indicator
              const SizedBox(height: 5),
              Center(
                child: Container(
                  key: UniqueKey(),
                  height: 12.5,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Color(0x2A000000),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(width: 10),
                      for (int i = 0; i < 6; i++)
                        Container(
                          height: (currentImageIndex == i) ? 8 : 6,
                          width: (currentImageIndex == i) ? 8 : 6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: (currentImageIndex == i)
                                ? Color.fromARGB(61, 0, 0, 0)
                                : Colors.white,
                          ),
                        ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
              ),

              // Details
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: MyText(
                      widget.sneaker.name,
                      size: width * 0.04,
                      weight: FontWeight.bold,
                      spacing: 1.25,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // item.fav = !item.fav;
                      // Put a Firebase function here to update wishlist on the sever as well
                      print(
                          'Favorite functionality called from the details screen');
                      setState(() {});
                    },
                    icon: Icon(
                        // (item.fav)
                        Icons.favorite_rounded,
                        // : Icons.favorite_border_rounded,
                        color:
                            // (item.fav)
                            const Color(0xFFFA1D6E)
                        // : const Color(0x739E9E9E),
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              MyText(
                'About',
                weight: FontWeight.bold,
              ),
              MyText(
                widget.sneaker.desc,
                size: 15,
                color: const Color(0xFF3B3B3B),
              ),
              const SizedBox(height: 20),
              const Divider(color: Colors.grey, thickness: 0.75),
              const SizedBox(height: 10),
              MyText(
                'Sold by:  ${widget.sneaker.sellerName}',
                size: 14,
                color: const Color.fromARGB(255, 86, 86, 86),
              ),
              Row(
                children: [
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: Image.asset('assets/all_icons/verify.png'),
                  ),
                  const SizedBox(width: 10),
                  MyText(
                    'KickFlip verified',
                    color: Colors.black,
                    size: 12,
                    spacing: 2,
                    wordSpacing: 5,
                  ),
                ],
              )
            ],
          ),
        ),
      ),

      // Bid Button
      bottomNavigationBar: GestureDetector(
        onTap: () {
          print('Bidding Button Pressed');
          showCustomPopup(context, controller);
        },
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(15, 0, 15, 20),
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width * 0.03),
                // gradient: const LinearGradient(
                //   begin: Alignment.topCenter,
                //   end: Alignment.bottomCenter,
                //   colors: [Color(0xFF35CA3A), Color.fromARGB(255, 36, 138, 38)],
                // ),
                image: const DecorationImage(
                  image: AssetImage('assets/graphics/op-03.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: 70,
              margin: const EdgeInsets.fromLTRB(15, 0, 15, 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width * 0.03),
                color: const Color(0x39000000),
              ),
              child: Center(
                child: MyText(
                  'Bid Now',
                  color: Colors.white,
                  weight: FontWeight.w500,
                  spacing: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showCustomPopup(BuildContext context, TextEditingController controller) {
    showDialog(
      context: context,
      builder: (BuildContext childContext) {
        double width = MediaQuery.of(context).size.width;
        // double height = MediaQuery.of(context).size.height;

        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyText('Like these kicks?', weight: FontWeight.w500, spacing: 1),
            ],
          ),
          content: SizedBox(
            width: width,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText('What do you wanna bid?', size: 14),
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: controller,
                    label: 'Price ₹',
                    hint: 'Bid your price',
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Reduce text field value by 500
                          if (controller.text.isNotEmpty) {
                            double value = double.parse(controller.text);
                            if (value > 0) {
                              controller.text = (value - 500).toString();
                            }
                          }
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.remove_circle_outline,
                              size: 20,
                              color: Colors.red,
                            ),
                            const SizedBox(width: 8),
                            MyText(
                              '500',
                              weight: FontWeight.bold,
                              spacing: 1,
                              size: 14,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Add text field value by 500
                          if (controller.text.isNotEmpty) {
                            double value = double.parse(controller.text);
                            controller.text = (value + 500).toString();
                          }
                        },
                        child: Row(
                          children: [
                            MyText(
                              '500',
                              weight: FontWeight.bold,
                              spacing: 1,
                              size: 14,
                              color: Colors.green,
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.add_circle_outline_rounded,
                              size: 20,
                              color: Colors.green,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Reduce text field value by 1000
                          if (controller.text.isNotEmpty) {
                            double value = double.parse(controller.text);
                            if (value > 0) {
                              controller.text = (value - 1000).toString();
                            }
                          }
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.remove_circle_outline,
                              size: 20,
                              color: Colors.red,
                            ),
                            const SizedBox(width: 8),
                            MyText(
                              '1000',
                              weight: FontWeight.bold,
                              spacing: 1,
                              size: 14,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Add text field value by 1000
                          if (controller.text.isNotEmpty) {
                            double value = double.parse(controller.text);
                            controller.text = (value + 1000).toString();
                          }
                        },
                        child: Row(
                          children: [
                            MyText(
                              '1000',
                              weight: FontWeight.bold,
                              spacing: 1,
                              size: 14,
                              color: Colors.green,
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.add_circle_outline_rounded,
                              size: 20,
                              color: Colors.green,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Icon(
                        Icons.info_outline_rounded,
                        color: Colors.blue,
                        size: 15,
                      ),

                      const SizedBox(width: 5),
                      // TODO: Should be 20% of the seller's cost price
                      MyText(
                        'We recommend you bid at least 20% of the launch price.',
                        size: 10,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: [
            // Bid button
            GestureDetector(
              onTap: () async {
                // Navigator.of(context).pop();

                Navigator.pop(context);
                // showDialog(
                //   context: context,
                //   builder: (BuildContext context) {
                //     return AlertDialog(
                //       title: Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           MyText('Bidding...'),
                //         ],
                //       ),
                //       content: Container(
                //         padding: const EdgeInsets.symmetric(
                //             horizontal: 60, vertical: 60),
                //         height: 230,
                //         width: 100,
                //         child: const CircularProgressIndicator(
                //             color: Colors.black, strokeWidth: 5),
                //       ),
                //     );
                //   },
                // );
                // Future.delayed(const Duration(seconds: 3), () {
                //   Navigator.pop(context);
                // });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyPaymentsOptionPage(
                      user: widget.user,
                      amount: double.parse('${controller.text}').toInt(),
                      product: widget.sneaker,
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: const DecorationImage(
                    image: AssetImage('assets/graphics/op-03.jpeg'),
                    fit: BoxFit.fill,
                  ),
                  // gradient: const LinearGradient(
                  //   begin: Alignment.topCenter,
                  //   end: Alignment.bottomCenter,
                  //   colors: [
                  //     Color(0xFF35CA3A),
                  //     Color(0xFF279629),
                  //   ],
                  // ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                child: MyText(
                  'Bid',
                  size: 14,
                  color: Colors.white,
                  spacing: 2,
                ),
              ),
            ),
            const SizedBox(width: 10),

            // Close button
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: MyText('Close', size: 14),
            ),
          ],
        );
      },
    );
  }
}
