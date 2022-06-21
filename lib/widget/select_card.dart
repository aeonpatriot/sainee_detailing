import 'package:flutter/material.dart';
import 'package:sainee_detailing/constant.dart';

class SelectCard extends StatelessWidget {
  const SelectCard({
    Key? key,
    required this.mainText,
    required this.titleText,
    required this.mainIcon,
    required this.iconSize,
  }) : super(key: key);

  final String mainText;
  final String titleText;
  final IconData mainIcon;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Container(
        height: 70,
        width: double.infinity,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurStyle: BlurStyle.normal,
                // color: kColorOffBlack,
                color: kColorOffBlack.withOpacity(0.2),
                spreadRadius: 0.0,
                blurRadius: 5,
                offset: const Offset(0, 4), // changes position of shadow
              )
            ],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                width: 1, color: kPrimaryColorDark.withOpacity(0.3))),
        child: Container(
          decoration: BoxDecoration(
              color: kColorWhite, borderRadius: BorderRadius.circular(10)),
          child: Material(
            borderRadius: BorderRadius.circular(10),
            color: kPrimaryColorDark.withOpacity(0.1),
            child: InkWell(
              onTap: () {
                print('select card ontap');
              },
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(titleText,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(
                                        fontSize: 16,
                                        color: kPrimaryColorDark)),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(width: 3),
                              Icon(
                                mainIcon,
                                size: iconSize,
                                color: kPrimaryColorDark,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(0),
                                  width: double.infinity,
                                  child: Text(
                                      mainText
                                      // bookingViewModel.chosenAddress != null
                                      //     ? bookingViewModel
                                      //         .chosenAddress?.addressLine1
                                      //     : 'Add address in My Address Screen'
                                      ,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.copyWith(
                                            fontSize: 14,
                                          )),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: double.infinity,
                    child: const Icon(Icons.arrow_forward_ios, size: 15),
                    padding: const EdgeInsets.only(right: 15),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
