import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:reference_project_flutter/features/maps/cubit/MapsCubit.dart';
import 'package:reference_project_flutter/features/maps/cubit/MapsState.dart';
import 'package:reference_project_flutter/features/maps/utils/location_helper.dart';
import 'package:reference_project_flutter/features/maps/webservices/webservices.dart';
import 'package:reference_project_flutter/features/maps/widgets/distance_and_time.dart';
import 'package:reference_project_flutter/features/maps/widgets/my_drawer.dart';
import 'package:reference_project_flutter/features/maps/widgets/place_item.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import 'package:reference_project_flutter/features/maps/models/Place_suggestion.dart';
import 'package:reference_project_flutter/features/maps/models/place.dart';
import 'package:reference_project_flutter/features/maps/models/place_directions.dart';


class MainMaps extends StatefulWidget {
  const MainMaps({Key? key}) : super(key: key);

  @override
  State<MainMaps> createState() => _MainMapsState();
}

class _MainMapsState extends State<MainMaps> {
  // التعرف على موقع المستخدم
  static Position? position;
  // الانتقال المباشر الى موقع المستخدم بمجرد فتح التطبيق
  final Completer<GoogleMapController> _controllerMaps = Completer();
  // المتحكم في عمليات البحث داخل التطبيق
  FloatingSearchBarController controller = FloatingSearchBarController();
  // اضافة علامه على الخريطة للموقع الذي تم البحث والانتقال اليه
  late Marker searchedPlaceMarker;
  // اضافة علامه على الخريطة لموقعك
  late Marker currentLocationMarker;
  // هل يتم عرض العناصر على الخريطة
  var progressIndicator = false;
  // هل تم اضافة الوقت والمسافه الى الخريطة
  var isTimeAndDistanceVisible = false;
  // التاكد هل تم النقر على الخريطة ام لا
  var isSearchedPlaceMarkerClicked = false;
  // العناصر التي تظهر بعد البحث عليها
  List<PlaceSuggestion> places = [];
  // اضافة علامه على الخريطة ومن نوع set لكي لا تتكرر
  Set<Marker> markers = {};
  // قيمة المكان الذي تم النقر عليه
  late Place selectedPlace;
  // تحريك الكاميرا الى الموقع الذي تم النقر عليه بعد البحث
  late CameraPosition goToSearchedForPlace;
  // معلوماات عن الموقع الذي تم البحث عنه
  late PlaceSuggestion placeSuggestion;
  late List<LatLng> polylinePoints;
  PlaceDirections? placeDirections;
  // ايقونه مخصصه على الخريطه
  Uint8List? customMarker;

  // موقع المستخدم الحالي على الخريطة
  static final CameraPosition _myCurrentLocationNow = CameraPosition(
    //عرض موقع المستخدم على الخريطة مع بعض الخصائص مثل نسبة التقريب
    // نسبة جعل الكاميرا مائله
    bearing: 0.0,
    // موقع المستخدم
    target: LatLng(position!.latitude, position!.longitude),
    tilt: 0.0,
    // نسبة التقريب
    zoom: 17,
  );

  // الانتقال الى الموقع الذي تم البحث عنده بعد النقر عليه
  void buildCameraNewPosition() {
    goToSearchedForPlace = CameraPosition(
      bearing: 0.0,
      tilt: 0.0,
      //
      target: LatLng(
        selectedPlace.result.geometry.location.lat,
        selectedPlace.result.geometry.location.lng,
      ),
      zoom: 13,
    );
  }

  // تحريك الكاميرا الى موقع المستخدم
  Future<void> getMyLocationNow() async {
    // الحصول على موقع المستخدم بمجرد فتح الخريطة وتحديث الصفحة بالموقع الحالي
    position = await LocationHelper.getCurrentLocation().whenComplete(() => setState((){}));
  }

  // تحريك الكاميرا الى الموقع الذي تم الحصول على متغيراته
  Future<void> _goToMyLocationNow() async {
    // الانتقال الى موقعي بمجرد تنفيذ هذه الوظيفة
    final GoogleMapController controller = await _controllerMaps.future;
    // الانتقال الى موقع المستخدم الموجود في CameraPosition مع انميشن بسيط لحركة الكاميرا
    controller.animateCamera(CameraUpdate.newCameraPosition(_myCurrentLocationNow));
  }

