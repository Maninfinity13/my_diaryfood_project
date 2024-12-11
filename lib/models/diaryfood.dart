class Diaryfood {
  String? message;
  String? foodId;
  String? foodShopname;
  String? foodMeal;
  String? foodImage;
  String? foodPay;
  String? foodDate;
  String? foodProvince;
  String? foodLat;
  String? foodLng;
  String? memId;

  Diaryfood(
      {this.message,
      this.foodId,
      this.foodShopname,
      this.foodMeal,
      this.foodImage,
      this.foodPay,
      this.foodDate,
      this.foodProvince,
      this.foodLat,
      this.foodLng,
      this.memId});

  Diaryfood.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    foodId = json['foodId'];
    foodShopname = json['foodShopname'];
    foodMeal = json['foodMeal'];
    foodImage = json['foodImage'];
    foodPay = json['foodPay'];
    foodDate = json['foodDate'];
    foodProvince = json['foodProvince'];
    foodLat = json['foodLat'];
    foodLng = json['foodLng'];
    memId = json['memId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['foodId'] = this.foodId;
    data['foodShopname'] = this.foodShopname;
    data['foodMeal'] = this.foodMeal;
    data['foodImage'] = this.foodImage;
    data['foodPay'] = this.foodPay;
    data['foodDate'] = this.foodDate;
    data['foodProvince'] = this.foodProvince;
    data['foodLat'] = this.foodLat;
    data['foodLng'] = this.foodLng;
    data['memId'] = this.memId;
    return data;
  }
}
