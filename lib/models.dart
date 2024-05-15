class BuyerBids {
  BuyerBids(
      {required this.bID,
      required this.pID,
      required this.bidValue,
      required this.title,
      required this.sellerName,
      required this.imgURL});
  int bID, pID, bidValue;
  String title, sellerName, imgURL;
}

class MySearchResultItem {
  MySearchResultItem({
    required this.pID,
    required this.title,
    required this.sellerName,
    required this.imageURL,
    this.fav,
  }) {
    fav ??= false;
  }
  int pID;
  String title, sellerName, imageURL;
  bool? fav;
}

class SneakerDetailPageItem {
  SneakerDetailPageItem(
      {required this.pID,
      required this.title,
      required this.desc,
      required this.sellerName,
      required this.imgURL,
      required this.fav});
  int pID;
  String title, desc, sellerName;
  List<String> imgURL;
  bool fav;
}

class S_NotificationItem {
  S_NotificationItem(
      {required this.uID,
      required this.category,
      required this.title,
      required this.msg,
      required this.read,
      required this.date,
      required this.time});
  int uID;
  String category, title, msg, time, date;
  bool read;
}

class KFUser {
  KFUser({
    required this.uID,
    required this.name,
    required this.email,
    required this.type,
    required this.favs,
  });
  int uID;
  String? type, name;
  String email;
  List favs;
}

class KFProduct {
  KFProduct({
    required this.pID,
    required this.sID,
    required this.name,
    required this.desc,
    required this.status,
    required this.brand,
    required this.costPrice,
    required this.color,
    required this.gender,
    required this.receiptImage,
    required this.shoeSize,
    required this.thumbnailImage,
    required this.otherImages,
    required this.category,
    required this.sellerName,
    required this.inTransit,
    this.saleDate,
    this.salePrice,
    this.bidders,
    this.listedTimeStamp,
    this.bID,
    this.buyerName,
  });

  // , , , receipt img, shoeSize, thumbnail img, otherImgs, salePrice;
  bool inTransit;
  int pID, sID, costPrice, shoeSize;
  List<dynamic> otherImages;
  String name,
      desc,
      category,
      status,
      brand,
      color,
      gender,
      thumbnailImage,
      receiptImage;

  int? bID, salePrice;
  String? saleDate, listedTimeStamp, buyerName;
  List<int>? bidders;

  // Auxillary Properties
  // fav -- depending on uID of buyers
  bool? fav;
  // sellerName -- fetch using the sID property
  String sellerName;
  // List of buyers (bIDs) who have bid on the product
}

// class KFProduct {
//   KFProduct({
//     required this.pID,
//     required this.sID,
//     this.name,
//     this.desc,
//     this.status,
//     this.brand,
//     required this.costPrice,
//     this.color,
//     this.gender,
//     this.receiptImage,
//     required this.shoeSize,
//     this.thumbnailImage,
//     required this.otherImages,
//     this.category,
//     required this.sellerName,
//     required this.inTransit,
//     this.saleDate,
//     this.salePrice,
//     this.bidders,
//     this.listedDate,
//     this.bID,
//     this.buyerName,
//   });

//   // , , , receipt img, shoeSize, thumbnail img, otherImgs, salePrice;
//   bool inTransit;
//   int pID, sID, costPrice, shoeSize;
//   List<dynamic> otherImages;
//   String? name,
//       desc,
//       category,
//       status,
//       brand,
//       color,
//       gender,
//       thumbnailImage,
//       receiptImage;

//   int? bID, salePrice;
//   String? saleDate, listedDate, buyerName;
//   List<int>? bidders;

//   // Auxillary Properties
//   // fav -- depending on uID of buyers
//   bool? fav;
//   // sellerName -- fetch using the sID property
//   String sellerName;
//   // List of buyers (bIDs) who have bid on the product
// }
