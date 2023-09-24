import 'package:flutter/material.dart';

import 'package:gadget_express/components/cart_provider.dart';


class CartProducts extends StatefulWidget {
  final String subtitleText;
  final void Function(double) onTotalPriceChanged;
  final CartManager? cartManager;

  const CartProducts({
    Key? key,
    required this.subtitleText, // This is the named parameter
    required this.onTotalPriceChanged,
    required this.cartManager,
  }) : super(key: key);
  @override
  State<CartProducts> createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {
  /*
  var ProductsCart = [
    {
      "name": "Lenovo Ideapad",
      "picture": "Images/devices/145g.jpg",
      "price": 65000,
      "color": "Silver",
      "quantity": 1
    },
    {
      "name": "Samsung Galaxy",
      "picture": "Images/devices/p2.jpg",
      "price": 29999,
      "color": "Blue",
      "quantity": 1
    },
  ];
*/
  double _totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    _calculateTotalPrice();
  }

  void _calculateTotalPrice() {
    double totalPrice = 0.0;
    for (var product in widget.cartManager?.cartItems ?? []) {
      totalPrice += (product["price"] as int) * (product["quantity"] as int);
    }
    _totalPrice = totalPrice;

    // Call the callback function with the updated _totalPrice
    widget.onTotalPriceChanged(_totalPrice);
   // print('Total is$_totalPrice');
  }

 // void _updateQuantity(int index, int newQuantity) {
 //   setState(() {
 //     ProductsCart[index]["quantity"] = newQuantity;
 //   });
 //   _calculateTotalPrice();
 // }

  void _increaseQuantity(int index) {
    widget.cartManager?.increaseQuantity(index);
    _calculateTotalPrice();
  }

  void _decreaseQuantity(int index) {
    widget.cartManager?.decreaseQuantity(index);
    _calculateTotalPrice();
  }
 // void _addToCart(Map<String, dynamic> product) {
 //   widget.cartManager?.addToCart(product); // Add the product to the cart
 // }


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.cartManager?.cartItems.length ?? 0,
      itemBuilder: (context, index) {
        final cartItem = widget.cartManager?.cartItems[index];
        if (cartItem == null) {
          return const SizedBox.shrink(); // Return an empty SizedBox if the cart item is null.
        }
        return SingleCartProd(
          cart_prod_name: cartItem["name"],
          cart_prod_pictures: cartItem["picture"],
          cart_prod_price: cartItem["price"],
          cart_prod_color: cartItem["color"],
          cart_prod_qty: cartItem["quantity"],
          increaseQuantity: () => _increaseQuantity(index),
          decreaseQuantity: () => _decreaseQuantity(index),
        );
      },
    );
  }
}

class SingleCartProd extends StatelessWidget {
  final cart_prod_name;
  final cart_prod_pictures;
  final cart_prod_price;
  final cart_prod_color;
  final cart_prod_qty;
  final VoidCallback increaseQuantity;
  final VoidCallback decreaseQuantity;

  const SingleCartProd({
    Key? key,
    required this.cart_prod_name,
    required this.cart_prod_pictures,
    required this.cart_prod_price,
    required this.cart_prod_color,
    required this.cart_prod_qty,
    required this.increaseQuantity,
    required this.decreaseQuantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.asset(cart_prod_pictures, width: 80.0, height: 80.0),
        title: Text(cart_prod_name),
        subtitle: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text("Color: "),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(cart_prod_color, style: const TextStyle(color: Colors.red)),
                ),
              ],
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                "\₹$cart_prod_price",
                style: const TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold, color: Colors.red),
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              onPressed: decreaseQuantity,//decreaseQuantity
              icon: const Icon(Icons.remove),
            ),
            Text(cart_prod_qty.toString(),style: const TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
            IconButton(
              onPressed: increaseQuantity,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}