import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';
import 'de_locale_helper.dart';

void main() {
  Widget wrap(Widget child) {
    return MaterialApp(
      theme: ThemeData(extensions: [BsThemeData.lightTheme]),
      home: Scaffold(body: child),
    );
  }

  group('BsCarousel Tests', () {
    testWidgets('renders basic layout with items and captions', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          const BsCarousel(
            autoplay: false,
            items: [
              BsCarouselItem(
                caption: BsCarouselCaption(
                  title: Text('Slide 1 Title'),
                  description: Text('Slide 1 Description'),
                ),
                child: Text('Item 1 Content'),
              ),
              BsCarouselItem(
                child: Text('Item 2 Content'),
              ),
            ],
          ),
        ),
      );

      // Verify first slide items are visible
      expect(find.text('Item 1 Content'), findsOneWidget);
      expect(find.text('Slide 1 Title'), findsOneWidget);
      expect(find.text('Slide 1 Description'), findsOneWidget);

      // Verify second slide is not visible initially
      expect(find.text('Item 2 Content'), findsNothing);
    });

    testWidgets('respects initialIndex parameter', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          const BsCarousel(
            autoplay: false,
            initialIndex: 1,
            items: [
              BsCarouselItem(child: Text('Item 1')),
              BsCarouselItem(child: Text('Item 2')),
            ],
          ),
        ),
      );

      expect(find.text('Item 1'), findsNothing);
      expect(find.text('Item 2'), findsOneWidget);
    });

    testWidgets('navigates via prev/next controls', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          const BsCarousel(
            autoplay: false,
            items: [
              BsCarouselItem(child: Text('Item 1')),
              BsCarouselItem(child: Text('Item 2')),
              BsCarouselItem(child: Text('Item 3')),
            ],
          ),
        ),
      );

      expect(find.text('Item 1'), findsOneWidget);

      // Tap Next Control (chevron_right icon button)
      final nextFinder = find.byIcon(Icons.chevron_right_rounded);
      expect(nextFinder, findsOneWidget);
      await tester.tap(nextFinder);
      await tester.pumpAndSettle();

      expect(find.text('Item 1'), findsNothing);
      expect(find.text('Item 2'), findsOneWidget);

      // Tap Next again
      await tester.tap(nextFinder);
      await tester.pumpAndSettle();
      expect(find.text('Item 3'), findsOneWidget);

      // Tap Next again to wrap around to the first slide
      await tester.tap(nextFinder);
      await tester.pumpAndSettle();
      expect(find.text('Item 1'), findsOneWidget);

      // Tap Prev Control (chevron_left icon button) to wrap backwards
      final prevFinder = find.byIcon(Icons.chevron_left_rounded);
      expect(prevFinder, findsOneWidget);
      await tester.tap(prevFinder);
      await tester.pumpAndSettle();
      expect(find.text('Item 3'), findsOneWidget);
    });

    testWidgets('navigates via clicking indicators', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          const BsCarousel(
            autoplay: false,
            items: [
              BsCarouselItem(child: Text('Item A')),
              BsCarouselItem(child: Text('Item B')),
            ],
          ),
        ),
      );

      expect(find.text('Item A'), findsOneWidget);

      // Inactive indicator at index 1
      final indicatorsRowFinder = find.byType(Row).last;
      final indicatorFinder = find.descendant(of: indicatorsRowFinder, matching: find.byType(GestureDetector)).at(1);

      await tester.tap(indicatorFinder);
      await tester.pumpAndSettle();

      expect(find.text('Item A'), findsNothing);
      expect(find.text('Item B'), findsOneWidget);
    });

    testWidgets('supports dynamic autoplay cycling with default and per-slide intervals', (WidgetTester tester) async {
      int slideChangedCount = 0;
      int activeIndex = 0;

      await tester.pumpWidget(
        wrap(
          BsCarousel(
            autoplay: true,
            defaultInterval: const Duration(milliseconds: 100),
            onSlideChanged: (index) {
              slideChangedCount++;
              activeIndex = index;
            },
            items: const [
              BsCarouselItem(
                interval: Duration(milliseconds: 50),
                child: Text('Slide 1'),
              ),
              BsCarouselItem(child: Text('Slide 2')),
              BsCarouselItem(child: Text('Slide 3')),
            ],
          ),
        ),
      );

      expect(find.text('Slide 1'), findsOneWidget);

      // Wait 60ms: Slide 1 has a 50ms interval, so it should advance
      await tester.pump(const Duration(milliseconds: 60));
      expect(activeIndex, 1);
      expect(slideChangedCount, 1);

      // Now at Slide 2, which has no custom interval, so it uses the default 100ms
      // Wait 60ms: Should still be at Slide 2
      await tester.pump(const Duration(milliseconds: 60));
      expect(activeIndex, 1);

      // Wait another 50ms (total 110ms): Should cycle to Slide 3
      await tester.pump(const Duration(milliseconds: 50));
      expect(activeIndex, 2);
      expect(slideChangedCount, 2);
    });

    testWidgets('supports fade transition and swipe gestures', (WidgetTester tester) async {
      int activeIndex = 0;

      await tester.pumpWidget(
        wrap(
          BsCarousel(
            autoplay: false,
            fade: true,
            onSlideChanged: (index) {
              activeIndex = index;
            },
            items: const [
              BsCarouselItem(child: Text('Slide X')),
              BsCarouselItem(child: Text('Slide Y')),
            ],
          ),
        ),
      );

      expect(find.text('Slide X'), findsOneWidget);

      // Simulate a swipe left to go to the next slide
      await tester.fling(find.text('Slide X'), const Offset(-300, 0), 1000);
      await tester.pumpAndSettle();

      expect(activeIndex, 1);
      expect(find.text('Slide Y'), findsOneWidget);
    });

    testWidgets('applies dark variant styling to captions', (WidgetTester tester) async {
      // Light Mode Carousel (dark = false) -> text should be white
      await tester.pumpWidget(
        wrap(
          const BsCarousel(
            autoplay: false,
            dark: false,
            items: [
              BsCarouselItem(
                caption: BsCarouselCaption(
                  title: Text('White Title'),
                ),
                child: SizedBox(),
              ),
            ],
          ),
        ),
      );

      final titleText1 = tester.widget<DefaultTextStyle>(
        find.ancestor(of: find.text('White Title'), matching: find.byType(DefaultTextStyle)).first,
      );
      expect(titleText1.style.color, Colors.white);

      // Dark Mode Carousel (dark = true) -> text should be dark gray (#212529)
      await tester.pumpWidget(
        wrap(
          const BsCarousel(
            autoplay: false,
            dark: true,
            items: [
              BsCarouselItem(
                caption: BsCarouselCaption(
                  title: Text('Dark Title'),
                ),
                child: SizedBox(),
              ),
            ],
          ),
        ),
      );

      final titleText2 = tester.widget<DefaultTextStyle>(
        find.ancestor(of: find.text('Dark Title'), matching: find.byType(DefaultTextStyle)).first,
      );
      expect(titleText2.style.color, const Color(0xFF212529));
    });
    testWidgets('supports accessibility semantics in English (default)', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          const BsCarousel(
            autoplay: false,
            items: [
              BsCarouselItem(child: SizedBox()),
              BsCarouselItem(child: SizedBox()),
            ],
          ),
        ),
      );

      // Verify container semantics
      final containerSemantics = find.byWidgetPredicate(
        (widget) => widget is Semantics &&
            widget.container == true &&
            widget.properties.label == 'Image carousel',
      );
      expect(containerSemantics, findsOneWidget);

      // Verify controls semantics (Previous slide & Next slide)
      final prevSemantics = find.byWidgetPredicate(
        (widget) => widget is Semantics &&
            widget.properties.button == true &&
            widget.properties.label == 'Previous slide',
      );
      expect(prevSemantics, findsOneWidget);

      final nextSemantics = find.byWidgetPredicate(
        (widget) => widget is Semantics &&
            widget.properties.button == true &&
            widget.properties.label == 'Next slide',
      );
      expect(nextSemantics, findsOneWidget);

      // Verify indicators semantics
      final indicator1Semantics = find.byWidgetPredicate(
        (widget) => widget is Semantics &&
            widget.properties.button == true &&
            widget.properties.label == 'Go to slide 1' &&
            widget.properties.selected == true,
      );
      expect(indicator1Semantics, findsOneWidget);

      final indicator2Semantics = find.byWidgetPredicate(
        (widget) => widget is Semantics &&
            widget.properties.button == true &&
            widget.properties.label == 'Go to slide 2' &&
            widget.properties.selected == false,
      );
      expect(indicator2Semantics, findsOneWidget);
    });

    testWidgets('automatically localizes accessibility semantics when locale is de', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(extensions: [BsThemeData.lightTheme]),
          locale: const Locale('de'),
          supportedLocales: const [Locale('de'), Locale('en')],
          localizationsDelegates: const [
            ...deLocalizationsDelegates,
            DefaultMaterialLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
            _TestBsLocalizationsDelegate(
              carouselContainer: 'Bildkarussell',
              carouselPrev: 'Vorheriges Bild',
              carouselNext: 'Nächstes Bild',
              carouselIndicatorPrefix: 'Gehe zu Bild ',
            ),
          ],
          home: const Scaffold(
            body: BsCarousel(
              autoplay: false,
              items: [
                BsCarouselItem(child: SizedBox()),
                BsCarouselItem(child: SizedBox()),
              ],
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify container semantics
      final containerSemantics = find.byWidgetPredicate(
        (widget) => widget is Semantics &&
            widget.container == true &&
            widget.properties.label == 'Bildkarussell',
      );
      expect(containerSemantics, findsOneWidget);

      // Verify controls semantics (Vorheriges Bild & Nächstes Bild)
      final prevSemantics = find.byWidgetPredicate(
        (widget) => widget is Semantics &&
            widget.properties.button == true &&
            widget.properties.label == 'Vorheriges Bild',
      );
      expect(prevSemantics, findsOneWidget);

      final nextSemantics = find.byWidgetPredicate(
        (widget) => widget is Semantics &&
            widget.properties.button == true &&
            widget.properties.label == 'Nächstes Bild',
      );
      expect(nextSemantics, findsOneWidget);

      // Verify indicators semantics
      final indicatorSemantics = find.byWidgetPredicate(
        (widget) => widget is Semantics &&
            widget.properties.button == true &&
            widget.properties.label == 'Gehe zu Bild 1' &&
            widget.properties.selected == true,
      );
      expect(indicatorSemantics, findsOneWidget);
    });
  });
}

