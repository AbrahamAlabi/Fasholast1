//Models the database objects
class CartItem {
  static const ID = "id";
  static const IMAGE = "image";
  static const NAME = "name";
  static const QUANTITY = "quantity";
  static const PRICE = "cost";
  static const TOLL = "FEE";
  static const PRODUCT_ID = "productId";

  String id;
  String image;
  String name;
  int quantity;
  String productId;
  double cost;
  double toll;


  CartItem({this.productId,this.id, this.image, this.name, this.quantity, this.cost});

  CartItem.fromMap(Map<String, dynamic> data){
    id = data[ID];
    image = data[IMAGE];
    name = data[NAME];
    quantity = data[QUANTITY];
    cost = data[PRICE].toDouble();
    productId = data[PRODUCT_ID];
    toll=data[TOLL].toDouble();
  }
  Map toJson() => {
    ID: id,
    PRODUCT_ID: productId,
    IMAGE: image,
    NAME: name,
    QUANTITY: quantity,
    PRICE: toll *quantity ,
    TOLL: toll
  };

}