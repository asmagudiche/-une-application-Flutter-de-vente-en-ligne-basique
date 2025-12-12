// test/widget_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gestion_de_projet/main.dart';
import 'package:gestion_de_projet/main.dart';

void main() {
  testWidgets('L\'application démarre et affiche l\'écran d\'inscription',
      (WidgetTester tester) async {
    // Construire l'application complète
    await tester.pumpWidget(const MyApp());

    // Attendre que Firebase s'initialise et que l'UI soit prête
    await tester.pumpAndSettle();

    // Vérifie que le titre "Inscription" est bien affiché
    expect(find.text('Inscription'), findsOneWidget);

    // Vérifie que les champs sont présents
    expect(find.text('Nom complet'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Mot de passe'), findsOneWidget);

    // Vérifie que le bouton principal existe
    expect(find.text('Créer le compte'), findsOneWidget);

    // Bonus : on peut aussi vérifier qu'il n'y a pas d'erreur affichée au départ
    expect(find.textContaining('Erreur'), findsNothing);
  });

  testWidgets('On peut remplir le formulaire d\'inscription',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Remplir les champs
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Nom complet'), 'Asma');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Email'), 'asma@test.com');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Mot de passe'), '12345678');

    // Appuyer sur le bouton
    await tester.tap(find.text('Créer le compte'));
    await tester.pump(); // déclenche le rebuild

    // On vérifie que le bouton de chargement apparaît (CircularProgressIndicator)
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
