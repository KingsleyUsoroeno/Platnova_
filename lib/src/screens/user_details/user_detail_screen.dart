import 'package:flutter/material.dart';
import 'package:flutter_task/src/domain/model/user_entity.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;
  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close))
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            Hero(
              tag: 'user_${user.id}',
              child: CircleAvatar(
                radius: 52,
                backgroundColor: Colors.teal,
                child: Text(
                  user.name![0],
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            _customDivider(),
            const SizedBox(
              height: 40,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 200,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black45),
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Text(user.name!),
                  _customDivider(),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(user.email!),
                  _customDivider(),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(user.phone!),
                  _customDivider(),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(user.company!.name!),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _customDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Divider(),
    );
  }
}
