import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fno_pulse/main.dart';
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Android navigation', (tester) async {
    await tester.pumpWidget(const FnOPulse());
    expect(find.text('Market intelligence'), findsOneWidget);
    await tester.tap(find.text('Charts'));
    await tester.pumpAndSettle();
    expect(find.text('Price charts'), findsOneWidget);
    await tester.tap(find.text('Options'));
    await tester.pumpAndSettle();
    expect(find.text('Option chain'), findsOneWidget);
  });
}
