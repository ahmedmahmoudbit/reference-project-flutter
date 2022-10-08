//   flutter_map: ^3.0.0
//   latlong2: ^0.8.1



// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:untitled/maps/pages/animat_map/model/model_map.dart';
//
// // styles : https://docs.mapbox.com/api/maps/styles/
// const String TOKEN_KEy =
//     'pk.eyJ1IjoiYWhtZWRtOTl6IiwiYSI6ImNsOHlsMWhhbjBkOHEzeHAybzdkZzJhcWYifQ.z6p3syK-8MqitQZM2l4RAQ';
// const String styleMapDark = 'mapbox/dark-v10';
// const String styleMapNatural = 'mapbox/satellite-v9';
// const String styleMapCartoon = 'mapbox/outdoors-v11';
//
// const Color MARKER_COLOR = Color(0xff3dc5a7);
// final LatLng _myLocation = LatLng(30.046772, 31.231778);
// const double markerSizeExpanded = 50.0;
// const double markerSizeSmall = 35.0;
//
// class MapsAnimation extends StatefulWidget {
//   const MapsAnimation({Key? key}) : super(key: key);
//
//   @override
//   State<MapsAnimation> createState() => _MapsAnimationState();
// }
//
// class _MapsAnimationState extends State<MapsAnimation>
//     with SingleTickerProviderStateMixin {
//   late final AnimationController _animatedContainer;
//   final pageController = PageController();
//   int selectIndex = 0;
//   LatLng _center = _myLocation;
//
//   List<Marker> buildMarker() {
//     final markerList = <Marker>[];
//     for (int i = 0; i < listMap.length; i++) {
//       final mapItem = listMap[i];
//       markerList.add(Marker(
//           height: markerSizeExpanded,
//           width: markerSizeExpanded,
//           point: mapItem.location,
//           builder: (_) {
//             return GestureDetector(
//               onTap: () {
//                 setState(() {
//                   selectIndex = i;
//                   pageController.animateToPage(i,
//                       duration: const Duration(milliseconds: 500),
//                       curve: Curves.easeInOut);
//                   print('Marker ${mapItem.title} was tapped');
//                 });
//               },
//               child: LocationMarker(
//                 isSelected: selectIndex == i,
//               ),
//             );
//           }));
//     }
//     return markerList;
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _animatedContainer = AnimationController(
//         vsync: this, duration: const Duration(milliseconds: 600));
//     _animatedContainer.repeat(reverse: true);
//   }
//
//   @override
//   void dispose() {
//     _animatedContainer.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final markers = buildMarker();
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xff2b2b2d),
//         title: const Text(
//           'Maps Animation',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: Stack(
//         children: [
//           FlutterMap(
//             options: MapOptions(
//               center: _center,
//               zoom: 16,
//
//             ),
//             children: [
//               TileLayer(
//                 urlTemplate:
//                     'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
//                 additionalOptions: {
//                   'accessToken': TOKEN_KEy,
//                   'id': styleMapDark,
//                 },
//               ),
//               MarkerLayer(
//                 markers: markers,
//               ),
//               MarkerLayer(
//                 markers: [
//                   Marker(
//                     width: 50.0,
//                     height: 50.0,
//                     point: _myLocation,
//                     builder: (ctx) => MyLocationMarker(_animatedContainer),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           Positioned(
//             left: 0,
//             right: 0,
//             bottom: 30,
//             height: MediaQuery.of(context).size.height * 0.3,
//             child: PageView.builder(
//               controller: pageController,
//               onPageChanged: (index) {
//                 setState(() {
//                   selectIndex = index;
//                   _center = listMap[index].location;
//                 });
//               },
//               itemBuilder: (_, index) {
//                 print('index $index');
//                 final item = listMap[index];
//                 return MapItemDetails(
//                   mapModel: item,
//                 );
//               },
//               itemCount: listMap.length,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class MyLocationMarker extends AnimatedWidget {
//   const MyLocationMarker(Animation<double> animation, {Key? key})
//       : super(key: key, listenable: animation);
//   final size = 50;
//
//   @override
//   Widget build(BuildContext context) {
//     final value = (listenable as Animation<double>).value;
//     final newValue = (lerpDouble(0.5, 1, value))!;
//
//     return Center(
//       child: Stack(
//         children: [
//           Center(
//             child: Container(
//               width: newValue * size,
//               height: newValue * size,
//               decoration: BoxDecoration(
//                 color: MARKER_COLOR.withOpacity(0.5),
//                 shape: BoxShape.circle,
//               ),
//             ),
//           ),
//           Center(
//             child: Container(
//               width: 15,
//               height: 15,
//               decoration: BoxDecoration(
//                 color: MARKER_COLOR,
//                 shape: BoxShape.circle,
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
//
// class MapItemDetails extends StatelessWidget {
//   final MapModel mapModel;
//
//   const MapItemDetails({Key? key, required this.mapModel}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(20),
//       child: Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         color: const Color(0xfffffefe),
//         child: Column(
//           children: [
//             Expanded(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: ClipRRect(
//                           borderRadius: BorderRadius.circular(20),
//                           child: Image.network(
//                             mapModel.image,
//                             fit: BoxFit.cover,
//                           )),
//                     ),
//                   ),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           mapModel.title,
//                           style: const TextStyle(
//                               fontSize: 22,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black),
//                         ),
//                         Text(
//                           mapModel.address,
//                           style: const TextStyle(
//                               fontSize: 15, fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
//               child: MaterialButton(
//                 onPressed: () {},
//                 color: MARKER_COLOR,
//                 minWidth: double.infinity,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Text(
//                   'call',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class LocationMarker extends StatelessWidget {
//   const LocationMarker({Key? key, this.isSelected = false}) : super(key: key);
//   final bool isSelected;
//
//   @override
//   Widget build(BuildContext context) {
//     final size = isSelected ? markerSizeExpanded : markerSizeSmall;
//     return Center(
//       child: AnimatedContainer(
//         height: size,
//         width: size,
//         duration: const Duration(milliseconds: 400),
//         child: Image.asset('assets/img/icon/marker.png'),
//       ),
//     );
//   }
// }
