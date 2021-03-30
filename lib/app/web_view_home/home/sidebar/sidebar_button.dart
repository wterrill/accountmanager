import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final sideBarButtonStateProvider = StateProvider<String>((ref) {
  return 'none';
});

class SidebarButton extends ConsumerWidget {
  const SidebarButton(
      {Key key,
      this.text,
      this.faIcon,
      this.onPressedx,
      this.lastText,
      this.imageIcon})
      : super(key: key);

  // final TextStyle buttonStyle;
  final String text;
  final IconData faIcon;
  final Function onPressedx;
  final String lastText;
  final Widget imageIcon;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    bool selected;
    if (lastText == text) {
      selected = true;
    } else {
      selected = false;
    }
    Widget image = imageIcon;
    if (faIcon != null) {
      image = FaIcon(
        faIcon,
        color: Colors.white,
      );
    }
    print(image);
    return TextButton(
        style: ButtonStyle(
          // elevation: MaterialStateProperty.all<double>(10),

          elevation: MaterialStateProperty.resolveWith<double>(
            //   // text color
            (states) => states.contains(MaterialState.hovered) ? 10.0 : 100.0,
          ),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            // text color
            (states) => states.contains(MaterialState.pressed)
                ? Colors.red
                : Colors.blue,
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
              // background color    this is color:
              (states) {
            Color finalColor = Colors.transparent;
            if (states.contains(MaterialState.hovered)) {
              finalColor = Colors.transparent;
            }

            if (states.contains(MaterialState.pressed)) {
              finalColor = const Color(0x5529588F);
            }
            return selected ? Colors.white.withAlpha(22) : finalColor;
            // return finalColor;
          }),
          // shadowColor: MaterialStateProperty.resolveWith<Color>(
          //   // text color
          //   (Set<MaterialState> states) =>
          //       states.contains(MaterialState.hovered)
          //           ? Colors.red
          //           : Colors.blue,
          // ),
          // shape: MaterialStateProperty.all(
          //   RoundedRectangleBorder(
          // borderRadius: BorderRadius.all(
          //   Radius.circular(50),
          // ),
          //       side: BorderSide(color: Colors.pink, width: 3.0)),
          // ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Row(children: [
            Container(
              width: 65,
              height: 35,
              child: FittedBox(child: image),
            ),
            const SizedBox(
              width: 15,
            ),
            Text(text,
                style: const TextStyle(color: Colors.white, fontSize: 16))
          ]),
        ),
        onPressed: () {
          onPressedx.call();
          context.read(sideBarButtonStateProvider).state = text;
        });
  }
}
