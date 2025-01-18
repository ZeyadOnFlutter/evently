import 'package:evently/theme/apptheme.dart';
import 'package:evently/widgets/deafult_text_field.dart';
import 'package:evently/widgets/home_body.dart';
import 'package:evently/widgets/home_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class LoveTab extends StatelessWidget {
  const LoveTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 16.h,
                left: 16.w,
                right: 16.w,
              ),
              child: DeafultTextFormField(
                hintText: 'Search For Event',
                borderColor: Apptheme.primary,
                textStyle: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Apptheme.primary,
                ),
                onChanged: (query) {},
                prefixImageName: 'searchicon',
                textInputType: TextInputType.text,
              ),
              // child: TextField(
              //   decoration: InputDecoration(
              //     hintText: 'Search For Event',
              //     hintStyle:
              //         Theme.of(context).textTheme.displayMedium!.copyWith(
              //               color: Apptheme.primary,
              //               fontSize: 14,
              //             ),
              //     prefixIcon: SvgPicture.asset(
              //       'assets/icons/searchicon.svg',
              //       fit: BoxFit.scaleDown,
              //     ),
              //     enabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(16.r),
              //       borderSide: BorderSide(
              //         color: Apptheme.primary,
              //       ),
              //     ),
              //     focusedBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(16.r),
              //       borderSide: BorderSide(
              //         color: Apptheme.primary,
              //       ),
              //     ),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(16.r),
              //       borderSide: BorderSide(
              //         color: Apptheme.primary,
              //       ),
              //     ),
              //   ),
              // ),
            ),
            HomeBody(
              currentIndex: 0,
            ),
          ],
        ),
      ),
    );
  }
}
