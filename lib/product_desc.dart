import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoe_shop/cart_provider.dart';

class ProductDesc extends StatefulWidget {
  final Map<String, Object> product;
  const ProductDesc({super.key, required this.product});

  @override
  State<ProductDesc> createState() => _ProductDescState();
}

class _ProductDescState extends State<ProductDesc> {
  int selectedSize = 0;

  onTap() {
    if (selectedSize != 0) {
      Provider.of<CartProvider>(context, listen: false).addProduct({
        'id': widget.product['id'],
        'title': widget.product['title'],
        'price': widget.product['price'],
        'size': selectedSize,
        'company': widget.product['company'],
        'image': widget.product['image'],
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('product added to cart'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a size'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: Column(
        children: [
          Text(
            widget.product['title'] as String,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset(widget.product['image'] as String),
          ),
          Spacer(flex: 2),
          Container(
            height: 300,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("\$${widget.product['price']}",
                    style: Theme.of(context).textTheme.titleLarge),
                SizedBox(height: 8),
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: (widget.product['size'] as List<int>).length,
                      itemBuilder: (context, index) {
                        final size =
                            (widget.product['size'] as List<int>)[index];

                        return Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedSize = size;
                              });
                            },
                            child: Chip(
                                label: Text(
                                  size.toString(),
                                ),
                                backgroundColor: selectedSize == size
                                    ? Colors.grey.shade400
                                    : null),
                          ),
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ElevatedButton(
                      onPressed: onTap,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          minimumSize: Size(double.infinity, 50)),
                      child: Text(
                        "Add to Cart",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
