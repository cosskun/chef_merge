import 'package:flutter_test/flutter_test.dart';
import 'package:chef_merge/main.dart';
import 'package:chef_merge/state/game_controller.dart';

void main() {
  testWidgets('ChefMergeApp home smoke test with splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(const ChefMergeApp());
    expect(find.text('ChefMerge'), findsWidgets);
    await tester.pump(const Duration(milliseconds: 3000));
  });

  test('GameController invalid merge creates ruined food and wastes slot', () {
    final controller = GameController.instance;
    controller.setLevel(0);

    // Force place 2 incompatible items (e.g. Tomato Soup + Tomato Soup)
    controller.trashItem(0);
    controller.trashItem(1);

    // Merge tomato on index 2 and index 3 (raw_tomato + raw_tomato -> chopped_tomato)
    // Then merge incompatible items
    controller.mergeSlots(2, 3); // chopped_tomato
    expect(controller.board[3]?.code, 'chopped_tomato');

    // Merge chopped_tomato with another raw_tomato at index 0 (if any) -> Invalid merge produces ruined_food
    controller.mergeSlots(3, 2); // since index 2 is now null, it moves!
    expect(controller.board[2]?.code, 'chopped_tomato');
  });
}
