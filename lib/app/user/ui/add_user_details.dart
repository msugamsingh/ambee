import 'package:ambee/app/user/bloc/user_cubit.dart';
import 'package:ambee/utils/widgets/custom_textfield.dart';
import 'package:ambee/utils/widgets/double_block_stack_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


// Widget to save user name and email locally
class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('User Page'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (BlocProvider.of<UserCubit>(context).isValidated()) {
            BlocProvider.of<UserCubit>(context).saveUser();
            Navigator.pop(context);
          }
        },
        label: const Text('Save'),
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                flex: 2,
                child: DoubleStackWidget(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextField(
                      controller: context.read<UserCubit>().nameController,
                      label: 'Name',
                      errorText: state.nameErrorMsg,
                      hint: 'Enter your name',
                      maxLength: 60,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 16.0),
                    CustomTextField(
                      controller: context.read<UserCubit>().emailController,
                      label: 'Email',
                      errorText: state.emailErrorMsg,
                      hint: 'sugam@mail.com',
                      maxLength: 120,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 32.0),
                  ],
                ),
              ),
              SizedBox(height: 100,)
            ],
          );
        },
      ),
    );
  }
}
