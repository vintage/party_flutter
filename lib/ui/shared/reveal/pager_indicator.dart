import 'dart:ui';

import 'package:flutter/material.dart';

import '../../theme.dart';
import 'pages.dart';

class PagerIndicator extends StatelessWidget {
  final PagerIndicatorViewModel viewModel;

  PagerIndicator({
    this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    List<PageBubble> bubbles = [];
    for (var i = 0; i < viewModel.pages.length; ++i) {
      final page = viewModel.pages[i];

      var percentActive;
      if (i == viewModel.activeIndex) {
        percentActive = 1.0 - viewModel.slidePercent;
      } else if (i == viewModel.activeIndex - 1 &&
          viewModel.slideDirection == SlideDirection.leftToRight) {
        percentActive = viewModel.slidePercent;
      } else if (i == viewModel.activeIndex + 1 &&
          viewModel.slideDirection == SlideDirection.rightToLeft) {
        percentActive = viewModel.slidePercent;
      } else {
        percentActive = 0.0;
      }

      bool isHollow = i != viewModel.activeIndex;

      bubbles.add(
        PageBubble(
          viewModel: PageBubbleViewModel(
            page.color,
            isHollow,
            percentActive,
          ),
        ),
      );
    }

    return Column(
      children: [
        Expanded(child: Container()),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: bubbles,
          ),
        ),
      ],
    );
  }
}

enum SlideDirection {
  leftToRight,
  rightToLeft,
  none,
}

class PagerIndicatorViewModel {
  final List<PageViewModel> pages;
  final int activeIndex;
  final SlideDirection slideDirection;
  final double slidePercent;

  PagerIndicatorViewModel(
    this.pages,
    this.activeIndex,
    this.slideDirection,
    this.slidePercent,
  );
}

class PageBubble extends StatelessWidget {
  final PageBubbleViewModel viewModel;

  PageBubble({
    this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    Color color = secondaryDarkColor;

    return Container(
      width: 25.0,
      height: 55.0,
      child: Center(
        child: Container(
          width: lerpDouble(12.0, 16.0, viewModel.activePercent),
          height: lerpDouble(12.0, 16.0, viewModel.activePercent),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(2.0),
            color: viewModel.isHollow
                ? color.withOpacity(viewModel.activePercent)
                : secondaryColor,
            border: Border.all(
              color: viewModel.isHollow
                  ? color.withOpacity(1 - viewModel.activePercent)
                  : Colors.transparent,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}

class PageBubbleViewModel {
  final Color color;
  final bool isHollow;
  final double activePercent;

  PageBubbleViewModel(
    this.color,
    this.isHollow,
    this.activePercent,
  );
}
