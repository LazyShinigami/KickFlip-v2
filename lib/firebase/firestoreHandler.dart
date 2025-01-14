import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kickflip/models.dart';
import 'package:kickflip/screens/sellers/models.dart';

class FirestoreService {
  final _usersDB = FirebaseFirestore.instance.collection('UsersDB');
  final _productsDB = FirebaseFirestore.instance.collection('ProductsDB');

  // Function to get all products posted by the current seller
  Future<List<KFProduct>> getAllProductsByThisSeller(int uID) async {
    var result = await _productsDB.where('sID', isEqualTo: uID).get();
    List<KFProduct> listings = [];

    result.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data();
      print(doc.id);
      final item = KFProduct(
        pID: int.parse(doc.id),
        sID: int.parse(data['sID']),
        name: data['name'],
        desc: data['desc'],
        status: data['status'],
        brand: data['brand'],
        color: data['color'],
        costPrice: int.parse(data['costPrice']),
        gender: data['gender'],
        otherImgs: data['otherImgs'],
        receiptImg: data['receiptImg'],
        shoeSize: int.parse(data['shoeSize']),
        thumbnailImg: data['thumbnailImg'],
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
      if (data.containsKey('listedDate')) {
        item.listedDate = data['listedDate'];
      }
      if (data.containsKey('bID')) {
        item.bID = data['bID'];
      }
      if (data.containsKey('buyerName')) {
        item.buyerName = data['buyerName'];
      }

      listings.add(item);
    });
    return listings;
  }

  // Get all products
  Future<List<KFProduct>> getAllProducts() async {
    List<String> documentIDs = [];
    List<KFProduct> allProducts = [];

    try {
      QuerySnapshot snapshot = await _productsDB.get();

      snapshot.docs.forEach((doc) {
        documentIDs.add(doc.id);
      });

      documentIDs.forEach(
        (docID) async {
          var productInfo = await _productsDB.doc(docID).get();
          Map<String, dynamic> temp = productInfo.data()!;
          KFProduct item = KFProduct(
              pID: int.parse(docID),
              sID: temp['sID'],
              name: temp['name'],
              desc: temp['desc'],
              status: temp['status'],
              brand: temp['brand'],
              costPrice: temp['costPrice'],
              color: temp['color'],
              gender: temp['gender'],
              receiptImg: temp['receiptImg'],
              shoeSize: temp['shoeSize'],
              thumbnailImg: temp['thumbnailImg'],
              otherImgs: temp['otherImgs']);

          if (temp.containsKey('bidders')) {
            item.bidders = temp['bidders'];
          }
          if (temp.containsKey('saleDate')) {
            item.saleDate = temp['saleDate'];
          }
          if (temp.containsKey('salePrice')) {
            item.salePrice = temp['salePrice'];
          }
          if (temp.containsKey('listedDate')) {
            item.listedDate = temp['listedDate'];
          }
          if (temp.containsKey('bID')) {
            item.bID = temp['bID'];
          }
          if (temp.containsKey('buyerName')) {
            item.buyerName = temp['buyerName'];
          }

          // getting seller name

          QuerySnapshot querySnapshot =
              await _usersDB.where('sID', isEqualTo: item.sID).get();
          if (querySnapshot.docs.isNotEmpty) {
            print(querySnapshot.docs);
          } else {
            print('DAFUKKK');
          }
          // print('SellerDeets: ${sName}');
          allProducts.add(item);
        },
      );
    } catch (error) {
      print('Error retrieving document IDs: $error');
    }
    return allProducts;
  }
}
