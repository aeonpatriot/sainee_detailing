import 'package:flutter/material.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/models/book.dart';
import 'package:sainee_detailing/models/other/timeslot.dart';

class TimeSlotCard extends StatefulWidget {
  const TimeSlotCard(
      {Key? key,
      required this.futureTimeAvailability,
      required this.typeTimeSlot,
      required this.onSelectedTimeSlot,
      required this.isPastFirstTimeSlot,
      required this.isPastSecondTimeSlot})
      : super(key: key);

  final List<Book> futureTimeAvailability;
  final List<TimeSlot> typeTimeSlot;
  final Function(String) onSelectedTimeSlot;
  final bool isPastFirstTimeSlot;
  final bool isPastSecondTimeSlot;

  @override
  State<TimeSlotCard> createState() => _TimeSlotCardState();
}

class _TimeSlotCardState extends State<TimeSlotCard> {
  int selectedSlot = -1;

  @override
  Widget build(BuildContext context) {
    return widget.typeTimeSlot.isEmpty
        ? SizedBox(
            width: 50,
            child: Center(
                child: Text(
              'There are no available time slot for booking currently',
              style:
                  Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 16),
              textAlign: TextAlign.center,
            )),
          )
        : GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 3.3),
            itemCount: widget.isPastSecondTimeSlot
                ? 0
                : widget.isPastFirstTimeSlot
                    ? 1
                    : 2,
            itemBuilder: (context, index) {
              bool isBooked = checkTimeAvailability(
                  widget.futureTimeAvailability,
                  widget.typeTimeSlot[index].slot,
                  index);

              return Container(
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurStyle: BlurStyle.inner,
                        // color: kColorOffBlack,
                        color: kColorOffBlack.withOpacity(0.25),
                        spreadRadius: 0.0,
                        blurRadius: 10,
                        offset:
                            const Offset(0, 4), // changes position of shadow
                      )
                    ],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        width: 1, color: kColorOffBlack.withOpacity(0.25))),
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  color: isBooked
                      ? Colors.red
                      : (selectedSlot == index)
                          ? kSecondaryColor
                          : Colors.green,
                  child: InkWell(
                    onTap: isBooked
                        ? null
                        : () {
                            widget.onSelectedTimeSlot(
                                widget.typeTimeSlot[index].slot);
                            setState(() {
                              selectedSlot = index;
                            });
                          },
                    child: Container(
                      padding: const EdgeInsets.all(0),
                      child: Center(
                          child: Text(
                        widget.typeTimeSlot[index].timePeriod,
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontSize: 16,
                            color: isBooked
                                ? kColorWhite.withOpacity(0.7)
                                : (selectedSlot == index)
                                    ? kColorWhite
                                    : kColorWhite),
                      )),
                    ),
                  ),
                ),
              );
            });
  }

  bool checkTimeAvailability(List<Book> futureData, String slot, int index) {
    if (futureData.length == 2) {
      return true;
    } else if (futureData.length == 1) {
      if (futureData.first.timeSlot == slot) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
