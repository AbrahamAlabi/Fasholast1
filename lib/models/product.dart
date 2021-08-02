class ProductModel{
  static const ID = "id"; //product variables
  static const IMAGE = "image";
  static const NAME = "name";
  static const PRICE = "price";

   String id;
   String image;
   String name;
   String price;

  ProductModel({this.id, this.image, this.name, this.price});

  ProductModel.fromMap(Map<String, dynamic> data){
    id = data[ID];
    image = data[IMAGE];
    name = data[NAME];
    price = data[PRICE];//
  }

}