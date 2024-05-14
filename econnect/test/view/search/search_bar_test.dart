import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:econnect/view/search/widgets/search_bar.dart';

void main() {
  testWidgets('Search bar calls callback function on submit',
      (WidgetTester tester) async {
    String searchText = '';

    void onTextChanged(String text) {
      searchText = text;
    }

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: UserSearchBar(
            controller: TextEditingController(),
            onTextChanged: onTextChanged,
          ),
        ),
      ),
    );

    final searchBar = find.byType(TextField);
    await tester.enterText(searchBar, 'changed');

    expect(searchText, 'changed');
  });
}
