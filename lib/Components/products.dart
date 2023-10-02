import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Pages/product_details.dart';
import 'package:gadget_express/components/cart_provider.dart';


class Products extends StatefulWidget {
  final CartManager? cartManager;
   const Products({super.key, required this.cartManager});


  @override
  State<Products> createState() => _ProductsState();
}


class _ProductsState extends State<Products> {
 // void _addToCart(Map<String, dynamic> product) {
    // Add the product to the cart using cartManager
  //  widget.cartManager.addToCart(product);
 // }
 
  var product_list = [
    {
      "name": "Lenovo Ideapad",
      "picture": "Images/devices/145g.jpg",
      "old_price": 80000,
      "price": 65000,
      "prod_cat":"Laptop"
    },
    {
      "name": "HP Chromebook",
      "picture": "Images/devices/l2.jpg",
      "old_price": 83000,
      "price": 67000,
      "prod_cat":"Laptop"
    },
    {
      "name": "Iphone 12",
      "picture": "Images/devices/p1.jpg",
      "old_price": 50000,
      "price": 39999,
      "prod_cat":"Phone"
    },
    {
      "name": "Samsung Galaxy",
      "picture": "Images/devices/p2.jpg",
      "old_price": 35000,
      "price": 29999,
      "prod_cat":"Phone"
    },
    {
      "name": "Lenovo Ideapad",
      "picture": "Images/devices/145g.jpg",
      "old_price": 100,
      "price": 80,
      "prod_cat":"Laptop"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: product_list.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),

        itemBuilder: (BuildContext context, int index) {
          return Single_Prod(
              cartManager: widget.cartManager,
prod_name: product_list[index]['name'],
prod_pictures: product_list[index]['picture'],
prod_old_price: product_list[index]['old_price'],
prod_price: product_list[index]['price'],
prod_cat: product_list[index]['category'],
addToCart: (product) {
// Add the product to the cart using cartManager
widget.cartManager?.addToCart(product);
},
index: index,);


}
);
}
}

class Single_Prod extends StatelessWidget {
  const Single_Prod(
      {super.key,
        required this.addToCart,
        required this.cartManager,
        required this.index,
      this.prod_name,
      this.prod_pictures,
      this.prod_old_price,
      this.prod_price,
        this.prod_cat});

  final prod_name;
  final prod_pictures;
  final prod_old_price;
  final prod_price;
  final prod_cat;
  final int index;
  final CartManager? cartManager;
  final Function(Map<String, dynamic>) addToCart;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
          tag: '${prod_name}_$index',
          child: Material(
            child: InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return Consumer<CartManager>(
                    builder: (context, cartManager, child) {
                      return ProductDetails(
                        // Pass the product details and cartManager
                        prod_detail_name: prod_name,
                        prod_detail_picture: prod_pictures,
                        prod_detail_old_price: prod_old_price,
                        prod_detail_price: prod_price,
                        cartManager: cartManager,
                      );
                    },
                  );
                }),
                  ),
              child: GridTile(
                  footer: Container(
                    color: Colors.white70,
                    child: ListTile(
                      leading: Text(
                        prod_name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      title: Text(
                        "\₹$prod_price",
                        style: const TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w800),
                      ),
                      subtitle: Text(
                        "\₹$prod_old_price",
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            decoration: TextDecoration.lineThrough),
                      ),
                   /*  trailing: IconButton(
                       onPressed: () {
                         Map<String, dynamic> product = {
                           "name": prod_name,
                           "picture": prod_pictures,
                           "price": prod_price,
                           // Add other product details as needed
                         };
                         // Call the addToCart function
                         addToCart(product);
                       }, icon: const Icon(Icons.add_shopping_cart),
                     ),*/
                    ),
                  ),
                  child: Image.asset(
                    prod_pictures,
                    fit: BoxFit.cover,
                  )),
            ),
          )),
    );
  }
}
