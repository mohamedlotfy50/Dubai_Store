import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dubai/models/user_model.dart';
import 'package:dubai/pages/main_secreen/myapp_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../loading.dart';

class Cart extends StatelessWidget {
  const Cart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Scaffold(
      appBar: MyAppBar(),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('orders')
            .document(user.uid)
            .collection('myOreder')
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
                      'My Cart',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Container(
                      height: 300,
                      child: Container(
                        child: ListView(
                          children: <Widget>[
                            ListView.builder(
                              itemBuilder: (BuildContext context, int i) {
                                return ListTile(
                                  leading: Text('${i + 1}'),
                                  title: Text(
                                    snapshot
                                        .data.documents[i].data['product name'],
                                  ),
                                  subtitle: Text(
                                    snapshot.data.documents[i].data['price'],
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () async {
                                      await Firestore.instance.runTransaction(
                                          (Transaction myTransaction) async {
                                        await myTransaction.delete(snapshot
                                            .data.documents[i].reference);
                                      });
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
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
