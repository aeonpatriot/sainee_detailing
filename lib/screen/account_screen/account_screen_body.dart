import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/viewmodels/account_viewmodel.dart';
import 'package:sainee_detailing/viewmodels/mainmenu_viewmodel.dart';

class AccountScreenBody extends StatelessWidget {
  const AccountScreenBody({
    Key? key,
    required this.accountViewModel,
  }) : super(key: key);

  final AccountViewModel accountViewModel;

  @override
  Widget build(BuildContext context) {
    final MainmenuViewModel mainmenuViewModel =
        Provider.of<MainmenuViewModel>(context);

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
                    if (index == 0) accountViewModel.onTapProfile(context);
                    if (index == 1) accountViewModel.onTapAddress(context);
                    if (index == 2) accountViewModel.onTapCar();
                    if (index == 3) {
                      accountViewModel.onTapLogout(context);
                      mainmenuViewModel.currentIndex = 0;
                    }
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
