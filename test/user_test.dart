import 'package:ambee/app/user/bloc/user_cubit.dart';
import 'package:ambee/app/user/ui/add_user_details.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserCubit extends MockCubit<UserState> implements UserCubit {}

class UserStateFake extends Fake implements UserState {}

void main() {
  late UserCubit userCubit;
  late TextEditingController mockNameCr;
  late TextEditingController mockEmailCr;

  setUpAll(() {
    userCubit = MockUserCubit();
    mockNameCr = TextEditingController();
    mockEmailCr = TextEditingController();
    registerFallbackValue(UserStateFake());
  });

  group('UserPage', () {
    testWidgets('Renders UI correctly', (WidgetTester tester) async {
      when(() => userCubit.state).thenAnswer((_) => UserState());
      when(() => userCubit.nameController)
          .thenAnswer((invocation) => mockNameCr);
      when(() => userCubit.emailController)
          .thenAnswer((invocation) => mockEmailCr);
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<UserCubit>.value(
            value: userCubit,
            child: UserPage(),
          ),
        ),
      );

      expect(find.text('User Page'), findsOneWidget);
      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.text('Save'), findsOneWidget);
    });

    testWidgets('Calls saveUser when Save button is pressed',
        (WidgetTester tester) async {
      when(() => userCubit.state).thenAnswer((_) => UserState());
      when(() => userCubit.nameController)
          .thenAnswer((invocation) => mockNameCr);
      when(() => userCubit.emailController)
          .thenAnswer((invocation) => mockEmailCr);
      when(() => userCubit.isValidated()).thenAnswer((invocation) => true);
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<UserCubit>.value(
            value: userCubit,
            child: UserPage(),
          ),
        ),
      );

      // Tap the Save button
      await tester.tap(find.text('Save'));
      await tester.pump();

      // Verify that the saveUser method was called
      verify(() => userCubit.saveUser()).called(1);
    });
  });
}
