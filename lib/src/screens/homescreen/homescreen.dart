import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/src/data/di/injection.dart';
import 'package:flutter_task/src/domain/repository/user_repository.dart';
import 'package:flutter_task/src/screens/homescreen/bloc/get_user_cubit.dart';
import 'package:flutter_task/src/screens/homescreen/bloc/get_user_state.dart';
import 'package:flutter_task/src/screens/homescreen/widgets/error_screen.dart';
import 'package:flutter_task/src/screens/user_details/user_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var headerHeight = MediaQuery.of(context).size.height * 0.2;
    return BlocProvider(
      create: (context) => GetUserCubit(GetUserState.initialState(),
          userRepository: getIt.get<UserRepository>())
        ..getUser(),
      child: BlocBuilder<GetUserCubit, GetUserState>(
        builder: (context, state) {
          return Scaffold(
            body: state.isLoading
                ? const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : state.users == null || state.users!.isEmpty
                    ? ErrorScreen(
                        message: state.message!,
                      )
                    : SafeArea(
                        child: Stack(
                          // clipBehavior: Clip.none,
                          fit: StackFit.expand,
                          children: [
                            Positioned(
                              height: headerHeight,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: headerHeight,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('assets/bg.jpeg'),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            Positioned(
                              top: headerHeight / 2,
                              right: 0,
                              left: 0,
                              child: Container(
                                height: MediaQuery.of(context).size.height,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),
                                ),
                                child: ListView.builder(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    itemCount: state.users!.length,
                                    itemBuilder: (context, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                                return UserDetailScreen(
                                                  user: state.users![index],
                                                );
                                              }),
                                            );
                                          },
                                          child: Hero(
                                            tag:
                                                'user_${state.users![index].id}',
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black38),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              height: 120,
                                              width: double.maxFinite,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 18, 8, 5),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          _userDetailSubText(
                                                              context,
                                                              hint: 'Name',
                                                              value: state
                                                                  .users![index]
                                                                  .name!),
                                                          _userDetailSubText(
                                                              context,
                                                              hint: 'Email',
                                                              value: state
                                                                  .users![index]
                                                                  .email!),
                                                          _userDetailSubText(
                                                              context,
                                                              value: state
                                                                  .users![index]
                                                                  .phone!,
                                                              hint: "Phone"),
                                                          _userDetailSubText(
                                                              value: state
                                                                  .users![index]
                                                                  .company!
                                                                  .name!,
                                                              hint: "Company",
                                                              context),
                                                        ],
                                                      ),
                                                    ),
                                                    CircleAvatar(
                                                      radius: 32,
                                                      backgroundColor:
                                                          Colors.teal,
                                                      child: Text(
                                                        state.users![index]
                                                            .name![0],
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .displaySmall
                                                            ?.copyWith(
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                          ],
                        ),
                      ),
          );
        },
      ),
    );
  }

  Widget _userDetailSubText(BuildContext context,
      {required String hint, required String value}) {
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          TextSpan(
            text: " $hint: ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: value,
          ),
        ],
      ),
    );
  }
}
