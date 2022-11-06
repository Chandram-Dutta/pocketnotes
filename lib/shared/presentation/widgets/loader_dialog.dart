import 'package:flutter/cupertino.dart';

showLoaderDialog(BuildContext context) {
  showCupertinoDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return const CupertinoAlertDialog(
        title: Text("Loading"),
        content: CupertinoActivityIndicator(
          radius: 10,
        ),
      );
    },
  );
}
