import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shopping_app/Network/Cache_helper.dart';
import 'package:shopping_app/login/login_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore: camel_case_types
class onboarding {
  final String image;
  final String title1;
  final String title2;

  onboarding({required this.image, required this.title1, required this.title2});
}

List<onboarding> onbord = [
  onboarding(
      image: 'assets/images/shop1.png',
      title1: 'Screen Title1',
      title2: 'Screen body1'),
  onboarding(
      image: 'assets/images/shopping2.png',
      title1: 'Screen Title2',
      title2: 'Screen body2'),
  onboarding(
      image: 'assets/images/shop1.png',
      title1: 'Screen Title3',
      title2: 'Screen body3'),
];

// ignore: must_be_immutable, camel_case_types
class onBoarding_Screen extends StatefulWidget {
  const onBoarding_Screen({
    super.key,
  });

  @override
  State<onBoarding_Screen> createState() => _onBoarding_ScreenState();
}

// ignore: camel_case_types
class _onBoarding_ScreenState extends State<onBoarding_Screen> {
  @override
  void initState() {
    super.initState();
  }

  var boardcontroller = PageController();
  bool islast = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10, top: 5),
            child: TextButton(
              onPressed: () {
                cache_helper()
                    .SaveData(key: 'isonbordingVisited', value: true)
                    .then(
                      (value) => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (ctx) => const login_page(),
                        ),
                      ),
                    );
              },
              child: Text(
                'Skip',
                style: GoogleFonts.cairo(
                  color: HexColor("#C93D3E"),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardcontroller,
                onPageChanged: (index) {
                  if (index == onbord.length - 1) {
                    setState(() {
                      islast = true;
                    });
                    // ignore: avoid_print
                    print('last');
                  } else {
                    setState(() {
                      islast = false;
                    });
                    // ignore: avoid_print
                    print('not last');
                  }
                },
                itemBuilder: (context, index) {
                  return defultHomePage(
                    onboarding(
                      image: onbord[index].image,
                      title1: onbord[index].title1,
                      title2: onbord[index].title2,
                    ),
                  );
                },
                itemCount: onbord.length,
                physics: const BouncingScrollPhysics(),
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardcontroller,
                  count: onbord.length,
                  effect: ExpandingDotsEffect(
                    dotColor: HexColor('#878C8D'),
                    dotHeight: 11,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5.0,
                    activeDotColor: HexColor("#C93D3E"),
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (islast) {
                      cache_helper()
                          .SaveData(key: 'isonbordingVisited', value: true)
                          .then(
                            (value) => Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (ctx) => const login_page(),
                              ),
                            ),
                          );
                    } else {
                      boardcontroller.nextPage(
                          duration: const Duration(milliseconds: 700),
                          curve: Curves.fastEaseInToSlowEaseOut);
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget defultHomePage(onboarding model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Image.asset(model.image)),
        Text(model.title1, style: GoogleFonts.cairo(fontSize: 27)),
        const SizedBox(height: 20),
        Text(
          model.title2,
          style: GoogleFonts.cairo(fontSize: 22),
        ),
        const SizedBox(height: 80),
      ],
    );
