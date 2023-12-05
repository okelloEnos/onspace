import 'package:flutter_test/flutter_test.dart';
import 'package:onspace/app/app.dart';
import 'package:onspace/counter/counter.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(const OnSpaceApp());
      expect(find.byType(CounterPage), findsOneWidget);
    });
  });
}
