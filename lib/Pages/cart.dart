
import 'package:flutter/material.dart';
import 'package:gadget_express/components/cart_products.dart';
import 'package:provider/provider.dart';

import 'package:gadget_express/components/cart_provider.dart';

class CartScreen extends StatefulWidget  {
  final CartManager? cartManager;
   const CartScreen({super.key, required this.cartManager});

  @override
  CartScreenState createState() => CartScreenState();
  }
class CartScreenState extends State<CartScreen> {
   late String _subtitleText = "0.0";

  void updateSubtitleText(double totalPrice) {
    Future.microtask(() {
      setState(() {
        _subtitleText = totalPrice.toStringAsFixed(2);
      });
    });
    print(_subtitleText);
  }
  @override
  Widget build(BuildContext context) {
    final cartManager = context.read<CartManager>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0.2,
        backgroundColor: Colors.black26,
        title: const Text("Shopping Cart"),
        actions: const [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: null,
          ),
        ],
      ),

      body: CartProducts(
        subtitleText: _subtitleText,
        onTotalPriceChanged: updateSubtitleText,
        cartManager: cartManager
      ),

      bottomNavigationBar: Container(
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: ListTile(
                title: const Text("Total"),
                subtitle: Text(_subtitleText),
              ),
            ),

            Expanded(
              child: MaterialButton(
                onPressed: () {},
                color: Colors.red,
                child: const Text(
                  "Check Out",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),

    );

  }
}

