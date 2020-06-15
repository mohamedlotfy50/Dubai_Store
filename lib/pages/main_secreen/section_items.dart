import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dubai/loading.dart';
import 'package:dubai/pages/main_secreen/myapp_bar.dart';
import 'package:dubai/pages/main_secreen/product_card.dart';
import 'package:flutter/material.dart';

class Items extends StatefulWidget {
  final String name;
  final String collectionName;
  final String documentId;

  Items({Key key, this.name, this.documentId, this.collectionName})
      : super(key: key);
  @override
  _ItemsState createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('market')
            .document('jCJimXO67XZOIsDUIw64')
            .collection(widget.collectionName)
            .document(widget.documentId)
            .collection('products')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Center(
                child: Loaading(),
              );
            default:
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      widget.name,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Container(
                      height: 490,
                      child: ListView(
                        children: <Widget>[
                          GridView.builder(
                            itemCount: snapshot.data.documents.length,
                            shrinkWrap: true,
                            primary: false,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 0.6,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              crossAxisCount: 2,
                            ),
                            itemBuilder: (BuildContext context, int i) {
                              return ProductCard(
                                image:
                                    snapshot.data.documents[i].data['image'] ??
                                        'name is not provided',
                                name: snapshot.data.documents[i].data['name'] ??
                                    'name is not provided',
                                price:
                                    snapshot.data.documents[i].data['price'] ??
                                        'price is not provided',
                                brandName:
                                    snapshot.data.documents[i].data['brand'] ??
                                        'brand is not provided',
                                details: snapshot
                                        .data.documents[i].data['details'] ??
                                    'details is not provided',
                                ref: snapshot.data.documents[i].reference,
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
          }
        },
      ),
    );
  }
}
