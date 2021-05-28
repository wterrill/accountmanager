part of alert_dialogs;

Future<Map<String, dynamic>?> showWidgetDialog({
  required BuildContext context,
  required String title,
  required Widget widget,
  String? cancelActionText,
  String? defaultActionText,
}) async {
  print(widget);
  if (kIsWeb || !Platform.isIOS) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        titlePadding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
        contentPadding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
        actionsPadding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
        buttonPadding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
        insetPadding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
        title: Text(title),
        content: widget,
        actions: <Widget>[
          if (cancelActionText != null)
            FlatButtonX(
              childx: Text(cancelActionText),
              onPressedx: () => Navigator.of(context).pop({'result': 'true'}),
            ),
          if (cancelActionText != null)
            FlatButtonX(
              childx: Text(defaultActionText!),
              onPressedx: () => Navigator.of(context).pop({'result': 'false'}),
            ),
        ],
      ),
    );
  }
  return showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Text(title),
      content: widget,
      actions: <Widget>[
        if (cancelActionText != null)
          CupertinoDialogAction(
            child: Text(cancelActionText),
            onPressed: () => Navigator.of(context).pop(false),
          ),
        CupertinoDialogAction(
          child: Text(defaultActionText!),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    ),
  );
}
