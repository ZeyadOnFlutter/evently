import 'package:evently/models/category.dart';
import 'package:evently/theme/apptheme.dart';
import 'package:evently/widgets/deafult_text_field.dart';
import 'package:evently/widgets/mytabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});
  static const String routeName = '/create-event';

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  int currentIndex = 0;
  DateTime? selectedDateTime;
  DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  TimeOfDay? timeOfDay;
  String format(BuildContext context, TimeOfDay timeOfDay) {
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    return localizations.formatTimeOfDay(
      timeOfDay,
      alwaysUse24HourFormat: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? myblackTextTheme = Theme.of(context).textTheme.bodyLarge;
    TextStyle? myblueTextTheme = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(color: Apptheme.primary);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Event'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16.h,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Image.asset(
                    'assets/images/${MyCategory.myCategory[currentIndex + 1].imageName}.png',
                    height: 203.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Mytabbar(
                currentIndex: currentIndex,
                onTap: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                isCreateEvent: true,
                tabBarLength: MyCategory.myCategory.length - 1,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                ),
                child: Column(
                  spacing: 16.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Title',
                      style: myblackTextTheme,
                    ),
                    const DeafultTextFormField(
                      hintText: 'Event Title',
                      borderColor: Apptheme.grey,
                      prefixImageName: 'note',
                    ),
                    Text(
                      'Description',
                      style: myblackTextTheme,
                    ),
                    const DeafultTextFormField(
                      hintText: 'Event Descriprion',
                      borderColor: Apptheme.grey,
                      maxLines: 4,
                    ),
                    Row(
                      spacing: 10.w,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/calendar.svg',
                        ),
                        Text(
                          'Event Date',
                          style: myblackTextTheme,
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () async {
                            var date = await showDatePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(
                                const Duration(days: 365),
                              ),
                              initialEntryMode:
                                  DatePickerEntryMode.calendarOnly,
                            );
                            if (date != null) {
                              selectedDateTime = date;
                              setState(() {});
                            }
                          },
                          child: Text(
                            selectedDateTime != null
                                ? dateFormat.format(selectedDateTime!)
                                : 'Choose Date',
                            style: myblueTextTheme,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      spacing: 10.w,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/clock.svg',
                        ),
                        Text(
                          'Event Time',
                          style: myblackTextTheme,
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () async {
                            TimeOfDay? nowTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              builder: (BuildContext context, Widget? child) {
                                return MediaQuery(
                                  data: MediaQuery.of(context).copyWith(
                                    alwaysUse24HourFormat: false,
                                  ),
                                  child: child!,
                                );
                              },
                            );
                            if (nowTime != null) {
                              timeOfDay = nowTime;
                              setState(() {});
                            }
                          },
                          child: Text(
                            timeOfDay != null
                                ? format(context, timeOfDay!)
                                : 'Choose Time',
                            style: myblueTextTheme,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
