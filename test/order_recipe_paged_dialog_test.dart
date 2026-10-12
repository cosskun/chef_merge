import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chef_merge/models/order_model.dart';
import 'package:chef_merge/models/item_model.dart';
import 'package:chef_merge/widgets/order_recipe_dialog.dart';

void main() {
  testWidgets('Single order dialog does NOT show pagination arrows', (tester) async {
    final order = CustomerOrder(
      id: 'single_1',
      targetItem: GameItem.toast,
      customerName: 'Ayşe Hanım',
      customerAvatar: '👩',
      totalSeconds: 60,
      remainingSeconds: 60,
      isPartyTray: false,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: OrderRecipeDialog(order: order),
        ),
      ),
    );

    expect(find.text("Ayşe Hanım'in Siparişi"), findsOneWidget);
    expect(find.text(GameItem.toast.localizedName), findsWidgets);
    // Pagination bar should NOT exist
    expect(find.byTooltip('Önceki Yemek'), findsNothing);
    expect(find.byTooltip('Sonraki Yemek'), findsNothing);
  });

  testWidgets('Party tray with 2 items shows paged structure with arrow navigation', (tester) async {
    final order = CustomerOrder(
      id: 'party_1',
      targetItem: GameItem.bolognesePasta,
      customerName: 'Şampiyonlar Zafer Tepsisi',
      customerAvatar: '🎪',
      totalSeconds: 60,
      remainingSeconds: 60,
      isPartyTray: true,
      partyItems: [GameItem.bolognesePasta, GameItem.creamyMushroomSoup],
      partyCompletedItems: [false, false],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: OrderRecipeDialog(order: order),
        ),
      ),
    );

    // Initial page: Bolonez Soslu Makarna (Yemek 1 / 2)
    expect(find.textContaining('Yemek 1 / 2:'), findsOneWidget);
    expect(find.text(GameItem.bolognesePasta.localizedName), findsWidgets);
    expect(find.byTooltip('Önceki Yemek'), findsOneWidget);
    expect(find.byTooltip('Sonraki Yemek'), findsOneWidget);

    // Tap next arrow
    await tester.tap(find.byTooltip('Sonraki Yemek'));
    await tester.pumpAndSettle();

    // Now on page 2: Kremalı Mantar Çorbası (Yemek 2 / 2)
    expect(find.textContaining('Yemek 2 / 2:'), findsOneWidget);
    expect(find.text(GameItem.creamyMushroomSoup.localizedName), findsWidgets);

    // Tap prev arrow
    await tester.tap(find.byTooltip('Önceki Yemek'));
    await tester.pumpAndSettle();

    // Back to page 1
    expect(find.textContaining('Yemek 1 / 2:'), findsOneWidget);
    expect(find.text(GameItem.bolognesePasta.localizedName), findsWidgets);
  });

  testWidgets('OrderRecipeDialog respects initialPageIndex for direct item opening', (tester) async {
    final order = CustomerOrder(
      id: 'party_1',
      targetItem: GameItem.bolognesePasta,
      customerName: 'Şampiyonlar Zafer Tepsisi',
      customerAvatar: '🎪',
      totalSeconds: 60,
      remainingSeconds: 60,
      isPartyTray: true,
      partyItems: [GameItem.bolognesePasta, GameItem.creamyMushroomSoup],
      partyCompletedItems: [false, false],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: OrderRecipeDialog(order: order, initialPageIndex: 1),
        ),
      ),
    );

    // Should immediately be on page 2
    expect(find.textContaining('Yemek 2 / 2:'), findsOneWidget);
    expect(find.text(GameItem.creamyMushroomSoup.localizedName), findsWidgets);
  });
}
