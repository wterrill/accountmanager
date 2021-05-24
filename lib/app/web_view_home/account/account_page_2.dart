import 'package:accountmanager/constants/color_defs.dart';
import 'package:accountmanager/constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AccountWebPage2 extends ConsumerWidget {
  const AccountWebPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Expanded(
      child: Container(
        color: const Color(0xFFF2F2F2),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40.0, 64.0, 8.0, 0.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Account Settings',
              style: TextStyles.heading1,
            ),
            const SizedBox(height: 30),
            Card(
              shape: ShapeStyle.redRoundedBorder,
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        child: Column(
                      children: [
                        // SvgPicture.network(
                        //     'http://upload.wikimedia.org/wikipedia/commons/0/02/SVG_logo.svg'),
                        SvgPicture.asset('assets/svg/avatar_test2.svg',
                            semanticsLabel: 'Acme Logo'),
                        Text('Edit')
                      ],
                    )),
                    Text('Add Picture', style: TextStyles.heading2),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          Text('Active Companies', style: TextStyles.heading2),
                    ),
                    Container(height: 300, child: Text("Beer")),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
