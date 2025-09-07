import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently/connection/location_service.dart';
import 'package:evently/models/category.dart';
import 'package:evently/models/event.dart';
import 'package:evently/providers/event_provider.dart';
import 'package:evently/connection/firebase_service.dart';
import 'package:evently/providers/settings_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/theme/apptheme.dart';
import 'package:evently/widgets/add_map_button.dart';
import 'package:evently/widgets/deafult_text_field.dart';
import 'package:evently/widgets/login_button.dart';
import 'package:evently/widgets/mytabbar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

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
  MyCategory selectedCategory = MyCategory.myCategory.first;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  LatLng? selectedLocation;
  String? address;

  String format(BuildContext context, TimeOfDay timeOfDay) {
    final MaterialLocalizations localizations = MaterialLocalizations.of(context);
    return localizations.formatTimeOfDay(
      timeOfDay,
      alwaysUse24HourFormat: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<SettingsProvider>(context).isDark;
    selectedCategory = MyCategory.myCategory[currentIndex + 1];
    TextStyle? myblackTextTheme = Theme.of(context).textTheme.bodyLarge;
    TextStyle? myblueTextTheme =
        Theme.of(context).textTheme.bodyLarge!.copyWith(color: Apptheme.primary);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text('create_event'.tr()),
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
                    isDark
                        ? 'assets/images/${selectedCategory.imageName}dark.png'
                        : 'assets/images/${selectedCategory.imageName}.png',
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
                            'title'.tr(),
                            style: myblackTextTheme,
                          ),
                          DeafultTextFormField(
                            textEditingController: titleController,
                            hintText: 'event_title'.tr(),
                            borderColor: isDark ? Apptheme.primary : Apptheme.grey,
                            textStyle: Theme.of(context).textTheme.bodyLarge,
                            prefixImageName: 'note',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Event Title';
                              }
                              return null;
                            },
                          ),
                          Text(
                            'description'.tr(),
                            style: myblackTextTheme,
                          ),
                          DeafultTextFormField(
                            textEditingController: descriptionController,
                            hintText: 'event_description'.tr(),
                            borderColor: isDark ? Apptheme.primary : Apptheme.grey,
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
                                  isDark ? Apptheme.backgroundLight : Apptheme.black,
                                  BlendMode.srcIn,
                                ),
                              ),
                              Text(
                                'event_date'.tr(),
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
                                    initialEntryMode: DatePickerEntryMode.calendarOnly,
                                  );
                                  if (date != null) {
                                    selectedDateTime = date;
                                    setState(() {});
                                  }
                                },
                                child: Text(
                                  selectedDateTime != null
                                      ? dateFormat.format(selectedDateTime!)
                                      : 'choose_date'.tr(),
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
                                  isDark ? Apptheme.backgroundLight : Apptheme.black,
                                  BlendMode.srcIn,
                                ),
                              ),
                              Text(
                                'event_time'.tr(),
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
                                      : 'choose_time'.tr(),
                                  style: myblueTextTheme,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'location'.tr(),
                            style: myblackTextTheme,
                          ),
                          AddMapButton(
                            onPickLocation: (location) async {
                              selectedLocation = location;
                              if (selectedLocation != null) {
                                address =
                                    await LocationService.getLocationDetails(selectedLocation!);
                              }
                              setState(() {});
                            },
                            text: address,
                          ),
                          DefaultButton(
                            onPressed: () {
                              createEvent(context);
                            },
                            label: 'Add',
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

  void createEvent(BuildContext context) async {
    bool isDark = Provider.of<SettingsProvider>(context, listen: false).isDark;
    if (formKey.currentState!.validate() && selectedDateTime != null && timeOfDay != null) {
      DateTime dateTime = DateTime(
        selectedDateTime!.year,
        selectedDateTime!.month,
        selectedDateTime!.day,
        timeOfDay!.hour,
        timeOfDay!.minute,
      );
      Event event = Event(
        address: address,
        latitude: selectedLocation?.latitude,
        longitude: selectedLocation?.longitude,
        uId: Provider.of<UserProvider>(context, listen: false).user!.id,
        category: selectedCategory,
        title: titleController.text,
        description: descriptionController.text,
        dateTime: dateTime,
      );
      await FirebaseService.addEventToFireStore(event).then(
        (value) {
          EventProvider prov = Provider.of<EventProvider>(context, listen: false);
          prov.getEvents();
          AwesomeDialog(
            btnCancelColor: Colors.green,
            btnOkColor: Apptheme.primary,
            dialogBackgroundColor: isDark ? Apptheme.backgroundDark : Apptheme.backgroundLight,
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.topSlide,
            title: 'Success',
            desc: 'Event Created Successfully',
            btnOkOnPress: () {
              Navigator.of(context).pop();
            },
          ).show();
        },
      ).catchError((error) {
        if (error is FirebaseException) {
          Fluttertoast.showToast(
            msg: error.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Apptheme.primary,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
          backgroundColor: Apptheme.primary,
          content: AutoSizeText(
            'PLease Fill Out All The Info',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Apptheme.white,
                ),
          ),
        ),
      );
    }
  }
}
