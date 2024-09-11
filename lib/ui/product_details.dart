import 'package:flutter/material.dart';
import 'package:assignment/models/product_model.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  ProductDetailsScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title ?? 'Product Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              product.image ?? '',
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Text(
              product.title ?? 'No Title',
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(height: 8),
            Text(
              '\₹${product.price ?? '0.00'}',
              style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.green),
            ),
            SizedBox(height: 16),
            Text(
              product.description ?? 'No Description',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(height: 16),
            Text(
              'Category: ${product.category ?? 'No Category'}',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(height: 16),
            if (product.rating != null)
              Text(
                'Rating: ${product.rating!.rate ?? 'N/A'} (${product.rating!.count ?? '0'} reviews)',
                style: Theme.of(context).textTheme.subtitle1,
              ),
          ],
        ),
      ),
    );
  }
}
