import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../models/event.dart';
import '../../providers/event_provider.dart';
import '../../providers/location_provider.dart';
import '../../providers/settings_provider.dart';
import '../../theme/apptheme.dart';
import '../../widgets/icon_item.dart';
import '../../widgets/map_item.dart';

class MapTab extends StatefulWidget {
  const MapTab({super.key});

  @override
  State<MapTab> createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  GoogleMapController? googleMapController;
  Set<Circle> _circles = {};

  void _controlMap(LatLng newLocation) {
    googleMapController?.animateCamera(CameraUpdate.newLatLng(newLocation));
  }

  void _initializCircle() {
    final eventListProvider = Provider.of<EventProvider>(context, listen: false);

    _circles = eventListProvider.events.map(
      (event) {
        return Circle(
          circleId: CircleId(event.id),
          radius: 10.r,
          center: LatLng(
            event.latitude!,
            event.longitude!,
          ),
          fillColor: Colors.black,
          strokeWidth: 10,
          strokeColor: Colors.black.withValues(
            alpha: 0.5,
          ),
        );
      },
    ).toSet();
    setState(() {});
  }

  void _updateCircleByColor(Event event) {
    _circles = _circles.map((circle) {
      final isTarget = circle.circleId.value == event.id;

      return Circle(
        circleId: circle.circleId,
        radius: circle.radius,
        center: circle.center,
        fillColor: isTarget ? Apptheme.primary : Colors.black,
        strokeWidth: 10,
        strokeColor: (isTarget ? Apptheme.primary : Colors.black).withValues(alpha: 0.5),
      );
    }).toSet();
  }

  @override
  void initState() {
    super.initState();
    _initializCircle();
  }

  @override
  Widget build(BuildContext context) {
    final eventListProvider = Provider.of<EventProvider>(context);
    final isDark = Provider.of<SettingsProvider>(context).isDark;
    final locationProvider = Provider.of<LocationProvider>(context);
    return SafeArea(
      child: eventListProvider.events.isEmpty
          ? Center(
              child: LottieBuilder.asset(
                isDark ? 'assets/lottie/event_dark.json' : 'assets/lottie/event.json',
              ),
            )
          : Stack(
              children: [
                GoogleMap(
                  onMapCreated: (controller) {
                    googleMapController = controller;
                    print("_circles : ${_circles.length}");
                  },
                  initialCameraPosition: CameraPosition(
                    target: locationProvider.currentLocation ?? const LatLng(31.216603, 29.946275),
                    zoom: 16,
                  ),
                  circles: _circles,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                ),
                Positioned(
                  right: 16.w,
                  top: 16.h,
                  child: InkWell(
                    onTap: () {
                      _controlMap(
                        locationProvider.currentLocation ?? const LatLng(31.216603, 29.946275),
                      );
                    },
                    child: Container(
                      width: 54.w,
                      height: 54.w,
                      decoration: BoxDecoration(
                        color: Apptheme.primary,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: IconItem(iconName: isDark ? "black_location_icon" : "location_icon"),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 32.h,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: 94.h,
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          width: 10.w,
                        );
                      },
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      itemCount: eventListProvider.events.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            googleMapController?.animateCamera(
                              CameraUpdate.newLatLng(
                                LatLng(
                                  eventListProvider.events[index].latitude ?? 31.216603,
                                  eventListProvider.events[index].longitude ?? 29.946275,
                                ),
                              ),
                            );
                            _updateCircleByColor(eventListProvider.events[index]);
                            setState(() {});
                          },
                          child: MapItem(
                            event: eventListProvider.events[index],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
