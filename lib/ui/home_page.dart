import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_bloc/cubit/internet_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<InternetCubit, InternetState>(
          listener: (context, state) {
            if (state == InternetState.connected) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Connected'),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state == InternetState.disconnected) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Disconnected'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (BuildContext context, InternetState state) {
            if (state == InternetState.connected) {
              return const Text('Internet Connected');
            } else if (state == InternetState.disconnected) {
              return const Text('Internet Disconnected');
            }
            return const Text('Loading...');
          },
        ),
      ),
    );
  }
}
