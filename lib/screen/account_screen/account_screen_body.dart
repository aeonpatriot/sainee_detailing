import 'package:flutter/material.dart';
import 'package:sainee_detailing/viewmodels/account_viewmodel.dart';

class AccountScreenBody extends StatelessWidget {
  const AccountScreenBody({
    Key? key,
    required this.accountViewModel,
  }) : super(key: key);

  final AccountViewModel accountViewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              child: Image.asset(
                'assets/images/placeholder-image-400x300.jpg',
                fit: BoxFit.fill,
              ),
            )
          ],
        ),
        Expanded(
          child: SizedBox(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) => Card(
                child: ListTile(
                  onTap: () {
                    if (index == 0) accountViewModel.onTapProfile();
                    if (index == 1) accountViewModel.onTapAddress();
                    if (index == 2) accountViewModel.onTapCar();
                    if (index == 3) accountViewModel.onTapLogout(context);
                  },
                  title: Text(accountViewModel.items[index]),
                  trailing: (index == 3)
                      ? const Icon(
                          Icons.logout,
                          color: Colors.redAccent,
                        )
                      : const Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
