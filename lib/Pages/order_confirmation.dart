import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gadget_express/components/cart_provider.dart';
import 'package:uuid/uuid.dart';

import 'cart.dart';


class OrderConfirmationPage extends StatelessWidget {
  final Order order;
  const OrderConfirmationPage({super.key, required this.order});
  String generateUniqueOrderId() {
    var uuid = const Uuid();
    return uuid.v4();
  }

  @override
  Widget build(BuildContext context) {
    final cartManager = context.watch<CartManager>(); // Get the cart manager from the provider

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Page'),
      ),
      body: Column(
        children: [
          const Text(
            'Congratulations! Your order has been placed.',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'Below are the details of the order:',textAlign: TextAlign.left,style: TextStyle(fontSize: 17),
          ),
          const SizedBox(height: 16),
           Text(
            'Order ID:${generateUniqueOrderId()}',
               style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartManager.cartItems.length,
              itemBuilder: (context, index) {
                final item = cartManager.cartItems[index];
                return ListTile(
                  title: Text(item['name'] ?? ''),
                  subtitle: Text('₹${(item['price'] ?? 0.0).toStringAsFixed(2)}'),
                );
              },
            ),
          ),

          ListTile(
            title: const Text('Total:'),
            subtitle: Text('₹${cartManager.calculateTotal().toStringAsFixed(2)}'),
          ),
        ],
      ),
    );
  }
}
