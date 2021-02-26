import 'package:flutter/material.dart';

class Cart {
  String productId;
  String count;

  Cart(this.productId, this.count);

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'count': count,
      };

  Cart.fromJson(Map<String, dynamic> json)
      : productId = json['productId'],
        count = json['count'];
}
