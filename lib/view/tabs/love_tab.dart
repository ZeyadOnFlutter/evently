import 'package:evently/models/category.dart';
import 'package:evently/theme/apptheme.dart';
import 'package:evently/widgets/category_item.dart';
import 'package:evently/widgets/deafult_text_field.dart';
import 'package:evently/widgets/home_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LoveTab extends StatefulWidget {
  const LoveTab({super.key});

  @override
  State<LoveTab> createState() => _LoveTabState();
}

class _LoveTabState extends State<LoveTab> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
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
              onChanged: (query) {
                MyCategory.onSearch(query);
                print(MyCategory.searchCategory);
                print(MyCategory.searchCategory.length);
                setState(() {});
              },
              prefixImageName: 'searchicon',
              textInputType: TextInputType.text,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: MyCategory.myCategory.length,
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 0,
              ),
              itemBuilder: (context, index) {
                return MyCategory.searchCategory.contains(index)
                    ? Container(
                        margin: EdgeInsets.only(top: 16.h),
                        padding: index == MyCategory.myCategory.length - 1
                            ? EdgeInsets.only(bottom: 90.h)
                            : EdgeInsets.zero,
                        child: Container(),
                      )
                    : const SizedBox.shrink();
              },
            ),
          )
        ],
      ),
    );
  }
}
