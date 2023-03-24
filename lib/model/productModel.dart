// ignore_for_file: file_names

class Product{
  String? id, image, name, description, brand, category;
  int? rate, price, discount;

  Product({
    this.id, this.image, this.name, this.description, this.brand,this.category, this.rate, this.discount, this.price
  });

  Product.fromJson(Map<String, dynamic> json){
    id = json['id'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    rate = json['rate'];
    price = json['price'];
    discount = json['discount'];
    brand = json['brand'];
    category = json['category'];
  }

  Map<String, dynamic> toJson(){
    final Map< String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['name'] = this.name;
    data['description'] = this.description;
    data['rate'] = this.rate;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['brand'] = this.brand;
    data['category'] = this.category;
    return data;
  }
}