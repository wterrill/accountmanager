part of alert_dialogs;

Future<Map<String, dynamic>?> showWidgetDialog({
  required BuildContext context,
  required String title,
  required Widget widget,
  required String cancelActionText,
  required String defaultActionText,
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
          if (cancelActionText != '')
            FlatButtonX(
              colorx: ColorDefs.enabledButton,
              shapex: ShapeDefs.redRoundedBorder,
              childx: Text(
                cancelActionText,
                style: StyleDefs.button1White,
              ),
              onPressedx: () => Navigator.of(context).pop({'result': 'true'}),
            ),
          if (defaultActionText != '')
            FlatButtonX(
              colorx: ColorDefs.enabledButton,
              shapex: ShapeDefs.redRoundedBorder,
              childx: Text(defaultActionText, style: StyleDefs.button1White),
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
        if (cancelActionText != '')
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
