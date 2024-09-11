import 'package:assignment/ui/product_details.dart';
import 'package:assignment/ui/state_management/product_provider.dart';
import 'package:assignment/ui/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Fetch initial products
    Provider.of<ProductProvider>(context, listen: false).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Product List'),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: ProductSearchDelegate());
              },
            ),
          ],
        ),
        body: Consumer<ProductProvider>(
          builder: (context, productProvider, child) {
            if (productProvider.isLoading && productProvider.products.isEmpty) {
              return Center(child: CircularProgressIndicator());
            }

            return NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (!productProvider.isLoading &&
                    productProvider.hasMore &&
                    scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                  productProvider.fetchProducts();
                }
                return false;
              },
              child: ListView.builder(
                itemCount: productProvider.products.length,
                itemBuilder: (context, index) {
                  final product = productProvider.products[index];
                  return ProductCard(
                    product: product,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailsScreen(product: product),
                          ));
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class ProductSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final results = productProvider.products
        .where((product) =>
            product.title!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final product = results[index];
        return ListTile(
          title: Text(product.title!),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailsScreen(product: product),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
