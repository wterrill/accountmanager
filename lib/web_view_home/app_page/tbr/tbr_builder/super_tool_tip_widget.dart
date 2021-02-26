import 'package:flutter/material.dart';
import 'package:super_tooltip/super_tooltip.dart';

class SuperToolTipWidget extends StatefulWidget {
  const SuperToolTipWidget({
    Key key,
    @required this.howString,
    @required this.whyString,
  }) : super(key: key);
  final String howString;
  final String whyString;

  @override
  _SuperToolTipWidgetState createState() => _SuperToolTipWidgetState();
}

class _SuperToolTipWidgetState extends State<SuperToolTipWidget> {
  SuperTooltip tooltip;

  Future<bool> _willPopCallback() async {
    // If the tooltip is open we don't pop the page on a backbutton press
    // but close the ToolTip
    if (tooltip.isOpen) {
      tooltip.close();
      return false;
    }
    return true;
  }

  void onTap() {
    if (tooltip != null && tooltip.isOpen) {
      tooltip.close();
      return;
    }

    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    final Offset targetGlobalCenter = renderBox
        .localToGlobal(renderBox.size.center(Offset.zero), ancestor: overlay);

    // We create the tooltip on the first use
    tooltip = SuperTooltip(
      popupDirection: TooltipDirection.right,
      maxWidth: 600.0,
      showCloseButton: ShowCloseButton.inside,
      closeButtonColor: Colors.red,
      content: Material(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Why:', style: TextStyle(color: Colors.blue)),
                Text(
                  widget.whyString,
                  softWrap: true,
                ),
                const Text(''),
                const Text('How:', style: TextStyle(color: Colors.blue)),
                Text(
                  widget.howString,
                  softWrap: true,
                ),
              ]),
        ),
      ),
    );

    tooltip.show(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: GestureDetector(onTap: onTap, child: const Icon(Icons.help_outline)
          // Container(
          //     width: 20.0,
          //     height: 20.0,
          //     decoration: const BoxDecoration(
          //       shape: BoxShape.circle,
          //       color: Colors.blue,
          //     )),
          ),
    );
  }
}
