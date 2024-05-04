import 'package:flutter/material.dart';
import 'package:kickflip/commons.dart';
import 'package:kickflip/models.dart';
import 'package:kickflip/screens/commonElements/appbar.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key, required this.pID});
  final int pID;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final TextEditingController controller = TextEditingController();

  // Dummy Data
  late SneakerDetailPageItem item;
  @override
  void initState() {
    // TODO: fetch it from the servers
    super.initState();
    controller.text = '0';
    item = SneakerDetailPageItem(
        pID: widget.pID,
        title: "Jordan New Very Lengthy Name Just For Testing Purposes",
        desc:
            "des weuofh wrgwr gr0g rwg wrg w f-se fs fr geth s fs gr gsrg rgrgg s h sth s gsr vw9g 4 4w049g  9 w w fwf w rvjrv dirovj drv djibdg bdb  gbghb09dgj bi dfj0df  egrc.",
        sellerName: "Seller 123",
        imgURL: ['a.png', 'b.jpg', 'c.jpeg', 'd.jpg', 'e.png'],
        fav: false);
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
              // Image Carousel
              Container(
                height: height * 0.35,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(67, 158, 158, 158),
                  border: Border.all(width: 1, color: Colors.grey),
                ),
              ),

              // Details
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: MyText(
                      item.title,
                      size: width * 0.04,
                      weight: FontWeight.bold,
                      spacing: 1.25,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      item.fav = !item.fav;
                      // Put a Firebase function here to update wishlist on the sever as well
                      print(
                          'Favorite functionality called from the details screen');
                      setState(() {});
                    },
                    icon: Icon(
                      (item.fav)
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      color: (item.fav)
                          ? const Color(0xFFFA1D6E)
                          : const Color(0x739E9E9E),
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
                item.desc,
                size: 15,
                color: const Color(0xFF3B3B3B),
              ),
              const SizedBox(height: 20),
              const Divider(color: Colors.grey, thickness: 0.75),
              const SizedBox(height: 10),
              MyText(
                'Sold by:  ${item.sellerName}',
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
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyText('Bidding...'),
                        ],
                      ),
                      content: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 60, vertical: 60),
                        height: 230,
                        width: 100,
                        child: const CircularProgressIndicator(
                            color: Colors.black, strokeWidth: 5),
                      ),
                    );
                  },
                );
                Future.delayed(const Duration(seconds: 3), () {
                  Navigator.pop(context);
                });
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
