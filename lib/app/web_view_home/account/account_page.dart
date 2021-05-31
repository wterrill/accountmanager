import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/app/web_view_home/create_technician/create_tech_page.dart';
import 'package:accountmanager/common_utilities/buttonConverter.dart';
import 'package:accountmanager/common_widgets/display_widget_dialog_with_error.dart';
import 'package:accountmanager/common_widgets/empty_content.dart';
import 'package:accountmanager/constants/text_styles.dart';
import 'package:accountmanager/models/technician.dart';
import 'package:accountmanager/services/firestore_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:intl/intl.dart';

final filenameProvider = StateProvider((ref) => 'avatar_000.svg');

int numberOfAvatars = 135;

class AccountWebPage2 extends ConsumerWidget {
  const AccountWebPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // final textController = useTextEditingController(text: 'initial text');
    final firebaseAuth = watch(firebaseAuthProvider);
    final user = firebaseAuth.currentUser!;
    final technicianAsyncValue = watch(technicianStreamProvider!);
    return technicianAsyncValue.when(
      data: (technicians) {
        final Technician currentUser =
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
  final textControllerFirstName = TextEditingController();
  final textControllerLastName = TextEditingController();
  final textControllerEmail = TextEditingController();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // final Random rng = Random();

    // final int rndVal = (rng.nextInt(numberOfAvatars)) + 1;
    // final NumberFormat f = NumberFormat('000');
    // final String suffix = f.format(rndVal);
    // print(suffix);
    late String filename;
    filename = watch(filenameProvider).state;
    if (filename == 'avatar_000.svg') {
      if (technician.filename!.contains('avatar')) {
        filename = technician.filename!;
      } else {
        filename = 'avatar_000.svg';
      }
    }
    textControllerFirstName.text = technician.firstName;
    textControllerLastName.text = technician.lastName;
    textControllerEmail.text = technician.email;

    return Expanded(
      child: Container(
        color: const Color(0xFFF2F2F2),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40.0, 64.0, 8.0, 0.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              'Account Settings',
              style: StyleDefs.heading1,
            ),
            const SizedBox(height: 30),
            SingleChildScrollView(
              child: Card(
                shape: ShapeDefs.redRoundedBorder,
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
                            child: SvgPicture.asset('assets/avatars/$filename',
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                                semanticsLabel: 'mean guy'),
                          ),
                          GestureDetector(
                              onTap: () {
                                displayWidgetDialogWithError(context,
                                    'Choose your Avatar:', const AvatarGrid());
                              },
                              child: const Text('Edit')),
                          const SizedBox(height: 40),
                        ],
                      ),
                      Row(
                        children: [
                          Row(children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  0.0, 0.0, 16.0, 0.0),
                              child: Text('First Name:',
                                  style: StyleDefs.heading4),
                            ),
                            Container(
                                width: 100,
                                child: TextField(
                                    controller: textControllerFirstName))
                          ]),
                          Row(children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  0.0, 0.0, 16.0, 0.0),
                              child:
                                  Text('Last Name:', style: StyleDefs.heading4),
                            ),
                            Container(
                                width: 100,
                                child: TextField(
                                    controller: textControllerLastName))
                          ]),
                          Row(children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  0.0, 0.0, 16.0, 0.0),
                              child: Text('Email:', style: StyleDefs.heading4),
                            ),
                            Container(
                              width: 200,
                              child: TextField(
                                  enabled: false,
                                  controller: textControllerEmail),
                            )
                          ]),
                        ],
                      ),
                      const SizedBox(height: 40),
                      FlatButtonX(
                          colorx: ColorDefs.enabledButton,
                          shapex: ShapeDefs.redRoundedBorder,
                          onPressedx: () {
                            final FirestoreDatabase? firestoreDatabase =
                                context.read(databaseProvider);

                            final Map<String, String> newUserInfo = {
                              'email': technician.email,
                              'firstName': textControllerFirstName.text,
                              'lastName': textControllerLastName.text,
                              'filename': filename,
                              'uid': technician.id
                            };

                            firestoreDatabase!
                                .saveUserInfo(technician.id, newUserInfo);
                          },
                          childx: const Padding(
                            padding: PaddingDefs.primaryButtonPadding,
                            child: Text(
                              'Save',
                              style: StyleDefs.button1White,
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

String _onAvatarClicked(int index, BuildContext context) {
  debugPrint('You tapped on item ${NumberFormat('000').format(index)}');
  Navigator.of(context).pop();
  return 'avatar_${NumberFormat('000').format(index)}.svg';
}

class AvatarGrid extends StatelessWidget {
  const AvatarGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // BuildContext getContext() => context;
    final List<Widget> avatarPics = [];
    final NumberFormat f = NumberFormat('000');
    for (int i = 1; i < numberOfAvatars + 1; i++) {
      final String avatarName = 'avatar_${f.format(i)}.svg';
      final Widget widget = GestureDetector(
          onTap: () async {
            final String filename = _onAvatarClicked(i, context);
            print(filename);
            // context = getContext();
            context.read(filenameProvider).state = filename;
          },
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
      child: Scrollbar(
        isAlwaysShown: true,
        thickness: 20.0,
        child: GridView.count(
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            crossAxisCount: 5,
            children: avatarPics),
      ),
    );

    // return Container(
    //     width: 400,
    //     height: 400,
    //     child: GridView.count(crossAxisCount: 4, children: textPics));
    // return Text("Beer");
  }
}
