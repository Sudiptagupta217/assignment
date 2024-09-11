import 'package:assignment/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  ProductCard({required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 1,
              color:const Color.fromARGB(255, 242, 240, 240),
              offset: Offset(0, 1),
              spreadRadius: 1
            )
          ]
        ),
        child: Row(
          children: [
            Image.network(product.image.toString(),
                width: 100, height: 100, fit: BoxFit.cover),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.title.toString()),
                  Text(
                    '\₹${product.price.toString()}',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
