import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dubai/loading.dart';
import 'package:dubai/pages/main_secreen/section.dart';
import 'package:dubai/pages/main_secreen/section_items.dart';
import 'package:flutter/material.dart';

class ItemsState extends StatefulWidget {
  final name;
  final id;

  ItemsState({
    Key key,
    this.name,
    this.id,
  }) : super(key: key);

  @override
  _ItemsStateState createState() => _ItemsStateState();
}

class _ItemsStateState extends State<ItemsState> {
  @override
  Widget build(BuildContext context) {
    void navigation({String name, String id, String collectionName}) {
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return Items(
          name: name,
          documentId: id,
          collectionName: collectionName,
        );
      }));
    }

    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('market')
          .document(widget.id)
          .collection(widget.name)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Center(
              child: Loaading(),
            );
          default:
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            'Categorys',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, i) {
                          return Section(
                            sectionName:
                                snapshot.data.documents[i].data['name'],
                            sectionImage:
                                snapshot.data.documents[i].data['image'] ??
                                    null,
                            onPress: () => navigation(
                              name: snapshot.data.documents[i].data['name'],
                              id: snapshot.data.documents[i].documentID,
                              collectionName: widget.name,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
        }
      },
    );
  }
}
