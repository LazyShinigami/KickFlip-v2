import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:kickflip/models.dart';
import 'package:kickflip/screens/sellers/models.dart';

class FirestoreService {
  final _usersDB = FirebaseFirestore.instance.collection('UsersDB');
  final _productsDB = FirebaseFirestore.instance.collection('ProductsDB');
  final _bidsDB = FirebaseFirestore.instance.collection('BidsDB');
  FirebaseStorage _storage = FirebaseStorage.instance;

  // Function to get all products posted by the current seller
  Future<List<KFProduct>> getAllProductsByThisSeller(int uID) async {
    var result = await _productsDB.where('sID', isEqualTo: uID).get();
    print('result of listings variable: ${result.docs}');
    List<KFProduct> listings = [];

    result.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data();
      print(data['otherImages']);
      final item = KFProduct(
        pID: int.parse(doc.id),
        sID: data['sID'],
        name: data['name'],
        desc: data['desc'],
        status: data['status'],
        brand: data['brand'],
        color: data['color'],
        costPrice: data['costPrice'],
        gender: data['gender'],
        otherImages: data['otherImages'],
        receiptImage: data['receiptImage'],
        shoeSize: data['shoeSize'],
        category: data['category'],
        thumbnailImage: data['thumbnailImage'],
        inTransit: data['inTransit'],
        sellerName: data['sellerName'],
      );

      if (data.containsKey('bidders')) {
        item.bidders = data['bidders'];
      }
      if (data.containsKey('saleDate')) {
        item.saleDate = data['saleDate'];
      }
      if (data.containsKey('salePrice')) {
        item.salePrice = data['salePrice'];
      }
      if (data.containsKey('listedTimeStamp')) {
        item.listedTimeStamp = data['listedTimeStamp'];
      }
      if (data.containsKey('bID')) {
        item.bID = data['bID'];
      }
      if (data.containsKey('buyerName')) {
        item.buyerName = data['buyerName'];
      }

      listings.add(item);
    });
    print('DID WE GET IT? $listings');
    return listings;
  }

  // Get all products
  Future<List<KFProduct>?> getAllProducts(KFUser user) async {
    List<String> documentIDs = [];
    List<KFProduct> allProducts = [];

    try {
      QuerySnapshot snapshot = await _productsDB.get();

      snapshot.docs.forEach((doc) {
        documentIDs.add(doc.id);
      });

      if (documentIDs.isEmpty) {
        return null;
      }

      for (var docID in documentIDs) {
        var productInfo = await _productsDB.doc(docID).get();
        Map<String, dynamic> temp = productInfo.data()!;
        KFProduct item = KFProduct(
          pID: int.parse(docID),
          sID: temp['sID'],
          category: temp['category'],
          name: temp['name'],
          desc: temp['desc'],
          status: temp['status'],
          brand: temp['brand'],
          costPrice: temp['costPrice'],
          color: temp['color'],
          gender: temp['gender'],
          receiptImage: temp['receiptImage'],
          shoeSize: temp['shoeSize'],
          thumbnailImage: temp['thumbnailImage'],
          otherImages: temp['otherImages'],
          sellerName: temp['sellerName'],
          inTransit: temp['inTransit'],
        );

        // checking for favs
        var x = await _usersDB.doc(user.email).get();
        if (x.data()!.containsKey('favs')) {
          List favs = x.data()!['favs'];
          if (favs.isNotEmpty) {
            for (var i = 0; i < favs.length; i++) {
              if (item.pID == favs[i]) {
                item.fav = true;
              } else {
                item.fav = false;
              }
            }
          }
        }

        if (temp.containsKey('bidders')) {
          item.bidders = temp['bidders'];
        }
        if (temp.containsKey('saleDate')) {
          item.saleDate = temp['saleDate'];
        }
        if (temp.containsKey('salePrice')) {
          item.salePrice = temp['salePrice'];
        }
        if (temp.containsKey('listedTimeStamp')) {
          item.listedTimeStamp = temp['listedTimeStamp'];
        }
        if (temp.containsKey('bID')) {
          item.bID = temp['bID'];
        }
        if (temp.containsKey('buyerName')) {
          item.buyerName = temp['buyerName'];
        }

        QuerySnapshot querySnapshot =
            await _usersDB.where('sID', isEqualTo: item.sID).get();
        if (querySnapshot.docs.isNotEmpty) {
          // Assuming you're extracting seller name from the query result
          String sName = '';
          if (querySnapshot.docs.isNotEmpty) {
            var data = querySnapshot.docs[0].data();
            print('----test--------> ${data.runtimeType}');
          } else {
            print('No documents found for seller with sID ${item.sID}');
          }
          print('Seller Name: $sName');
          // Assign seller name to KFProduct item
          item.sellerName = sName;
        } else {
          print('Seller with sID ${item.sID} not found');
        }

        allProducts.add(item);
      }
    } catch (error) {
      print('Error retrieving document IDs: $error');
    }
    return allProducts;
  }

  // Get all products by gender
  Future<List<KFProduct>?> getAllProductsByGender(
      String factor, KFUser user) async {
    List<String> documentIDs = [];
    List<KFProduct> allProducts = [];

    try {
      QuerySnapshot snapshot =
          await _productsDB.where('gender', isEqualTo: factor).get();

      snapshot.docs.forEach((doc) {
        documentIDs.add(doc.id);
      });

      if (documentIDs.isEmpty) {
        return null;
      }

      for (var docID in documentIDs) {
        var productInfo = await _productsDB.doc(docID).get();
        Map<String, dynamic> temp = productInfo.data()!;
        KFProduct item = KFProduct(
          pID: int.parse(docID),
          sID: temp['sID'],
          category: temp['category'],
          name: temp['name'],
          desc: temp['desc'],
          status: temp['status'],
          brand: temp['brand'],
          costPrice: temp['costPrice'],
          color: temp['color'],
          gender: temp['gender'],
          receiptImage: temp['receiptImage'],
          shoeSize: temp['shoeSize'],
          thumbnailImage: temp['thumbnailImage'],
          otherImages: temp['otherImages'],
          sellerName: temp['sellerName'],
          inTransit: temp['inTransit'],
        );
        // checking for favs
        var x = await _usersDB.doc(user.email).get();
        if (x.data()!.containsKey('favs')) {
          List favs = x.data()!['favs'];
          if (favs.isNotEmpty) {
            for (var i = 0; i < favs.length; i++) {
              if (item.pID == favs[i]) {
                item.fav = true;
              } else {
                item.fav = false;
              }
            }
          }
        }

        if (temp.containsKey('bidders')) {
          item.bidders = temp['bidders'];
        }
        if (temp.containsKey('saleDate')) {
          item.saleDate = temp['saleDate'];
        }
        if (temp.containsKey('salePrice')) {
          item.salePrice = temp['salePrice'];
        }
        if (temp.containsKey('listedTimeStamp')) {
          item.listedTimeStamp = temp['listedTimeStamp'];
        }
        if (temp.containsKey('bID')) {
          item.bID = temp['bID'];
        }
        if (temp.containsKey('buyerName')) {
          item.buyerName = temp['buyerName'];
        }

        QuerySnapshot querySnapshot =
            await _usersDB.where('sID', isEqualTo: item.sID).get();
        if (querySnapshot.docs.isNotEmpty) {
          // Assuming you're extracting seller name from the query result
          String sName = '';
          if (querySnapshot.docs.isNotEmpty) {
            var data = querySnapshot.docs[0].data();
            print('----test--------> ${data.runtimeType}');
          } else {
            print('No documents found for seller with sID ${item.sID}');
          }
          print('Seller Name: $sName');
          // Assign seller name to KFProduct item
          item.sellerName = sName;
        } else {
          print('Seller with sID ${item.sID} not found');
        }

        allProducts.add(item);
      }
    } catch (error) {
      print('Error retrieving document IDs: $error');
    }
    return allProducts;
  }

  // Get all products by searchFactor
  Future<List<KFProduct>?> searchForProduct(
      {required List<String> factors, required KFUser user}) async {
    print(factors);
    List<String> documentIDs = [];
    List<KFProduct> allProducts = [];

    for (var factor in factors) {
      try {
        QuerySnapshot brandSnapshots = await _productsDB
            .where('brand', isEqualTo: factor)
            .where('status', isEqualTo: 'listed')
            .get();
        if (brandSnapshots.docChanges.isNotEmpty) {
          brandSnapshots.docs.forEach((doc) {
            documentIDs.add(doc.id);
          });
        } else {
          print('nothing found to match $factor');
        }

        QuerySnapshot categorySnapshots = await _productsDB
            .where('category', isEqualTo: factor)
            .where('status', isEqualTo: 'listed')
            .get();
        if (categorySnapshots.docChanges.isNotEmpty) {
          categorySnapshots.docs.forEach((doc) {
            documentIDs.add(doc.id);
          });
        } else {
          print('nothing found to match $factor');
        }

        QuerySnapshot colorSnapshots = await _productsDB
            .where('color', isEqualTo: factor)
            .where('status', isEqualTo: 'listed')
            .get();
        if (colorSnapshots.docChanges.isNotEmpty) {
          colorSnapshots.docs.forEach((doc) {
            documentIDs.add(doc.id);
          });
        } else {
          print('nothing found to match $factor');
        }

        QuerySnapshot genderSnapshots = await _productsDB
            .where('gender', isEqualTo: factor)
            .where('status', isEqualTo: 'listed')
            .get();
        if (genderSnapshots.docChanges.isNotEmpty) {
          genderSnapshots.docs.forEach((doc) {
            documentIDs.add(doc.id);
          });
        } else {
          print('nothing found to match $factor');
        }

        QuerySnapshot nameSnapshots = await _productsDB
            .where('name', isEqualTo: factor)
            .where('status', isEqualTo: 'listed')
            .get();
        if (nameSnapshots.docChanges.isNotEmpty) {
          nameSnapshots.docs.forEach((doc) {
            documentIDs.add(doc.id);
          });
        } else {
          print('nothing found to match $factor');
        }

        QuerySnapshot shoeSizeSnapshots = await _productsDB
            .where('shoeSize', isEqualTo: factor)
            .where('status', isEqualTo: 'listed')
            .get();
        if (shoeSizeSnapshots.docChanges.isNotEmpty) {
          shoeSizeSnapshots.docs.forEach((doc) {
            documentIDs.add(doc.id); // here
          });
        } else {
          print('nothing found to match $factor');
        }

        if (documentIDs.isEmpty) {
          return null;
        }

        for (var docID in documentIDs) {
          var productInfo = await _productsDB.doc(docID).get();
          Map<String, dynamic> temp = productInfo.data()!;
          KFProduct item = KFProduct(
            pID: int.parse(docID),
            sID: temp['sID'],
            category: temp['category'],
            name: temp['name'],
            desc: temp['desc'],
            status: temp['status'],
            brand: temp['brand'],
            costPrice: temp['costPrice'],
            color: temp['color'],
            gender: temp['gender'],
            receiptImage: temp['receiptImage'],
            shoeSize: temp['shoeSize'],
            thumbnailImage: temp['thumbnailImage'],
            otherImages: temp['otherImages'],
            sellerName: temp['sellerName'],
            inTransit: temp['inTransit'],
          );

          if (temp.containsKey('bidders')) {
            item.bidders = temp['bidders'];
          }
          if (temp.containsKey('saleDate')) {
            item.saleDate = temp['saleDate'];
          }
          if (temp.containsKey('salePrice')) {
            item.salePrice = temp['salePrice'];
          }
          if (temp.containsKey('listedTimeStamp')) {
            item.listedTimeStamp = temp['listedTimeStamp'];
          }
          if (temp.containsKey('bID')) {
            item.bID = temp['bID'];
          }
          if (temp.containsKey('buyerName')) {
            item.buyerName = temp['buyerName'];
          }

          // checking for favs
          var x = await _usersDB.doc(user.email).get();
          if (x.data()!.containsKey('favs')) {
            List favs = x.data()!['favs'];
            if (favs.isNotEmpty) {
              for (var i = 0; i < favs.length; i++) {
                if (item.pID == favs[i]) {
                  item.fav = true;
                } else {
                  item.fav = false;
                }
              }
            }
          }

          allProducts.add(item);
        }
      } catch (error) {
        print('Error retrieving document IDs: $error');
      }
    }

    //
    return allProducts;
  }

  // Get all bids made by a buyer - return list of products and the bid price
  Future<List<BidItem>?> getAllBidsByThisBuyer({required int bID}) async {
    List<BidItem> bidItemList = [];

    try {
      QuerySnapshot snapshot = await _bidsDB
          .where('bidderUID', isEqualTo: bID)
          .where('status', isEqualTo: 'bidded')
          .get();
      for (int i = 0; i < snapshot.docs.length; i++) {
        var doc = snapshot.docs[i];
        var bid = doc.data()! as Map;
        // Getting all bid items
        BidItem bidItem = BidItem(
          pID: bid['pID'],
          bidAmount: bid['bidAmt'],
          bID: bid['bID'],
          bName: bid['bName'],
          bidderUID: bid['bidderUID'],
          sID: bid['sID'],
          status: bid['status'],
        );
        bidItemList.add(bidItem);
        // print('DOCUMENT IDS: $documentIDs');
      }

      return bidItemList;
    } catch (e) {
      return null; // no bids made
    }
  }

  Future<List<KFProduct>> getBiddedProducts(String docID) async {
    var productInfo = await _productsDB.doc(docID).get();
    List<KFProduct> productList = [];

    if (productInfo.exists) {
      print('Document $docID exists');
      // Continue processing
      Map<String, dynamic> temp = productInfo.data()!;
      KFProduct item = KFProduct(
        pID: int.parse(docID),
        sID: temp['sID'],
        category: temp['category'],
        name: temp['name'],
        desc: temp['desc'],
        status: temp['status'],
        brand: temp['brand'],
        costPrice: temp['costPrice'],
        color: temp['color'],
        gender: temp['gender'],
        receiptImage: temp['receiptImage'],
        shoeSize: temp['shoeSize'],
        thumbnailImage: temp['thumbnailImage'],
        otherImages: temp['otherImages'],
        sellerName: temp['sellerName'],
        inTransit: temp['inTransit'],
      );
      productList.add(item);
    } else {
      print('Document $docID does not exist');
    }
    return productList;
  }

  // Post Product
  postProductForVerification(
      {required String name,
      required String desc,
      required String brand,
      required String category,
      required String gender,
      required int shoeSize,
      required String shoeColor,
      required int costPrice,
      required File thumbnail,
      required List<File?> otherImages,
      required File receipt,
      required KFUser user}) async {
    // STORAGE FUNCTIONALITY
    Map<String, dynamic> images = {
      'thumbnail': '',
      'otherImages': [],
      'receipt': ''
    };
    int randomlyGenerated_pID = generateRandomNumber();
    try {
      // -------- Creating references to all the various folders --------
      // thumbnail
      Reference thumbnailRef = _storage.ref().child(
          '$randomlyGenerated_pID/thumbnail/${thumbnail.path.split('/').last}');

      // receipt
      Reference receiptRef = _storage.ref().child(
          '$randomlyGenerated_pID/receipt/${thumbnail.path.split('/').last}');

      // -------- Uploading files to Firebase Storage --------
      // thumbanil
      UploadTask thumbnailUploadTask = thumbnailRef.putFile(thumbnail);

      // other images
      for (int i = 0; i < otherImages.length; i++) {
        Reference otherImagesRef = _storage.ref().child(
            '$randomlyGenerated_pID/otherImages/${otherImages[i]!.path.split('/').last}');
        UploadTask otherImageUploadTask =
            otherImagesRef.putFile(otherImages[i]!);
      }

      // receipt
      UploadTask receiptUploadTask = receiptRef.putFile(receipt);

      // -------- Getting the download URLs of the uploaded files --------
      // thumbnail
      TaskSnapshot thumbnailSnapshot =
          await thumbnailUploadTask.whenComplete(() {});
      String thumbnailDownloadUrl =
          await thumbnailSnapshot.ref.getDownloadURL();
      images['thumbnail'] = thumbnailDownloadUrl;

      // //
      //  Reference thumbnailFolderRef = storage.ref().child('${user.uID}/thumbnail/');
      //  var result = await thumbnailFolderRef;

      // receipt
      TaskSnapshot receiptSnapshot =
          await receiptUploadTask.whenComplete(() {});
      String receiptDownloadUrl = await receiptSnapshot.ref.getDownloadURL();

      images['receipt'] = receiptDownloadUrl;

      // other images
      List<String> imageDownloadUrls = [];
      Reference folderRef =
          _storage.ref().child('$randomlyGenerated_pID/otherImages/');
      ListResult result = await folderRef.listAll();
      for (Reference ref in result.items) {
        String downloadUrl = await ref.getDownloadURL();
        imageDownloadUrls.add(downloadUrl);
      }
      images['otherImages'] = imageDownloadUrls;

      print(images['receipt']);
    } catch (e) {
      print("Error uploading file: $e");
      return null;
    }

    // FIRESTORE FUNCTIONALITY
    try {
      await _productsDB.doc('$randomlyGenerated_pID').set({
        'brand': brand,
        'category': category,
        'color': shoeColor,
        'costPrice': costPrice,
        'desc': desc,
        'gender': gender,
        'name': name,
        'otherImages': images['otherImages'],
        'receiptImage': images['receipt'],
        'thumbnailImage': images['thumbnail'],
        'sID': user.uID,
        'shoeSize': shoeSize,
        'status': 'to-be-verified',
        'listedTimeStamp': getCurrentDateTimeFormatted(),
        'inTransit': false,
        'sellerName': user.name,
        'fav': false,
      });
    } catch (e) {
      print('We have an errorrrrrr: $e');
      return null;
    }
  }

  // Remove Product
  removeProduct({required int pID}) async {
    try {
      await _productsDB.doc(pID.toString()).delete();
      var listOfBids = await _bidsDB.where('pID', isEqualTo: pID).get();
      for (var element in listOfBids.docs) {
        await _productsDB.doc(element['pID']).delete();
      }

      return true;
    } catch (e) {
      print('Error while deleting product: $e');
      return false;
    }
  }

  // Alter Favourites
  alterFavs(
      {required String email,
      required int pID,
      required List favs,
      required String operation}) async {
    try {
      // await _usersDB.doc(email).set({'favs': favs}, SetOptions(merge: true));
      // var temp = favs.remove(
      if (operation == 'remove') {
        favs.remove(pID);
        await _usersDB.doc(email).update({'favs': favs});
      } else {
        favs.add(pID);
        await _usersDB.doc(email).update({'favs': favs});
      }

      return true;
    } catch (e) {
      print(e);
    }
  }

  Future<List> getFavs(String email) async {
    // checking for favs
    var x = await _usersDB.doc(email).get();
    if (x.data()!.containsKey('favs')) {
      List favs = x.data()!['favs'];
      return favs;
    } else {
      return [];
    }
  }

  //
  // Generic Functions
  //
  String getCurrentDateTimeFormatted() {
    // Get current date and time
    DateTime now = DateTime.now();

    // Format date and time
    String formattedDate = DateFormat('dd-MM-yyyy').format(now);
    String formattedTime = DateFormat('HH:mm').format(now);

    // Return formatted date and time
    return '$formattedDate|$formattedTime';
  }

  int generateRandomNumber() {
    Random random = Random();
    return 10000000 + random.nextInt(99999999 - 10000000);
  }

  // Remove Product

  // Make bid and notify seller
  Future<String?> makeBid(
      {required KFUser user,
      required KFProduct product,
      required int amount}) async {
    try {
      int key = generateRandomNumber();
      await _bidsDB.doc('$key').set({
        'bID': key,
        'bName': user.name,
        'bidAmt': amount,
        'bidderUID': user.uID,
        'pID': product.pID,
        'sID': product.sID,
        'status': 'bidded',
      });
      return '';
    } catch (e) {
      print('Error while making bid: $e');
      return null; // bid not made
    }
  }

  Future<List<BidItem>?> getAllBidsOnThisProject({required int pID}) async {
    List<BidItem> allBiddingsOnThisProduct = [];
    List<String> documentIDs = [];

    try {
      QuerySnapshot snapshot = await _bidsDB.where('pID', isEqualTo: pID).get();

      snapshot.docs.forEach((doc) {
        documentIDs.add(doc.id);
      });

      if (documentIDs.isEmpty) {
        return null;
      }

      for (var docID in documentIDs) {
        var bidsInfo = await _bidsDB.doc(docID).get();
        Map<String, dynamic> temp = bidsInfo.data()!;
        print('temp=======================================$temp');
        BidItem item = BidItem(
          pID: temp['pID'],
          bidAmount: temp['bidAmt'],
          bID: temp['bID'],
          bName: temp['bName'],
          bidderUID: temp['bidderUID'],
          sID: temp['sID'],
          status: temp['status'],
        );
        allBiddingsOnThisProduct.add(item);
      }
      return allBiddingsOnThisProduct;
    } catch (e) {
      print('Error occured - > $e');
      return null;
    }
  }
}
