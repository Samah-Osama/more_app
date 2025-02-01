// import 'package:flutter/material.dart';
// import 'package:loading_indicator/loading_indicator.dart';
// import 'package:more_in/constant.dart';

// class CustomLoadingIndicator extends StatelessWidget {
//   const CustomLoadingIndicator({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: MediaQuery.of(context).size.height * .2,
//       child: LoadingIndicator(
//         indicatorType: Indicator.ballScaleMultiple,
//         // backgroundColor: Colors.white,
//         colors: [kMainColor],
//       ),
//     );
//   }
// }
// // class CustomLoadingIndicator extends StatefulWidget {
// //   const CustomLoadingIndicator({super.key});

// //   @override
// //   State<CustomLoadingIndicator> createState() => _CustomLoadingIndicatorState();
// // }

// // class _CustomLoadingIndicatorState extends State<CustomLoadingIndicator>
// //     with SingleTickerProviderStateMixin {
// //   late AnimationController animationController;
// //   late Animation<double> fadingAnimation;
// //   @override
// //   void initState() {
// //     initAnimationController();
// //     initFadingAnimation();
// //     animationController.repeat(reverse: true);
// //     super.initState();
// //   }

// //   void initFadingAnimation() {
// //     fadingAnimation = Tween<double>(
// //       begin: 1,
// //       end: .1,
// //     ).animate(animationController);
// //   }

// //   void initAnimationController() {
// //     animationController = AnimationController(
// //       vsync: this,
// //       duration: Duration(seconds: 3),
// //     );
// //   }

// //   @override
// //   void dispose() {
// //     animationController.dispose();
// //     super.dispose();
// //   }


// //   @override
// //   Widget build(BuildContext context) {
// //     return Center(
// //       child: FadeTransition(
// //         opacity: fadingAnimation,
// //         child: Image.asset(
// //           kLogo,
// //           width: MediaQuery.of(context).size.width * .8,
// //         ),
// //       ),
// //     );
// //   }
// // }
 