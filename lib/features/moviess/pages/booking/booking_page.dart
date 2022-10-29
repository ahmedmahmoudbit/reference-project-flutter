import 'package:flutter/material.dart';
import 'package:reference_project_flutter/features/chat-ui/chatPage.dart';

import '../../constants/text_style.dart';
import '../../models/model_movies.dart';
import '../movies_page/widgets/dot_indicator.dart';
import 'animation/booking_page_animation_controller.dart';

class BookingPage extends StatefulWidget {
const BookingPage({
Key? key,
required this.movie,
}) : super(key: key);

final Movie movie;

@override
State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage>
    with TickerProviderStateMixin {
  late final BookingPageAnimationController _controller;

  bool isShow = false;

  void changeDesign() {
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        isShow = true;
      });
    });
  }

  @override
  void initState() {
    _controller = BookingPageAnimationController(
      buttonController: AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this,
      ),
      contentController: AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this,
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _controller.buttonController.forward();
      await _controller.buttonController.reverse();
      await _controller.contentController.forward();
    });

    changeDesign();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final w = constraints.maxWidth;
      final h = constraints.maxHeight;

      return Scaffold(
        extendBodyBehindAppBar: true,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            isShow ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                separatorBuilder: (_,i)=> SizedBox(height: 10
                  ,),
                shrinkWrap: true,
                itemBuilder: (_,i)=> Container(
                  color: Colors.blueAccent.withOpacity(0.2),
                  height: 100,
                  width: 100,
                ),
                itemCount: 15,
              ),
            ) : Container(width: w,height: h,color: Colors.white,),
            Positioned(
              bottom: 0,
              child: GestureDetector(
                onTap: () {
                  const transitionDuration = Duration(milliseconds: 400);
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      transitionDuration: transitionDuration,
                      reverseTransitionDuration: transitionDuration,
                      pageBuilder: (_, animation, ___) {
                        return FadeTransition(
                          opacity: animation,
                          child: ChatPage(),
                        );
                      },
                    ),
                  );
                },
                child: AnimatedBuilder(
                  animation: _controller.buttonController,
                  builder: (_, child) {
                    final size = _controller
                        .buttonSizeAnimation(
                      Size(w * .7, h * .06),
                      Size(w * 1.2, h * 1.1),
                    )
                        .value;
                    final margin =
                        _controller.buttonMarginAnimation(h * .03).value;
                    return Container(
                      width: size.width,
                      height: size.height,
                      margin: EdgeInsets.only(bottom: margin),
                      decoration: const BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              bottom: h * .05,
              child: const IgnorePointer(
                child: Text(
                  'Buy Ticket',
                  style: AppTextStyles.bookButtonTextStyle,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}