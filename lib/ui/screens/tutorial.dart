import 'dart:async';

import 'package:flutter/material.dart';

import 'package:zgadula/localizations.dart';
import 'package:zgadula/store/tutorial.dart';
import '../shared/reveal/widgets.dart';

class TutorialScreen extends StatefulWidget {
  @override
  TutorialScreenState createState() => TutorialScreenState();
}

class TutorialScreenState extends State<TutorialScreen>
    with TickerProviderStateMixin {
  StreamController<SlideUpdate> slideUpdateStream;
  AnimatedPageDragger animatedPageDragger;

  int activeIndex = 0;
  int nextPageIndex = 0;
  SlideDirection slideDirection = SlideDirection.none;
  double slidePercent = 0.0;

  TutorialScreenState() {
    slideUpdateStream = StreamController<SlideUpdate>();
    slideUpdateStream.stream.listen((SlideUpdate event) {
      setState(() {
        if (event.updateType == UpdateType.dragging) {
          slideDirection = event.direction;
          slidePercent = event.slidePercent;

          if (slideDirection == SlideDirection.leftToRight) {
            nextPageIndex = activeIndex - 1;
          } else if (slideDirection == SlideDirection.rightToLeft) {
            nextPageIndex = activeIndex + 1;
          } else {
            nextPageIndex = activeIndex;
          }
        } else if (event.updateType == UpdateType.doneDragging) {
          if (slidePercent > 0.2) {
            animatedPageDragger = AnimatedPageDragger(
              slideDirection: slideDirection,
              transitionGoal: TransitionGoal.open,
              slidePercent: slidePercent,
              slideUpdateStream: slideUpdateStream,
              vsync: this,
            );
          } else {
            animatedPageDragger = AnimatedPageDragger(
              slideDirection: slideDirection,
              transitionGoal: TransitionGoal.close,
              slidePercent: slidePercent,
              slideUpdateStream: slideUpdateStream,
              vsync: this,
            );

            nextPageIndex = activeIndex;
          }

          animatedPageDragger.run();
        } else if (event.updateType == UpdateType.animating) {
          slideDirection = event.direction;
          slidePercent = event.slidePercent;
        } else if (event.updateType == UpdateType.doneAnimating) {
          activeIndex = nextPageIndex;

          slideDirection = SlideDirection.none;
          slidePercent = 0.0;

          animatedPageDragger.dispose();
        }
      });
    });
  }

  @override
  void initState() {
    TutorialModel.of(context).watch();
    super.initState();
  }

  @override
  dispose() {
    super.dispose();

    slideUpdateStream.close();
  }

  skipTutorial() {
    Navigator.pop(context);
  }

  List<PageViewModel> getPages(BuildContext context) {
    final pages = [
      PageViewModel(
        Theme.of(context).primaryColor,
        'assets/images/tutorial_1.png',
        AppLocalizations.of(context).tutorialFirstSectionHeader,
        AppLocalizations.of(context).tutorialFirstSectionDescription,
        AppLocalizations.of(context).tutorialSkip,
      ),
      PageViewModel(
        Theme.of(context).primaryColorDark,
        'assets/images/tutorial_2.png',
        AppLocalizations.of(context).tutorialSecondSectionHeader,
        AppLocalizations.of(context).tutorialSecondSectionDescription,
        AppLocalizations.of(context).tutorialSkip,
      ),
      PageViewModel(
        Theme.of(context).primaryColor,
        'assets/images/tutorial_3.png',
        AppLocalizations.of(context).tutorialThirdSectionHeader,
        AppLocalizations.of(context).tutorialThirdSectionDescription,
        AppLocalizations.of(context).tutorialSkip,
      ),
      PageViewModel(
        Theme.of(context).primaryColorDark,
        'assets/images/tutorial_4.png',
        AppLocalizations.of(context).tutorialFourthSectionHeader,
        AppLocalizations.of(context).tutorialFourthSectionDescription,
        AppLocalizations.of(context).tutorialSkip,
      ),
    ];

    return pages;
  }

  @override
  Widget build(BuildContext context) {
    List<PageViewModel> pages = getPages(context);

    return Scaffold(
      body: Stack(
        children: [
          Page(
            viewModel: pages[activeIndex],
            percentVisible: 1.0,
            onSkip: skipTutorial,
          ),
          PageReveal(
            revealPercent: slidePercent,
            child: Page(
              viewModel: pages[nextPageIndex],
              percentVisible: slidePercent,
              onSkip: skipTutorial,
            ),
          ),
          PagerIndicator(
            viewModel: PagerIndicatorViewModel(
              pages,
              activeIndex,
              slideDirection,
              slidePercent,
            ),
          ),
          PageDragger(
            canDragLeftToRight: activeIndex > 0,
            canDragRightToLeft: activeIndex < pages.length - 1,
            slideUpdateStream: this.slideUpdateStream,
          ),
        ],
      ),
    );
  }
}
