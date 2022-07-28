import 'package:amazon_clone_app/features/account/account.dart';
import 'package:flutter/material.dart';


class TopButtons extends StatelessWidget {
  const TopButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CustomAccountButton(
              text: 'Your Orders',
              onTap: () {},
            ),
            CustomAccountButton(
              text: 'Turn Seller',
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            CustomAccountButton(
              text: 'Log Out',
              onTap: () => AccountServices().logOut(context),
            ),
            CustomAccountButton(
              text: 'Your Wish List',
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}
