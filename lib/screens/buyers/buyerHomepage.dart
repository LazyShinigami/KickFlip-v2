// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:kickflip/commons.dart';
import 'package:kickflip/constants.dart';
import 'package:kickflip/models.dart';
import 'package:kickflip/screens/commonElements/appbar.dart';
import 'package:kickflip/screens/commonElements/bottomNavBar.dart';

class BuyerHomepage extends StatefulWidget {
  const BuyerHomepage({super.key, required this.user});
  final KFUser user;
  @override
  State<BuyerHomepage> createState() => _BuyerHomepageState(user);
}

class _BuyerHomepageState extends State<BuyerHomepage> {
  _BuyerHomepageState(this.user);
  final KFUser user;
  final _searchController = TextEditingController();

  // bottom nav bar settings
  final int _selectedIndex = 0;

  List<String> shoeList = [
    'Jordan 1 Retro Low 85',
    'Nike KD 4 Galaxy (2024)',
    'Nike Blazer Mid 77 Vintage White Black',
    'Jordan 11 Retro DMP Gratitude',
    'Jordan 1 Retro High OG SP',
    'Jordan 1 Retro Low OG SP',
  ];
  List<Sneakers> sneakers = [
    Sneakers(
        pID: 12335324,
        title: 'Jordan 1 Retkgkkkhcjgcjgcjcgcjcro Low 85',
        desc: 'Jordan 1 Retro Low 85 shoeeeesss',
        status: 'listed',
        imgURL: ['Jordan 1 Retro Low 85.webp'],
        sellingPrice: 12,
        sID: 32124),
    Sneakers(
        pID: 2315253,
        title: 'Nike KD 4 Galaxy (2024)',
        desc: 'Nike KD 4 Galaxy (2024) shoeeeeessssssss',
        status: 'listed',
        imgURL: ['Jordan 1 Retro Low 85.webp'],
        sellingPrice: 12,
        sID: 21232),
    Sneakers(
        pID: 2213313,
        title: 'Nike Blazer Mid 77 Vintage White Black',
        desc: 'Nike Blazer Mid 77 Vintage White Black shoeeeeessssssss',
        status: 'listed',
        imgURL: ['Jordan 1 Retro Low 85.webp'],
        sellingPrice: 12,
        sID: 32523),
    Sneakers(
        pID: 2313432,
        title: 'Jordan 11 Retro DMP Gratitude',
        desc: 'Jordan 11 Retro DMP Gratitude shoeeeeessssssss',
        status: 'listed',
        imgURL: ['Jordan 1 Retro Low 85.webp'],
        sellingPrice: 12,
        sID: 87546),
    Sneakers(
        pID: 23121213,
        title: 'Jordan 1 Retro High OG SP',
        desc: 'Jordan 1 Retro High OG SP shoeeeeessssssss',
        status: 'listed',
        imgURL: ['Jordan 1 Retro Low 85.webp'],
        sellingPrice: 12,
        sID: 94864),
    Sneakers(
        pID: 2387913,
        title: 'Jordan 1 Retro Low OG SP',
        desc: 'Jordan 1 Retro Low OG SP shoeeeeessssssss',
        status: 'listed',
        imgURL: ['Jordan 1 Retro Low 85.webp'],
        sellingPrice: 12,
        sID: 94864),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KickFlipAppBar(),

      //
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
        child: Column(
          children: [
            // MySearchBar(),
            Container(
              // height: 350,
              decoration: BoxDecoration(
                color: ThemeColors().light,
                // border: Border.all(width: 1, color: Colors.pink),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Box Title
                  Row(
                    children: [
                      const SizedBox(width: 15),
                      MyText(
                        "Fresh Arrivals",
                        weight: FontWeight.bold,
                        color: const Color(0xEE181818),
                        spacing: 1,
                        wordSpacing: 5,
                        size: 16,
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  // Product Row
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        const SizedBox(width: 15),
                        for (int i = 0; i < sneakers.length; i++)
                          SneakerTile(sneaker: sneakers[i])
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      //
      bottomNavigationBar:
          CustomBottomNavigationBar(selectedIndex: _selectedIndex, user: user),
    );
  }
}
