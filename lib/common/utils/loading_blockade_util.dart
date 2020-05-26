import 'package:flutter/material.dart';
import 'package:votingmobile/common/ui/common_will_pop_scope.dart';
import 'package:votingmobile/common/ui/loading_blocker.dart';

bool isBlockade = false;

void applyBlockade<T>(
  BuildContext context, {
  @required Future<T> future,
  @required Function(T) onFutureResolved,
}) async {
  isBlockade = true;
  showGeneralDialog(
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) => Center(
      child: CommonWillPopScope(child: LoadingBlocker()),
    ),
    barrierDismissible: false,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black.withOpacity(0.65),
    transitionDuration: const Duration(milliseconds: 500),
  );

  final T result = await future;

  isBlockade = false;
  // Remove the blocker
  Navigator.of(context, rootNavigator: true).pop();

  onFutureResolved?.call(result);
}
