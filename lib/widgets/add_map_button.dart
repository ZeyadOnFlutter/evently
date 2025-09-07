import 'package:auto_size_text/auto_size_text.dart';
import 'package:evently/connection/location_service.dart';
import 'package:evently/providers/settings_provider.dart';
import 'package:evently/theme/apptheme.dart';
import 'package:evently/widgets/icon_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class AddMapButton extends StatelessWidget {
  const AddMapButton({required this.onPickLocation, this.text, super.key});
  final void Function(LatLng) onPickLocation;
  final String? text;
  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<SettingsProvider>(context).isDark;
    return OutlinedButton(
      onPressed: () async {
        LatLng? location = await LocationService.pickLocation(context);
        if (location != null) {
          onPickLocation(location);
        }
      },
      style: OutlinedButton.styleFrom(
        fixedSize: Size(1.sw, 56.h),
        padding: EdgeInsets.all(8.r),
        side: const BorderSide(
          color: Apptheme.primary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16.r),
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 46.h,
            width: 46.w,
            decoration: BoxDecoration(
              color: Apptheme.primary,
              borderRadius: BorderRadius.all(
                Radius.circular(8.r),
              ),
            ),
            child: IconItem(
              iconName: isDark ? "black_location_icon" : "location_icon",
            ),
          ),
          SizedBox(
            width: 8.w,
          ),
          Expanded(
            child: AutoSizeText(
              text ?? "Add Location",
              style: text != null
                  ? Theme.of(context).textTheme.titleMedium!.copyWith(color: Apptheme.primary)
                  : Theme.of(context).textTheme.titleLarge!.copyWith(color: Apptheme.primary),
            ),
          ),
        ],
      ),
    );
  }
}
