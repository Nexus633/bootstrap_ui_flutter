import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bootstrap_ui_flutter/bootstrap_ui_flutter.dart';

void main() {
  Widget buildTestableWidget(WidgetTester tester, Widget child, {double width = 1200}) {
    tester.view.physicalSize = Size(width, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    return MaterialApp(
      theme: ThemeData(
        extensions: [BsThemeData.lightTheme],
      ),
      home: Scaffold(
        body: MediaQuery(
          data: MediaQueryData(size: Size(width, 800)),
          child: child,
        ),
      ),
    );
  }

  group('BsNavbar Tests', () {
    testWidgets('renders brand, links, and text correctly on large screen', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          tester,
          BsNavbar(
            brand: const BsNavbarBrand(child: Text('BrandTitle')),
            collapse: const BsNavbarCollapse(
              children: [
                BsNavbarNav(
                  children: [
                    BsNavbarLink(label: 'Home', active: true),
                    BsNavbarLink(label: 'Link'),
                    BsNavbarLink(label: 'Disabled', disabled: true),
                  ],
                ),
                BsNavbarText(child: Text('Inline text')),
              ],
            ),
          ),
          width: 1200, // Large screen (lg breakpoint = 992px)
        ),
      );

      // Verify Brand title is rendered
      expect(find.text('BrandTitle'), findsOneWidget);

      // Verify Nav links are rendered
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Link'), findsOneWidget);
      expect(find.text('Disabled'), findsOneWidget);

      // Verify Text is rendered
      expect(find.text('Inline text'), findsOneWidget);

      // Toggler should NOT be visible on desktop size
      expect(find.byType(BsNavbarToggler), findsNothing);

      // Verify links are rendered horizontally (Row) inside the BsNavbarNav
      final navRowFinder = find.byType(Row);
      expect(navRowFinder, findsWidgets);
    });

    testWidgets('hides collapse content and displays toggler on small screen', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          tester,
          BsNavbar(
            brand: const BsNavbarBrand(child: Text('BrandTitle')),
            collapse: const BsNavbarCollapse(
              children: [
                BsNavbarNav(
                  children: [
                    BsNavbarLink(label: 'Home'),
                  ],
                ),
              ],
            ),
          ),
          width: 500, // Small screen (< md/lg)
        ),
      );

      // Verify Brand is still visible
      expect(find.text('BrandTitle'), findsOneWidget);

      // Toggler MUST be visible on mobile size
      expect(find.byType(BsNavbarToggler), findsOneWidget);

      // The collapse content should be initially closed (SizeTransition height = 0)
      final sizeTransition = tester.widget<SizeTransition>(
        find.byType(SizeTransition),
      );
      expect(sizeTransition.sizeFactor.value, 0.0);
    });

    testWidgets('taps toggler to expand collapse content on small screen', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          tester,
          BsNavbar(
            brand: const BsNavbarBrand(child: Text('BrandTitle')),
            collapse: const BsNavbarCollapse(
              children: [
                BsNavbarNav(
                  children: [
                    BsNavbarLink(label: 'Home'),
                  ],
                ),
              ],
            ),
          ),
          width: 500, // Small screen
        ),
      );

      // Tap on toggler
      await tester.tap(find.byType(BsNavbarToggler));
      await tester.pumpAndSettle();

      // The collapse content should now be fully open (SizeTransition height = 1.0)
      final sizeTransition = tester.widget<SizeTransition>(
        find.byType(SizeTransition),
      );
      expect(sizeTransition.sizeFactor.value, 1.0);
      expect(find.text('Home'), findsOneWidget);

      // Tap toggler again to collapse
      await tester.tap(find.byType(BsNavbarToggler));
      await tester.pumpAndSettle();
      expect(sizeTransition.sizeFactor.value, 0.0);
    });

    testWidgets('disabled link does not trigger onPressed callback', (WidgetTester tester) async {
      bool linkTapped = false;

      await tester.pumpWidget(
        buildTestableWidget(
          tester,
          BsNavbar(
            collapse: BsNavbarCollapse(
              children: [
                BsNavbarNav(
                  children: [
                    BsNavbarLink(
                      label: 'DisabledLink',
                      disabled: true,
                      onPressed: () {
                        linkTapped = true;
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

      await tester.tap(find.text('DisabledLink'));
      await tester.pumpAndSettle();

      expect(linkTapped, isFalse);
    });

    testWidgets('brand callback triggers when tapped', (WidgetTester tester) async {
      bool brandTapped = false;

      await tester.pumpWidget(
        buildTestableWidget(
          tester,
          BsNavbar(
            brand: BsNavbarBrand(
              child: const Text('BrandTitle'),
              onPressed: () {
                brandTapped = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('BrandTitle'));
      await tester.pumpAndSettle();

      expect(brandTapped, isTrue);
    });

    testWidgets('applies custom variant and color to links and brand', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          tester,
          BsNavbar(
            brand: const BsNavbarBrand(
              variant: BsVariant.danger,
              child: Text('CustomBrand'),
            ),
            collapse: const BsNavbarCollapse(
              children: [
                BsNavbarNav(
                  children: [
                    BsNavbarLink(
                      label: 'CustomLink',
                      color: Colors.purple,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('CustomBrand'), findsOneWidget);
      expect(find.text('CustomLink'), findsOneWidget);

      final DefaultTextStyle brandDefaultStyle = tester.widget<DefaultTextStyle>(find.descendant(
        of: find.byType(BsNavbarBrand),
        matching: find.byType(DefaultTextStyle),
      ).first);
      final linkText = tester.widget<Text>(find.descendant(
        of: find.byType(BsNavbarLink),
        matching: find.byType(Text),
      ));

      expect(brandDefaultStyle.style.color, isNotNull);
      expect(linkText.style?.color, Colors.purple);
    });

    testWidgets('BsNavbarSpacer behaves responsively', (WidgetTester tester) async {
      // 1. Desktop size (expanded) -> should render Spacer behavior (Expanded)
      await tester.pumpWidget(
        buildTestableWidget(
          tester,
          const BsNavbar(
            collapse: BsNavbarCollapse(
              children: [
                BsNavbarSpacer(),
              ],
            ),
          ),
          width: 1200,
        ),
      );
      expect(
        find.descendant(
          of: find.byType(BsNavbarCollapse),
          matching: find.byType(Flexible),
        ),
        findsOneWidget,
      );

      // 2. Mobile size (collapsed) -> should collapse (no Expanded spacer behavior)
      await tester.pumpWidget(
        buildTestableWidget(
          tester,
          const BsNavbar(
            collapse: BsNavbarCollapse(
              children: [
                BsNavbarSpacer(),
              ],
            ),
          ),
          width: 500,
        ),
      );
      expect(
        find.descendant(
          of: find.byType(BsNavbarCollapse),
          matching: find.byType(Flexible),
        ),
        findsNothing,
      );
    });

    testWidgets('renders BsNavbarIconBrand correctly', (WidgetTester tester) async {
      bool iconTapped = false;
      await tester.pumpWidget(
        buildTestableWidget(
          tester,
          BsNavbar(
            brand: BsNavbarIconBrand(
              onPressed: () => iconTapped = true,
              child: const Icon(Icons.star),
            ),
          ),
        ),
      );

      expect(find.byType(BsNavbarIconBrand), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);

      await tester.tap(find.byType(BsNavbarIconBrand));
      await tester.pumpAndSettle();
      expect(iconTapped, isTrue);
    });

    testWidgets('renders BsNavbarIconBrand.network correctly', (WidgetTester tester) async {
      debugNetworkImageHttpClientProvider = () => _MockHttpClient();

      await tester.pumpWidget(
        buildTestableWidget(
          tester,
          BsNavbar(
            brand: BsNavbarIconBrand.network(
              'https://example.com/logo.png',
            ),
          ),
        ),
      );

      expect(find.byType(BsNavbarIconBrand), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);

      debugNetworkImageHttpClientProvider = null;
    });

    testWidgets('renders fallback icon when BsNavbarIconBrand.network fails to load', (WidgetTester tester) async {
      debugNetworkImageHttpClientProvider = () => _MockHttpClient(404);

      await tester.pumpWidget(
        buildTestableWidget(
          tester,
          BsNavbar(
            brand: BsNavbarIconBrand.network(
              'https://example.com/nonexistent.png',
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(BsNavbarIconBrand), findsOneWidget);
      expect(find.byIcon(Icons.broken_image), findsOneWidget);

      debugNetworkImageHttpClientProvider = null;
    });
  });
}

// ─── HTTP Mocking Classes for NetworkImage Widget Tests ───────────────────────

final List<int> _transparentGif = base64Decode(
  'R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7',
);

class _MockHttpClient implements HttpClient {
  final int statusCode;
  _MockHttpClient([this.statusCode = 200]);

  @override
  dynamic noSuchMethod(Invocation invocation) {
    if (invocation.memberName == #getUrl) {
      return Future.value(_MockHttpClientRequest(statusCode));
    }
    return super.noSuchMethod(invocation);
  }
}

class _MockHttpClientRequest implements HttpClientRequest {
  final int statusCode;
  _MockHttpClientRequest([this.statusCode = 200]);

  @override
  dynamic noSuchMethod(Invocation invocation) {
    if (invocation.memberName == #headers) {
      return _MockHttpHeaders();
    }
    if (invocation.memberName == #close) {
      return Future.value(_MockHttpClientResponse(statusCode));
    }
    if (invocation.memberName == #done) {
      return Future.value(_MockHttpClientResponse(statusCode));
    }
    return super.noSuchMethod(invocation);
  }
}

class _MockHttpHeaders implements HttpHeaders {
  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

class _MockHttpClientResponse extends Stream<List<int>> implements HttpClientResponse {
  final int _statusCode;
  _MockHttpClientResponse([this._statusCode = 200]);

  @override
  dynamic noSuchMethod(Invocation invocation) {
    if (invocation.memberName == #statusCode) {
      return _statusCode;
    }
    if (invocation.memberName == #contentLength) {
      return _transparentGif.length;
    }
    if (invocation.memberName == #compressionState) {
      return HttpClientResponseCompressionState.notCompressed;
    }
    return super.noSuchMethod(invocation);
  }

  @override
  StreamSubscription<List<int>> listen(
    void Function(List<int> event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return Stream<List<int>>.fromIterable([_transparentGif]).listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }
}

