import 'package:flutter/material.dart';
import 'package:flutter_http_query_users/user_bloc/users_bloc.dart';
import 'package:flutter_http_query_users/screens/my_post_page.dart';

class UsersContainer extends StatelessWidget {
  final UsersBloc usersBloc;
  final UsersLoadedState2 state;
  const UsersContainer({
    super.key, required this.usersBloc, required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true,
      itemCount: state.usersy.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyPostPage(
                  user: state.usersy[index],
                ),
              ),
            );
          },
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.black12,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.account_circle,
                    size: 50,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${state.usersy[index].name}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${state.usersy[index].phone}\n${state.usersy[index].email}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.fade,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          color: Colors.grey,
          thickness: 2,
          height: 20,
          indent: 20,
          endIndent: 20,
        );
      },
    );
  }
}
