import 'package:flutter_test/flutter_test.dart';
import 'package:trackie_app/app/view/app.dart';

void main() {
  testWidgets('App starts and shows installer hub', (WidgetTester tester) async {
    // Constrói o nosso app e aciona um frame.
    await tester.pumpWidget(const App());

    // Verifica se o título do Hub de Instalação está na tela.
    expect(find.text('Componentes Necessários'), findsOneWidget);
    
    // Verifica se o botão "Baixar Todos" está presente.
    expect(find.text('Baixar Todos'), findsOneWidget);
  });
}
