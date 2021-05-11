import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class RiveAnimation extends StatefulWidget {
  const RiveAnimation({Key? key}) : super(key: key);

  @override
  _RiveAnimationState createState() => _RiveAnimationState();
}

class _RiveAnimationState extends State<RiveAnimation>
    with SingleTickerProviderStateMixin {
  // void _togglePlay() {
  //   setState(() => _controller.isActive = !_controller.isActive);
  // }

  /// Tracks if the animation is playing by whether controller is running.
  bool get isPlaying => _controller?.isActive ?? false;

  Artboard? _riveArtboard;
  RiveAnimationController? _controller;
  @override
  void initState() {
    super.initState();

    // Load the animation file from the bundle, note that you could also
    // download this. The RiveFile just expects a list of bytes.
    rootBundle.load('assets/rive/mxotechNewVersion.riv').then(
      // rootBundle.load('assets/rive/MXOtech-stop-hug2.riv').then(
      (data) async {
        final file = RiveFile.import(data);

        // Load the RiveFile from the binary data.
        // if (file.import(data)) {
        // The artboard is the root of the animation and gets drawn in the
        // Rive widget.
        final artboard = file.mainArtboard;
        // Add a controller to play back a known animation on the main/default
        // artboard.We store a reference to it so we can toggle playback.
        artboard.addController(_controller = SimpleAnimation('Animation 1'));
        setState(() => _riveArtboard = artboard);
        // }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return
        // Scaffold(
        // body:
        Center(
      child: _riveArtboard == null
          ? const SizedBox()
          : Rive(artboard: _riveArtboard!),
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _togglePlay,
      //   tooltip: isPlaying ? 'Pause' : 'Play',
      //   child: Icon(
      //     isPlaying ? Icons.pause : Icons.play_arrow,
      //   ),
      // ),
    );
  }
}
