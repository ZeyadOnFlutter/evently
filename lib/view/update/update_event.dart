import 'package:evently/models/category.dart';
import 'package:evently/models/event.dart';
import 'package:evently/providers/event_provider.dart';
import 'package:evently/connection/firebase_service.dart';
import 'package:evently/providers/settings_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/theme/apptheme.dart';
import 'package:evently/view/home/home_screen.dart';
import 'package:evently/widgets/deafult_text_field.dart';
import 'package:evently/widgets/login_button.dart';
import 'package:evently/widgets/mytabbar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UpdateEvent extends StatefulWidget {
  const UpdateEvent({super.key});

  static const String routeName = '/update-event';

  @override
  State<UpdateEvent> createState() => _UpdateEventState();
}

class _UpdateEventState extends State<UpdateEvent>
    with SingleTickerProviderStateMixin {
  DateTime? selectedDateTime;
  DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  TimeOfDay? timeOfDay;
  MyCategory selectedCategory = MyCategory.myCategory.first;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late Event event;
  late int currentIndex;
  late TabController tabController;
  bool isAssigned = false;
  String format(BuildContext context, TimeOfDay timeOfDay) {
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    return localizations.formatTimeOfDay(
      timeOfDay,
      alwaysUse24HourFormat: false,
    );
  }

  @override
  void initState() {
    super.initState();
    tabController =
        TabController(length: MyCategory.myCategory.length - 1, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<SettingsProvider>(context).isDark;
    event = ModalRoute.of(context)?.settings.arguments as Event;
    if (!isAssigned) {
      currentIndex = currentIndex = int.parse(event.category.id) - 1;
      tabController.index = int.parse(event.category.id) - 1;
      isAssigned = true;
    }

    selectedCategory = MyCategory.myCategory[currentIndex + 1];
    TextStyle? myblackTextTheme = Theme.of(context).textTheme.bodyLarge;
    TextStyle? myblueTextTheme = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(color: Apptheme.primary);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text('Edit Event'),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16.h,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Image.asset(
                    'assets/images/${selectedCategory.imageName}.png',
                    height: 203.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Mytabbar(
                tabController: tabController,
                currentIndex: currentIndex,
                onTap: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                isCreateEvent: true,
                tabBarLength: MyCategory.myCategory.length - 1,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        spacing: 16.h,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Title',
                            style: myblackTextTheme,
                          ),
                          DeafultTextFormField(
                            textEditingController: titleController,
                            hintText: event.title,
                            borderColor: Apptheme.grey,
                            prefixImageName: 'note',
                            textStyle: Theme.of(context).textTheme.bodyLarge,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Event Title';
                              }
                              return null;
                            },
                          ),
                          Text(
                            'Description',
                            style: myblackTextTheme,
                          ),
                          DeafultTextFormField(
                            textEditingController: descriptionController,
                            hintText: event.description,
                            borderColor: Apptheme.grey,
                            textStyle: Theme.of(context).textTheme.bodyLarge,
                            maxLines: 4,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Event Descriprion';
                              }
                              return null;
                            },
                          ),
                          Row(
                            spacing: 10.w,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/calendar.svg',
                                colorFilter: ColorFilter.mode(
                                  isDark
                                      ? Apptheme.backgroundLight
                                      : Apptheme.black,
                                  BlendMode.srcIn,
                                ),
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
                                      : DateFormat('dd/MM/yyyy')
                                          .format(event.dateTime),
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
                                colorFilter: ColorFilter.mode(
                                  isDark
                                      ? Apptheme.backgroundLight
                                      : Apptheme.black,
                                  BlendMode.srcIn,
                                ),
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
                                    builder:
                                        (BuildContext context, Widget? child) {
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
                                      : DateFormat('hh:mm a')
                                          .format(event.dateTime),
                                  style: myblueTextTheme,
                                ),
                              ),
                            ],
                          ),
                          DefaultButton(
                            onPressed: () {
                              updateEvent(context);
                            },
                            label: 'Update Event',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateEvent(BuildContext context) async {
    if (formKey.currentState!.validate() &&
        selectedDateTime != null &&
        timeOfDay != null) {
      DateTime dateTime = DateTime(
        selectedDateTime!.year,
        selectedDateTime!.month,
        selectedDateTime!.day,
        timeOfDay!.hour,
        timeOfDay!.minute,
      );
      Event updatedevent = Event(
        id: event.id,
        uId: Provider.of<UserProvider>(context, listen: false).user!.id,
        category: selectedCategory,
        title: titleController.text,
        description: descriptionController.text,
        dateTime: dateTime,
      );

      await FirebaseService.updateEventFromFireStore(updatedevent).then(
        (value) {
          EventProvider prov =
              Provider.of<EventProvider>(context, listen: false);
          prov.getEvents();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Event updated Successfully',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              backgroundColor: Apptheme.primary,
            ),
          );
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        },
      ).catchError((error) {
        if (error is FirebaseException) {
          Fluttertoast.showToast(
            msg: error.toString(),
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Apptheme.primary,
            textColor: Colors.red,
            fontSize: 16.0,
          );
        }
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Apptheme.primary,
            title: Text(
              'Incomplete Fields',
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(color: Apptheme.backgroundLight),
            ),
            content: Text(
              'Please fill out all required fields.',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Apptheme.backgroundLight),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'OK',
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(color: Apptheme.backgroundLight),
                ),
              ),
            ],
          );
        },
      );
    }
  }
}
