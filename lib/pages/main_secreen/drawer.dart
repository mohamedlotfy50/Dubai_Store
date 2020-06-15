import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dubai/models/user_model.dart';
import 'package:dubai/pages/main_secreen/cart.dart';
import 'package:dubai/pages/main_secreen/deawer_tiles.dart';
import 'package:dubai/pages/main_secreen/repot_error.dart';
import 'package:dubai/pages/settings/settings.dart';
import 'package:dubai/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final AuthServices _auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder(
        stream: Firestore.instance
            .collection('users')
            .document(user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          return Drawer(
            child: Column(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  currentAccountPicture: snapshot.data['user image'] == null
                      ? CircleAvatar(
                          backgroundColor: Colors.black38,
                        )
                      : CircleAvatar(
                          backgroundImage:
                              NetworkImage(snapshot.data['user image']),
                        ),
                  accountName: Text(snapshot.data['user name'] ?? 'new member'),
                  accountEmail:
                      Text(snapshot.data['phone Number'] ?? 'not defiend'),
                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      DrawerTiles(
                        icon: FaIcon(FontAwesomeIcons.home),
                        name: 'HOME',
                        onpress: () {},
                        isSelected: true,
                      ),
                      DrawerTiles(
                        icon: FaIcon(FontAwesomeIcons.shoppingCart),
                        name: 'SHOPPING CART',
                        onpress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Cart();
                              },
                            ),
                          );
                        },
                      ),
                      DrawerTiles(
                        icon: FaIcon(FontAwesomeIcons.solidBell),
                        name: 'NOTIFICATIONS',
                        onpress: () {},
                      ),
                      DrawerTiles(
                        icon: Icon(Icons.settings),
                        name: 'SETTINGS',
                        onpress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Settings();
                              },
                            ),
                          );
                        },
                      ),
                      DrawerTiles(
                        icon: FaIcon(FontAwesomeIcons.signOutAlt),
                        name: 'Logout',
                        onpress: () async {
                          await _auth.signOut();
                        },
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      ListTile(
                        title: Text('OTHERS'),
                        dense: true,
                      ),
                      DrawerTiles(
                        icon: Icon(Icons.mobile_screen_share),
                        name: 'REPORT AN ISSUE',
                        onpress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ReportError();
                              },
                            ),
                          );
                        },
                      ),
                      DrawerTiles(
                        icon: FaIcon(FontAwesomeIcons.phoneAlt),
                        name: 'CONTACT US',
                        onpress: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
