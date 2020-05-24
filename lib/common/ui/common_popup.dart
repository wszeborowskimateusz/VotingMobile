import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:votingmobile/localization/translations.dart';

void showConfirmPopup({
  @required BuildContext context,
  @required String title,
  @required VoidCallback onConfirm,
}) {
  final translations = Translations.of(context);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Text(title),
        actions: [
          FlatButton(
            child: Text(translations.voteCancel),
            onPressed: () => Navigator.pop(context),
          ),
          FlatButton(
            child: Text(translations.voteAccept),
            onPressed: onConfirm,
          ),
        ],
      );
    },
  );
}
