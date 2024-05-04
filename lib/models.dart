class Sneakers {
  Sneakers(
      {required this.pID,
      required this.title,
      required this.desc,
      this.bids,
      required this.status,
      required this.imgURL,
      this.sellingPrice,
      this.bID,
      required this.sID});
  String title, desc, status;
  int pID, sID;
  List<String> imgURL;
  int? sellingPrice, bID;
  List<int>? bids;
}

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

class OrderItem {
  OrderItem(
      {required this.pID,
      required this.name,
      required this.imageURL,
      required this.sellerName,
      required this.saleDate});
  String name, imageURL, sellerName, saleDate;
  int pID;
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
    // required this.pwd,
    required this.type,
  });
  int uID;
  String? type, name, pwd;
  String email;
}
