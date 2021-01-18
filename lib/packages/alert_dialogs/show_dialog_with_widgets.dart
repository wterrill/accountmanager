part of alert_dialogs;

Future<Map<String, dynamic>> showWidgetDialog({
  @required BuildContext context,
  @required String title,
  @required Widget widget,
  String cancelActionText,
  String defaultActionText,
}) async {
  print(widget);
  if (kIsWeb || !Platform.isIOS) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: widget,
        actions: <Widget>[
          if (cancelActionText != null)
            FlatButton(
              child: Text(cancelActionText),
              onPressed: () => Navigator.of(context).pop({'result': 'true'}),
            ),
          if (cancelActionText != null)
            FlatButton(
              child: Text(defaultActionText),
              onPressed: () => Navigator.of(context).pop({'result': 'false'}),
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
          child: Text(defaultActionText),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    ),
  );
}
