import 'package:dubai/pages/main_secreen/cart.dart';
import 'package:dubai/pages/main_secreen/drawer.dart';
import 'package:dubai/pages/main_secreen/main_state.dart';
import 'package:dubai/services/database.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ManiScreen extends StatefulWidget {
  @override
  _ManiScreenState createState() => _ManiScreenState();
}

class _ManiScreenState extends State<ManiScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: DataBaseService().users,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: Text('Dubai Store'),
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.shoppingCart,
                    size: 22,
                  ),
                  onPressed: () {
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
              ],
              bottom: TabBar(
                tabs: [
                  Tab(
                    text: 'New',
                  ),
                  Tab(
                    text: 'Used',
                  ),
                ],
                indicatorColor: Colors.white,
                unselectedLabelColor: Colors.black45,
                labelStyle: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            drawer: MyDrawer(),
            body: TabBarView(children: [
              ItemsState(
                name: 'new',
                id: 'jCJimXO67XZOIsDUIw64',
              ),
              ItemsState(
                name: 'used',
                id: 'leYb2eXTxcr25OSyIjad',
              ),
            ])),
      ),
    );
  }
}
