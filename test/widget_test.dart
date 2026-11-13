import 'package:charades_app/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('app launches on the home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const CharadesApp());

    expect(find.text('CHARADES'), findsOneWidget);
    expect(find.text('SUPER MIX'), findsOneWidget);
    expect(find.text('PICK A PACK'), findsOneWidget);
  });
}
