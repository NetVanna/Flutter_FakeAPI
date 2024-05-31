class ProductResModel {
  final int? id;
  final String? title;
  final dynamic? price;
  final String? description;
  final String? category;
  final String? image;
  final Rating rating;

  ProductResModel({
     this.id,
     this.title,
     this.price,
     this.description,
     this.category,
     this.image,
     required this.rating
  });

  factory ProductResModel.fromJson(Map<String, dynamic> json){
    return ProductResModel(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      description: json['description'],
      category: json['category'],
      image: json['image'],
      rating: Rating(
          rate: json['rating']['rate'],
          count: json['rating']['count']
      ),
    );
  }
}

class Rating {
  final dynamic rate;
  final int count;

  Rating({required this.rate, required this.count});
}