import 'package:flutter_test/flutter_test.dart';
import 'package:trackie_app/app/view/app.dart';

void main() {
  testWidgets('App starts and shows Assistance page', (WidgetTester tester) async {
    // Constrói o app e dispara um frame.
    await tester.pumpWidget(const App());

    // Verifica se a tela inicial contém o título "Assistência".
    expect(find.text('Assistência'), findsOneWidget);
  });
}