class _TestBsLocalizations extends BsLocalizations {
  _TestBsLocalizations(
    super.locale, {
    required this.carouselContainer,
    required this.carouselPrev,
    required this.carouselNext,
    required this.carouselIndicatorPrefix,
  });

  @override
  final String carouselContainer;
  @override
  final String carouselPrev;
  @override
  final String carouselNext;
  final String carouselIndicatorPrefix;

  @override
  String carouselIndicator(int index) {
    return '$carouselIndicatorPrefix${index + 1}';
  }
}

class _TestBsLocalizationsDelegate extends LocalizationsDelegate<BsLocalizations> {
  const _TestBsLocalizationsDelegate({
    required this.carouselContainer,
    required this.carouselPrev,
    required this.carouselNext,
    required this.carouselIndicatorPrefix,
  });

  final String carouselContainer;
  final String carouselPrev;
  final String carouselNext;
  final String carouselIndicatorPrefix;

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<BsLocalizations> load(Locale locale) async {
    return _TestBsLocalizations(
      locale,
      carouselContainer: carouselContainer,
      carouselPrev: carouselPrev,
      carouselNext: carouselNext,
      carouselIndicatorPrefix: carouselIndicatorPrefix,
    );
  }

  @override
  bool shouldReload(_TestBsLocalizationsDelegate old) => false;
}
