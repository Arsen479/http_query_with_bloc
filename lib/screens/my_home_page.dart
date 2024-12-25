import 'package:flutter/material.dart';
import 'package:flutter_http_query_users/user_bloc/users_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_http_query_users/screens/my_post_page.dart';
import 'package:flutter_http_query_users/widgets/usersContainer.dart';
//import 'package:flutter_http_query_users/screens/main.dart';
//import 'package:flutter_http_query_users/screens/my_home_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final UsersBloc usersBloc;
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    usersBloc = UsersBloc();
    usersBloc.add(GetUsersEvent());
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    usersBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Search',
            ),
            onChanged: (value) {
              if (value.isNotEmpty) {
                usersBloc.add(GetUserEvent(name: controller.text));
              } else {
                usersBloc.add(GetUsersEvent());
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: BlocBuilder<UsersBloc, UsersState>(
              bloc: usersBloc,
              builder: (context, state) {
                if (state is UsersLoadedState2) {
                  return UsersContainer(
                    usersBloc: usersBloc,
                    state: state,
                  );
                } else if (state is LoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return const SizedBox();
              },
            ),
          )
        ],
      ),
    );
  }
}
