import 'package:flutter_test/flutter_test.dart';
import 'package:fno_pulse/main.dart';
void main() {
  testWidgets('launch and clear demo warning', (tester) async {
    await tester.pumpWidget(const FnOPulse());
    expect(find.text('Market intelligence'), findsOneWidget);
    expect(find.textContaining('DEMO ONLY'), findsOneWidget);
  });
  testWidgets('options navigation', (tester) async {
    await tester.pumpWidget(const FnOPulse());
    await tester.tap(find.text('Options'));
    await tester.pumpAndSettle();
    expect(find.text('Option chain'), findsOneWidget);
  });
}
