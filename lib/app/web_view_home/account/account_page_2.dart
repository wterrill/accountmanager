import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/app/web_view_home/create_technician/create_tech_page.dart';
import 'package:accountmanager/common_utilities/buttonConverter.dart';
import 'package:accountmanager/common_widgets/display_widget_dialog_with_error.dart';
import 'package:accountmanager/common_widgets/empty_content.dart';
import 'package:accountmanager/constants/text_styles.dart';
import 'package:accountmanager/models/technician.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'dart:math';

import 'package:intl/intl.dart';

class AccountWebPage2 extends ConsumerWidget {
  AccountWebPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // final textController = useTextEditingController(text: 'initial text');
    final firebaseAuth = watch(firebaseAuthProvider);
    final user = firebaseAuth.currentUser!;
    final technicianAsyncValue = watch(technicianStreamProvider!);
    return technicianAsyncValue.when(
      data: (technicians) {
        Technician currentUser =
            technicians.where((element) => element.id == user.uid).toList()[0];
        return ShowAccountWithName(technician: currentUser);
      },
      // technicians.isNotEmpty
      //     ? _datatable(DTS(items, context))
      //     : const EmptyContent(),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const EmptyContent(
        title: 'Something went wrong',
        message: 'Can\'t load items right now',
      ),
    );
  }
}

class ShowAccountWithName extends ConsumerWidget {
  ShowAccountWithName({Key? key, required this.technician}) : super(key: key);
  final Technician technician;
  final textController_FirstName = TextEditingController();
  final textController_LastName = TextEditingController();
  final textController_Email = TextEditingController();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var rng = new Random();

    int rnd_val = (rng.nextInt(50)) + 1;
    NumberFormat f = NumberFormat("00");
    final String suffix = f.format(rnd_val);
    print(suffix);
    textController_FirstName.text = technician.firstName;
    textController_LastName.text = technician.lastName;
    textController_Email.text = technician.email;

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
            SingleChildScrollView(
              child: Card(
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
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
                            child: SvgPicture.asset(
                                'assets/avatars/avatar_${suffix}.svg',
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                                semanticsLabel: 'mean guy'),
                          ),
                          GestureDetector(
                              onTap: () {
                                displayWidgetDialogWithError(
                                    context, 'title', AvatarGrid());
                              },
                              child: const Text('Edit')),
                          const SizedBox(height: 40),
                        ],
                      )),
                      Row(
                        children: [
                          Row(children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  0.0, 0.0, 16.0, 0.0),
                              child: Text('First Name:',
                                  style: TextStyles.heading4),
                            ),
                            Container(
                                width: 100,
                                child: TextField(
                                    controller: textController_FirstName))
                          ]),
                          Row(children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  0.0, 0.0, 16.0, 0.0),
                              child: Text('Last Name:',
                                  style: TextStyles.heading4),
                            ),
                            Container(
                                width: 100,
                                child: TextField(
                                    controller: textController_LastName))
                          ]),
                          Row(children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  0.0, 0.0, 16.0, 0.0),
                              child: Text('Email:', style: TextStyles.heading4),
                            ),
                            Container(
                                width: 200,
                                child:
                                    TextField(controller: textController_Email))
                          ]),

                          // TextField(
                          //   // keyboardType: TextInputType.text,
                          //   maxLength: 50,
                          //   controller: textController,
                          //   decoration: const InputDecoration(
                          //     labelText: 'Company Name',
                          //     labelStyle: TextStyle(
                          //         fontSize: 18.0, fontWeight: FontWeight.w500),
                          //   ),
                          //   keyboardAppearance: Brightness.light,
                          //   style: const TextStyle(
                          //       fontSize: 20.0, color: Colors.black),
                          //   onChanged: (_) {
                          //     // String name = textController.text;
                          //   },
                          // ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      FlatButtonX(
                          colorx: ColorDefs.disabled,
                          shapex: ShapeStyle.redRoundedBorder,
                          onPressedx: () {},
                          childx: Padding(
                            padding: PaddingStyles.primaryButtonPadding,
                            child: const Text(
                              'Save',
                              style: TextStyles.button1White,
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

void _onAvatarClicked(int index, BuildContext context) {
  debugPrint('You tapped on item ${NumberFormat("00").format(index)}');
  Navigator.of(context).pop();
  // return $index;
}

class AvatarGrid extends StatelessWidget {
  const AvatarGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> avatarPics = [];
    final NumberFormat f = NumberFormat('00');
    for (int i = 1; i < 51; i++) {
      final String avatarName = 'avatar_${f.format(i)}.svg';
      final Widget widget = GestureDetector(
          onTap: () => _onAvatarClicked(i, context),
          child: SvgPicture.asset('assets/avatars/$avatarName',
              height: 100,
              width: 100,
              fit: BoxFit.cover,
              semanticsLabel: 'mean guy'));
      avatarPics.add(widget);

      // textPics.add(Text('text is: $avatarName'));
    }

    return Container(
        width: 600,
        height: 600,
        child: GridView.count(
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            crossAxisCount: 5,
            children: avatarPics));

    // return Container(
    //     width: 400,
    //     height: 400,
    //     child: GridView.count(crossAxisCount: 4, children: textPics));
    // return Text("Beer");
  }
}
