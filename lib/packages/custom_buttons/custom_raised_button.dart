part of custom_buttons;

@immutable
class CustomRaisedButton extends StatelessWidget {
  const CustomRaisedButton({
    Key key,
    @required this.child,
    this.color,
    this.textColor,
    this.height = 50.0,
    this.borderRadius = 4.0,
    this.loading = false,
    this.onPressed,
  }) : super(key: key);
  final Widget child;
  final Color color;
  final Color textColor;
  final double height;
  final double borderRadius;
  final bool loading;
  final VoidCallback onPressed;

  Widget buildSpinner(BuildContext context) {
    final ThemeData data = Theme.of(context);
    return Theme(
      data: data.copyWith(accentColor: Colors.white70),
      child: const SizedBox(
        width: 28,
        height: 28,
        child: CircularProgressIndicator(
          strokeWidth: 3.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: RaisedButtonX(
        childx: loading ? buildSpinner(context) : child,
        shapex: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          ),
        ), // height / 2
        colorx: color,
        disabledColorx: color,
        textColorx: textColor,
        onPressedx: onPressed,
      ),
    );
  }
}
