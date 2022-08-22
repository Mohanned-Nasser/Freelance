import 'package:catcare/util/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../util/app_style.dart';
import '../../widgets/custom_appbar.dart';
import '../drawer_screen.dart';

class VideoPlayerScreen extends StatefulWidget {
  String? videoUrl;

  VideoPlayerScreen({Key? key, this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey(); // add this
  YoutubePlayerController? _controller;


  bool isPause = true;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    setState(() {
    _controller=YoutubePlayerController(
      initialVideoId:YoutubePlayer.convertUrlToId(widget.videoUrl!)!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        loop: true,
      ),
    );


    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if(_controller!=null) {
      _controller!.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: gradientBackground(),
        child: Scaffold(
          key: _key,
          backgroundColor: Colors.transparent,
          endDrawer: DrawerScreen(),
          appBar: customAppBar(
            context: context,
            title: "TRAIN",
            drawerAction: () {
              _key.currentState!.openEndDrawer();
            },
          ),
          body: _controller == null
              ? CircularProgressIndicator.adaptive()
              : videoContainer(_controller!),
        ),
      ),
    );
  }

  videoContainer(YoutubePlayerController _controller) {
    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      progressIndicatorColor: AppColors.appOrangeColor,

    );
  }
}
