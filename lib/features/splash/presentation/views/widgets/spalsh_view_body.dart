import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:more_in/constant.dart';
import 'package:more_in/features/webview/presentation/view_model/web_view_cubit/web_view_cubit.dart';
import 'package:more_in/features/webview/presentation/views/webview_screen.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> fadingAnimation;
  @override
  void initState() {
    initAnimationController();
    initFadingAnimation();
    animationController.repeat(reverse: true);
    BlocProvider.of<WebViewCubit>(context).webViewData();
    goToNextView();
    super.initState();
  }

  void initFadingAnimation() {
    fadingAnimation = Tween<double>(
      begin: .2,
      end: 1,
    ).animate(animationController);
  }

  void initAnimationController() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: fadingAnimation,
        child: Image.asset(
          kLogo,
          width: MediaQuery.of(context).size.width * .8,
        ),
      ),
    );
  }

  void goToNextView() {
    Future.delayed(Duration(seconds: 1), () {
     Navigator.pushReplacement( context, MaterialPageRoute(builder: (context) => WebViewScreen()), );
    });
  }
}
