part of alert_dialogs;

Future<bool?> showAlertDialog({
  required BuildContext context,
  required String? title,
  required String? content,
  String? cancelActionText,
  required String defaultActionText,
}) async {
  if (kIsWeb || !Platform.isIOS) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title!),
        content: Text(content!),
        actions: <Widget>[
          if (cancelActionText != null)
            FlatButtonX(
              childx: Text(cancelActionText),
              onPressedx: () {
                print('here_here');
                Navigator.of(context).pop(false);
              },
            ),
          FlatButtonX(
            childx: Text(defaultActionText),
            onPressedx: () {
              bool result = true;
              if (defaultActionText == 'OK') {
                result = false;
              }
              print('here_and_there');
              Navigator.of(context).pop(result);
            },
          ),
        ],
      ),
    );
  }
  return showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Text(title!),
      content: Text(content!),
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
