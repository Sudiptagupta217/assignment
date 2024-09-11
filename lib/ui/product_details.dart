import 'package:assignment/local_data/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:assignment/models/product_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;
  ProductDetailsScreen({required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  Future<void> _checkFavoriteStatus() async {
    final favorites = await DatabaseHelper().getFavorites();
    setState(() {
      _isFavorite = favorites.contains(widget.product.id.toString());
    });
  }

  Future<void> _toggleFavorite() async {
    if (_isFavorite) {
      await DatabaseHelper().removeFavorite(widget.product.id.toString());
    } else {
      await DatabaseHelper().insertFavorite(widget.product.id.toString());
    }
    _checkFavoriteStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title ?? 'Product Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    Image.network(
                      widget.product.image ?? '',
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      right: 10,
                      bottom: 10,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(115, 181, 166, 166),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          color: Color.fromARGB(255, 216, 19, 9),
                          icon: Icon(
                            _isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: _isFavorite
                                ? Colors.red
                                : const Color.fromARGB(255, 158, 158, 158),
                            size: 40,
                          ),
                          onPressed: _toggleFavorite,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              widget.product.title ?? 'No Title',
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(height: 8),
            if (widget.product.rating != null)
              Row(
                children: [
                  RatingBar.builder(
                    initialRating: widget.product.rating!.rate ?? 0.0,
                    minRating: 1,
                    itemSize: 25.0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  Text(
                    '${widget.product.rating!.rate ?? 'N/A'} (${widget.product.rating!.count ?? '0'} reviews)',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            SizedBox(
              height: 10,
            ),
            Text(
              '\₹${widget.product.price ?? '0.00'}',
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(color: Colors.green),
            ),
            SizedBox(height: 16),
            Text(
              widget.product.description ?? 'No Description',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
