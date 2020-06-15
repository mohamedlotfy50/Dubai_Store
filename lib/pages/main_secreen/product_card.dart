import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dubai/models/user_model.dart';
import 'package:dubai/pages/main_secreen/alert.dart';
import 'package:dubai/pages/main_secreen/product_details.dart';
import 'package:dubai/services/database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatefulWidget {
  final String name;
  final String price;
  final String brandName;
  final String image;
  final String details;
  final ref;

  const ProductCard(
      {Key key,
      this.name,
      this.price,
      this.brandName,
      this.image,
      this.details,
      this.ref})
      : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final database = DataBaseService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final userinfo =
        Firestore.instance.collection('users').document(user.uid).snapshots();

    return GridTile(
      header: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.black87,
            radius: 35,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Text(widget.price), Text('LE')],
            ),
          ),
        ],
      ),
      footer: GridTileBar(
        subtitle: Text(widget.brandName),
        title: Text(
          widget.name,
          textAlign: TextAlign.center,
        ),
        trailing: StreamBuilder(
            stream: userinfo,
            builder: (context, snapshot) {
              return IconButton(
                  icon: FaIcon(FontAwesomeIcons.shoppingCart),
                  onPressed: () async {
                    if (snapshot.data['address'] == '' ||
                        snapshot.data['phone number'] == '' ||
                        snapshot.data['user name'] == '') {
                      Dialogs.yesCancellDailog(context, 'error',
                          'please go to settings and update your data first');
                    } else {
                      await database.addOrder(
                        address: snapshot.data['address'],
                        name: snapshot.data['phone number'],
                        phoneNum: snapshot.data['user name'],
                        price: widget.price,
                        productName: widget.name,
                        userid: user.uid,
                      );
                    }
                  });
            }),
        backgroundColor: Colors.black87,
      ),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) {
            return ProductDetails(
              image: widget.image,
              brandName: widget.brandName,
              details: widget.details,
              name: widget.name,
              price: widget.price,
              ref: widget.ref,
            );
          }),
        ),
        child: Image.network(
          widget.image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
