import 'package:flutter/material.dart';
import 'package:gadget_express/components/cart_products.dart';
import 'package:provider/provider.dart';
import 'package:gadget_express/components/cart_provider.dart';
import 'package:uuid/uuid.dart';
import 'order_confirmation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  final String orderId;
  final List<Map<String, dynamic>> items; // List of ordered items
  final double total;
  final DateTime orderDate;

  Order({
    required this.orderId,
    required this.items,
    required this.total,
    required this.orderDate,
  });
}
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
   void createOrder(BuildContext context) {
     String orderId = generateUniqueOrderId();
     List<Map<String, dynamic>> items = widget.cartManager?.cartItems ?? [];
     double total = double.parse(_subtitleText);
     DateTime orderDate = DateTime.now(); // You can customize this as needed

     Order order = Order(
       orderId: orderId,
       items: items,
       total: total,
       orderDate: orderDate,
     );

     // Add the order to Firestore
     addOrderToFirestore(order);

     // Now, you can navigate to the order confirmation page
     final cartManager = widget.cartManager;
     if (cartManager != null &&widget.cartManager!.cartItems.isNotEmpty) {
       Navigator.of(context).push(
         MaterialPageRoute(
           builder: (context) =>  OrderConfirmationPage(order: order),
         ),
       );
     } else {
       // Show a message or dialog indicating that the cart is empty.
       showDialog(
         context: context,
         builder: (BuildContext context) {
           return AlertDialog(
             title: const Text('Cart is Empty'),
             content: const Text('Please add items to your cart before proceeding to checkout.'),
             actions: <Widget>[
               TextButton(
                 child: const Text('OK'),
                 onPressed: () {
                   Navigator.of(context).pop(); // Close the dialog
                 },
               ),
             ],
           );
         },
       );
     }
   }
   String generateUniqueOrderId() {
     var uuid = Uuid();
     return uuid.v4();
   }
  /* void navigateToOrderConfirmation(BuildContext context) {
     final cartManager = widget.cartManager;
     if (cartManager != null &&widget.cartManager!.cartItems.isNotEmpty) {
       Navigator.of(context).push(
         MaterialPageRoute(
           builder: (context) =>  OrderConfirmationPage(order: order),
         ),
       );
     } else {
       // Show a message or dialog indicating that the cart is empty.
       showDialog(
         context: context,
         builder: (BuildContext context) {
           return AlertDialog(
             title: const Text('Cart is Empty'),
             content: const Text('Please add items to your cart before proceeding to checkout.'),
             actions: <Widget>[
               TextButton(
                 child: const Text('OK'),
                 onPressed: () {
                   Navigator.of(context).pop(); // Close the dialog
                 },
               ),
             ],
           );
         },
       );
     }

   }
   */
   Future<void> addOrderToFirestore(Order order) async {
     try {
       await FirebaseFirestore.instance.collection('orders').add({
         'orderId': order.orderId,
         'items': order.items,
         'total': order.total,
         'orderDate': order.orderDate,
       });
       print('Order added to Firestore successfully');
     } catch (e) {
       print('Error adding order to Firestore: $e');
     }
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
                onPressed: () {
                  createOrder(context);
                },
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

