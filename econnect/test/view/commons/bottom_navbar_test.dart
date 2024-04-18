import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:econnect/view/commons/bottom_navbar.dart';

import 'bottom_navbar_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<NavigatorObserver>(onMissingStub: OnMissingStub.returnDefault),
])
void main() {
  group('BottomNavbar Widget Tests', () {
    testWidgets('Widget renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: BottomNavbar(),
          ),
        ),
      );

      expect(find.byType(BottomNavigationBar), findsOneWidget);

      expect(find.byIcon(LucideIcons.home), findsOneWidget);
      expect(find.byIcon(LucideIcons.copyPlus), findsOneWidget);
    });

    testWidgets('Navigation test', (WidgetTester tester) async {
      final mockObserver = MockNavigatorObserver();

      await tester.pumpWidget(
        MaterialApp(
          initialRoute: '/home',
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/home':
                return MaterialPageRoute(
                  settings: settings,
                  builder: (_) => Scaffold(
                    body: const Text('Home Page'),
                    bottomNavigationBar: BottomNavbar(),
                  ),
                );
              case '/new-post':
                return MaterialPageRoute(
                  settings: settings,
                  builder: (_) => Scaffold(
                    body: const Text('New Post Page'),
                    bottomNavigationBar: BottomNavbar(),
                  ),
                );
              default:
                return null;
            }
          },
          navigatorObservers: [mockObserver],
        ),
      );

      await tester.tap(find.byIcon(LucideIcons.copyPlus));
      await tester.pumpAndSettle();

      verify(mockObserver.didPush(any, any));

      await tester.tap(find.byIcon(LucideIcons.home));
      await tester.pumpAndSettle();

      verify(mockObserver.didPush(any, any));

      await tester.tap(find.byIcon(LucideIcons.home));
      await tester.pumpAndSettle();

      verifyNever(mockObserver.didPush(any, any));
    });
  });
}
