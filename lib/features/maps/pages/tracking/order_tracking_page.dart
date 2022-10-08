import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:reference_project_flutter/features/maps/webservices/webservices.dart';

const Color primaryColor = Color(0xff7b61ff);
const double padding = 16.0;

class OrderTrackingPage extends StatefulWidget {
  const OrderTrackingPage({Key? key}) : super(key: key);

  @override
  State<OrderTrackingPage> createState() => _OrderTrackingPageState();
}

class _OrderTrackingPageState extends State<OrderTrackingPage> {
  // التحكم في تتبع الخريطة
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  // الموقع الانطلاق
  static const LatLng sourceLocation = LatLng(30.791302, 31.398170);
  // موقع الوصول
  static const LatLng destination = LatLng(30.792007, 31.397685);
  //رسم المسار على الخريطه
  List<LatLng> polylineCoordinates = [];
  // معرفة موقعي
  LocationData? currentLocation;

  // تغيير الايقونات
  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor myLocationIcon = BitmapDescriptor.defaultMarker;

  // معرفة الموقع الحالي وتتبع الموقع
  void getCurrentLocation() async {
    final Location location = Location();

    location.getLocation().then((value) {
        currentLocation = value;
        print('currentLocation: ${currentLocation!.latitude}');
        print('currentLocation: ${currentLocation!.longitude}');
    });

    GoogleMapController mapController = await _controller.future;


    location.onLocationChanged.listen((newLocation) {
      currentLocation = newLocation;
      // تحريك الكاميرا مع تغيير موقعك .
      mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: 19,
          target: LatLng(newLocation.latitude!, newLocation.longitude!),
        ),
      ));
      print('newLocation: ${newLocation.latitude}');
      print('newLocation: ${newLocation.longitude}');
      setState(() {});

    });
  }

  // رسم الخطوط على الخريطة
  void getPolyPoint() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPIKey,
        PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
        PointLatLng(destination.latitude, destination.longitude),
        );

    if (result.points.isNotEmpty) {
      setState(() {
        for (var point in result.points) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        }
      });
    }
  }

  // تغيير شكل الموقع
  void setCustomMarker() {
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      'assets/img/map/marker-5.png',
    ).then((onValue) {
      destinationIcon = onValue;
    });
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(48, 48)),
      'assets/img/map/marker-3.png',
    ).then((onValue) {
      sourceIcon = onValue;
    });
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(48, 48)),
      'assets/img/map/marker-1.png',
    ).then((onValue) {
      myLocationIcon = onValue;
    });
  }

  @override
  void initState() {
    setCustomMarker();
    getCurrentLocation();
    getPolyPoint();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Tracking'),
        backgroundColor: primaryColor,
      ),
      body: currentLocation == null ? const Center(child: CircularProgressIndicator()) : GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
          zoom: 20.0,
        ),
        onMapCreated: (controller) {
          _controller.complete(controller);
        },
        polylines: {
          Polyline(
            polylineId: const PolylineId('poly'),
            color: primaryColor,
            points: polylineCoordinates,
            width: 6
          ),
        },
        markers: {
          Marker(

            markerId: const MarkerId('myLocation'),
            position: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
            icon: myLocationIcon,
          ),
          Marker(
            markerId: const MarkerId('source'),
            position: sourceLocation,
            icon: sourceIcon,
          ),

          Marker(
            markerId: const MarkerId('destination'),
            position: destination,
            icon: destinationIcon,
          ),
        },
      ),
    );
  }
}
