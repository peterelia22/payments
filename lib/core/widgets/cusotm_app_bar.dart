import 'package:flutter/material.dart';

import '../utils/styles.dart';

AppBar BuildAppBar({required final String title}) {
  return AppBar(
    leading: Icon(Icons.arrow_back),
    elevation: 0,
    backgroundColor: Colors.transparent,
    centerTitle: true,
    title: Text(
      title,
      style: AppStyles.style25,
    ),
  );
}
