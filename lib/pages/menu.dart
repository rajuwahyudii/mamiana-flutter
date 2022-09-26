import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mamiana/services/services.dart';

class MenuPages extends StatefulWidget {
  const MenuPages({Key? key}) : super(key: key);

  @override
  State<MenuPages> createState() => _MenuPagesState();
}

class _MenuPagesState extends State<MenuPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.abc,
            color: Colors.white,
          ),
          onPressed: () {
            Services.signOut();
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(
                'data',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
