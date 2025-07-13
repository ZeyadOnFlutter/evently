import 'package:evently/providers/event_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/theme/apptheme.dart';
import 'package:evently/widgets/category_item.dart';
import 'package:evently/widgets/deafult_text_field.dart';
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
  List<int> searchList = [];
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
        searchList = List.generate(
          eventProvider.filteredFavourites.length,
          (index) => index,
        );
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
              isSearch: true,
              hintText: 'Search For Event',
              borderColor: Apptheme.primary,
              textStyle: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Apptheme.primary,
              ),
              onChanged: (query) {
                onSearch(query);
              },
              prefixImageName: 'searchicon',
              textInputType: TextInputType.text,
            ),
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return searchList.contains(index)
                    ? SizedBox(
                        height: 16.h,
                      )
                    : const SizedBox.shrink();
              },
              itemCount: eventProvider.filteredFavourites.length,
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
              itemBuilder: (context, index) {
                return searchList.contains(index)
                    ? Padding(
                        padding:
                            index == eventProvider.filteredFavourites.length - 1
                                ? EdgeInsets.only(bottom: 75.h)
                                : EdgeInsets.zero,
                        child: CategoryItem(
                          event: eventProvider.filteredFavourites[index],
                        ),
                      )
                    : const SizedBox.shrink();
              },
            ),
          )
        ],
      ),
    );
  }

  void onSearch(String query) {
    searchList.clear();
    for (int i = 0; i < eventProvider.filteredFavourites.length; i++) {
      if (eventProvider.filteredFavourites[i].description
              .toLowerCase()
              .contains(query.toLowerCase()) ||
          eventProvider.filteredFavourites[i].category.categoryName
              .toLowerCase()
              .contains(query.toLowerCase())) {
        searchList.add(i);
      }
    }
    setState(() {});
  }
}
