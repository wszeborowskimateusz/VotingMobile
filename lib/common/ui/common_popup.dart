import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:votingmobile/localization/translations.dart';

void showConfirmPopup({
  @required BuildContext context,
  @required String title,
  @required Function(BuildContext) onConfirm,
}) {
  final translations = Translations.of(context);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Text(title),
        actions: [
          TextButton(
            child: Text(translations.voteCancel),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text(translations.voteAccept),
            onPressed: () => onConfirm(context),
          ),
        ],
      );
    },
  );
}
