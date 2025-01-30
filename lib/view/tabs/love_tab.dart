import 'package:evently/models/category.dart';
import 'package:evently/providers/event_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/theme/apptheme.dart';
import 'package:evently/widgets/category_item.dart';
import 'package:evently/widgets/deafult_text_field.dart';
import 'package:evently/widgets/home_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoveTab extends StatefulWidget {
  const LoveTab({super.key});

  @override
  State<LoveTab> createState() => _LoveTabState();
}

class _LoveTabState extends State<LoveTab> {
  late EventProvider eventProvider;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        List<String> favouriteIds =
            Provider.of<UserProvider>(context, listen: false)
                .user!
                .favouriteIds;
        eventProvider.filterFavourites(favouriteIds);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    eventProvider = Provider.of<EventProvider>(
      context,
    );

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
              },
              prefixImageName: 'searchicon',
              textInputType: TextInputType.text,
            ),
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 16.h,
                );
              },
              itemCount: eventProvider.filteredFavourites.length,
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
              itemBuilder: (context, index) {
                return CategoryItem(
                  event: eventProvider.filteredFavourites[index],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