  //  الانتقال الى الموقع الذي تم البحث عنه و اضافة علامه على الخريطة
  Future<void> goToMySearchedForLocation() async {
    // بناء كاميرا جديده للتحريك
    buildCameraNewPosition();
    // تحريك الكاميرا
    final GoogleMapController controller = await _controllerMaps.future;
    controller
        .animateCamera(CameraUpdate.newCameraPosition(goToSearchedForPlace));
    // اضافة علامه على الخريطة
    buildSearchedPlaceMarker();
  }

  // اضافة علامه على الخريطة لموقع المستخدم
  void buildCurrentLocationMarker() {
    currentLocationMarker = Marker(
      position: LatLng(position!.latitude, position!.longitude),
      markerId: const MarkerId('2'),
      onTap: () {},
      infoWindow: const InfoWindow(title: "Your current Location"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );
    addMarkerToMarkersAndUpdateUI(currentLocationMarker);
  }

  // اضافة علامه على الخريطة للموقع الذي تم البحث عنه
  void buildSearchedPlaceMarker() {
    searchedPlaceMarker = Marker(
      position: goToSearchedForPlace.target,
      markerId: const MarkerId('1'),
      onTap: () {
        buildCurrentLocationMarker();
        // show time and distance
        setState(() {
          isSearchedPlaceMarkerClicked = true;
          isTimeAndDistanceVisible = true;
        });
      },
      infoWindow: InfoWindow(title: placeSuggestion.description),
      icon: BitmapDescriptor.fromBytes(customMarker!,size: const Size(100,100)),
      // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    );
    addMarkerToMarkersAndUpdateUI(searchedPlaceMarker);
  }

  // اضافة علامة داخل ال list of Marker على الخريطة
  void addMarkerToMarkersAndUpdateUI(Marker marker) {
    setState(() {
      markers.add(marker);
    });
  }

  // البحث عن مجموعه من المدن في الخريطة في شريط البحث
  void getPlacesSuggestions(String query) {
    final sessionToken = const Uuid().v4();
    BlocProvider.of<MapsCubit>(context)
        .emitPlaceSuggestions(query, sessionToken);
  }

  // ازالة جميع العلامات على الخريطة
  void removeAllMarkersAndUpdateUI() {
    setState(() {
      markers.clear();
    });
  }

  // عرض تفاصيل الموقع الذي تم النقر عليه بعد البحث
  void getSelectedPlaceLocation() {
    final sessionToken = const Uuid().v4();
    BlocProvider.of<MapsCubit>(context)
        .emitPlaceLocation(placeSuggestion.placeId, sessionToken);
  }

  // حساب المسافه بين موقعك والموقع الذي تم الانتقال اليه
  void getDirections() {
    BlocProvider.of<MapsCubit>(context).emitPlaceDirections(
      LatLng(position!.latitude, position!.longitude),
      LatLng(selectedPlace.result.geometry.location.lat,
          selectedPlace.result.geometry.location.lng),
    );
  }

  // اضافة الوقت والمسافه الى الشاشة
  void getPolylinePoints() {
    polylinePoints = placeDirections!.polylinePoints
        .map((e) => LatLng(e.latitude, e.longitude))
        .toList();
  }

  // تغيير الايقونه على الخريطه
  Future<Uint8List> changeIconLocation() async {
    ByteData byteData = await DefaultAssetBundle.of(context).load("assets/img/icon/category_2.png");
    customMarker = byteData.buffer.asUint8List();
    return byteData.buffer.asUint8List();
  }

  // الانتقال الى خرائط جوجلل مع تحديد مسار معين
  void goToGoogleMapInDevice() async {
    await launchUrl(Uri.parse(
        'google.navigation:q=${position!.latitude}, ${position!.longitude}&key=$googleAPIKey'));
  }


  @override
  void initState() {
    super.initState();
    // عرض بيانات الموقع الحالي للمستخدم عند تشغيل التطبيق
    getMyLocationNow();
    changeIconLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          position == null ? const Center(child: CircularProgressIndicator()) :
              // عرض الخريطة
          buildMaps(),
          // اضافة شريط للبحث في الاعلى
          buildFloatingSearchBar(),
          // اضافة زر للانتقال الى الموقع الحالي للمستخدم
          isSearchedPlaceMarkerClicked
          // عرض المسافة والوقت اذا كانت القيمة صحيحه
              ? DistanceAndTime(
            isTimeAndDistanceVisible: isTimeAndDistanceVisible,
            placeDirections: placeDirections,
          )
              : Container(),
        ],
      ),
      // بناء شريط جانبي
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await launchUrl(Uri.parse(
              'google.navigation:q=${30.766323999999987}, ${31.495056000000012}&key=$googleAPIKey'));

        },
        child: const Icon(Icons.location_searching),
      ),
    );
  }

  // الخريطة
  Widget buildMaps(){
    return GoogleMap(
      // نوع الخريطة
      mapType: MapType.normal,
      // وجود علامة زرقاء لاظهار موقعك الحالي على الخريطة
      myLocationEnabled: true,
      // اضافة زر في اعلى الخريطة للانتقال المباشر الى موقعك الحالي
      myLocationButtonEnabled: false,
      // وجود علامة التكبير والتصغير للخريطة في اسفل الخريطة
      zoomControlsEnabled: false,
      // الحصول على موقع المستخدم بمجرد فتح الخريطة وتحديث الصفحة بالموقع الحالي
      initialCameraPosition: _myCurrentLocationNow,
      //
      markers: markers,
      onMapCreated: (GoogleMapController controller){
        _controllerMaps.complete(controller);
      },
      // رسم خط على الخريطه
      polylines: placeDirections != null
          ? {
        Polyline(
          polylineId: const PolylineId('my_polyline'),
          color: Colors.black,
          width: 2,
          points: polylinePoints,
        ),
      }
          : {},
    );
  }

  // البحث
  Widget buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      controller: controller,
      elevation: 6,
      hintStyle: const TextStyle(fontSize: 18),
      queryStyle: const TextStyle(fontSize: 18),
      hint: 'Find a place..',
      border: const BorderSide(style: BorderStyle.none),
      margins: const EdgeInsets.fromLTRB(20, 70, 20, 0),
      padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
      height: 52,
      iconColor: Colors.blue,
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 600),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      progress: progressIndicator,
      onQueryChanged: (query) {
        getPlacesSuggestions(query);
      },
      onFocusChanged: (_) {
        // hide distance and time row
        setState(() {
          isTimeAndDistanceVisible = false;
        });
      },
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
              icon: Icon(Icons.place, color: Colors.black.withOpacity(0.6)),
              onPressed: () {}),
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              buildSuggestionsBloc(),
              buildSelectedPlaceLocationBloc(),
              buildDirectionsBloc(),
            ],
          ),
        );
      },
    );
  }

  //  حساب المسافة والوقت بين المنطقتين
  Widget buildDirectionsBloc() {
    return BlocListener<MapsCubit, MapsState>(
      listener: (context, state) {
        if (state is DirectionsLoaded) {
          placeDirections = (state).placeDirections;

          getPolylinePoints();
        }
      },
      child: Container(),
    );
  }

  // عندما يتم النقر على العنصر بعد البحث
  Widget buildSelectedPlaceLocationBloc() {
    return BlocListener<MapsCubit, MapsState>(
      listener: (context, state) {
        if (state is PlaceLocationLoaded) {
          selectedPlace = (state).place;
          // يتم الانتقال اليه
          goToMySearchedForLocation();
          // يتم حساب المسافه بين الطرفين
          getDirections();
        }
      },
      child: Container(),
    );
  }

  // عندما يتم النقر على عنصر بعد البحث
  Widget buildSuggestionsBloc() {
    return BlocBuilder<MapsCubit, MapsState>(
      builder: (context, state) {
        if (state is PlacesLoaded) {
          places = (state).places;
          if (places.isNotEmpty) {
            return buildPlacesList();
          } else {
            return Container();
          }
        } else {
          return Container();
        }
      },
    );
  }

  // عرض قائمه بجميع العناصر التي تم البحث عنها
  Widget buildPlacesList() {
    return ListView.builder(
        itemBuilder: (ctx, index) {
          return InkWell(
            onTap: () async {
              placeSuggestion = places[index];
              controller.close();
              getSelectedPlaceLocation();
              polylinePoints.clear();
              removeAllMarkersAndUpdateUI();
            },
            child: PlaceItem(
              suggestion: places[index],
            ),
          );
        },
        itemCount: places.length,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics());
  }

}