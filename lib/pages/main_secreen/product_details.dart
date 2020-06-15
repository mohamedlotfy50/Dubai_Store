import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dubai/models/user_model.dart';
import 'package:dubai/pages/main_secreen/alert.dart';
import 'package:dubai/pages/main_secreen/myapp_bar.dart';
import 'package:dubai/services/database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatelessWidget {
  final String name;
  final String price;
  final String brandName;
  final String image;
  final String details;
  final ref;

  const ProductDetails({
    Key key,
    this.name,
    this.price,
    this.brandName,
    this.image,
    this.details,
    this.ref,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final database = DataBaseService();
    final user = Provider.of<User>(context);
    final userinfo =
        Firestore.instance.collection('users').document(user.uid).snapshots();

    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              color: Colors.black38,
              height: 250,
              child: Image.network(
                image,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        name,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '$price LE',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        brandName,
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Details',
                        style: TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.black12,
                    child: SingleChildScrollView(
                        child: Text(details, style: TextStyle(fontSize: 16))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 200,
                    height: 55,
                    child: StreamBuilder(
                        stream: userinfo,
                        builder: (context, snapshot) {
                          return RaisedButton.icon(
                            color: Colors.deepOrangeAccent,
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
                                  price: price,
                                  productName: name,
                                  userid: user.uid,
                                );
                              }
                            },
                            label: Text('Add to cart'),
                            icon: FaIcon(FontAwesomeIcons.shoppingCart),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          );
                        }),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
