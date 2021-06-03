import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:HotelsHN/models/state.dart';
import 'package:HotelsHN/util/auth.dart';
import 'package:HotelsHN/util/state_widget.dart';
import 'package:HotelsHN/wemap/route.dart';
import 'package:wemapgl/wemapgl.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:HotelsHN/models/hotel.dart';
class FullMap extends StatefulWidget {
  Hotel hotel;
  FullMap({this.hotel});

  @override
  State<StatefulWidget> createState() => FullMapState();
}

class FullMapState extends State<FullMap> {
  FullMapState();

  StateModel appState;
  static WeMap weMap;
  WeMapController mapController;
  CameraPosition _position;
  bool _isMoving;
  LatLng myLatLng;
  bool reverse = true;
  WeMapPlace place;

  //int _symbolCount;
  Symbol _selectedSymbol;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  WeMapDirections directionAPI = WeMapDirections();

  //Stream<QuerySnapshot> listRequest;
  bool _isDrawRouter = false;
  Map<String, Symbol> userSymbol = new Map();
  Map<String, Map<String, dynamic>> userSymbolData = new Map();

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }


  @override
  void initState() {
    _position = CameraPosition(
      target: widget.hotel.coordinate,
      zoom: 14.0,
    );
    _isMoving = true;
    weMap = WeMap(
      initialCameraPosition: CameraPosition(
        target: widget.hotel.coordinate,
        zoom: 14.0,
      ),
      onMapCreated: onMapCreated,
      trackCameraPosition: true,
      compassEnabled: true,
      cameraTargetBounds: CameraTargetBounds.unbounded,
      minMaxZoomPreference: MinMaxZoomPreference.unbounded,
      styleString: WeMapStyles.WEMAP_VECTOR_STYLE,
      rotateGesturesEnabled: true,
      scrollGesturesEnabled: true,
      tiltGesturesEnabled: true,
      zoomGesturesEnabled: true,
      myLocationEnabled: true,
      onStyleLoadedCallback: () => _getCurrentLocation(),
      reverse: false,
    );

    super.initState();
  }

  onMapCreated(WeMapController controller) {
    mapController = controller;
    controller.addListener(_onMapChanged);
    controller.onSymbolTapped.add(_onSymbolTapped);
    Timer(Duration(seconds: 1), () =>controller.addSymbol(
      SymbolOptions(
          geometry: widget.hotel.coordinate,
          iconImage: "assets/symbols/icon.png"),
    ));
    _extractMapInfo();
  }

  @override
  void dispose() {
    mapController.removeListener(_onMapChanged);
    mapController?.onSymbolTapped?.remove(_onSymbolTapped);
    super.dispose();
  }

  _onMapChanged() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _extractMapInfo();
      });
    });
  }

  void _extractMapInfo() {
    _position = mapController.cameraPosition;
    _isMoving = mapController.isCameraMoving;
  }

  _onSymbolTapped(Symbol symbol) {
    if (_selectedSymbol != null) {
      _updateSelectedSymbol(
        const SymbolOptions(iconSize: 1.0),
      );
    }
    setState(() {
      _selectedSymbol = symbol;
    });
    _updateSelectedSymbol(
      SymbolOptions(iconSize: 1.4),
    );
  }

  _onUnSelectedSymbol() {
    if (_selectedSymbol != null)
      _updateSelectedSymbol(
        const SymbolOptions(iconSize: 1.0),
      );
    setState(() {
      _selectedSymbol = null;
    });
  }

  _updateSelectedSymbol(SymbolOptions changes) async {
    if (_selectedSymbol != null)
      mapController.updateSymbol(_selectedSymbol, changes);
  }


  void _changePosition() {
    final LatLng current = _selectedSymbol.options.geometry;
    final Offset offset = Offset(
      myLatLng.latitude - current.latitude,
      myLatLng.longitude - current.longitude,
    );
    _updateSelectedSymbol(
      SymbolOptions(
        geometry: LatLng(
          myLatLng.latitude + offset.dy,
          myLatLng.longitude + offset.dx,
        ),
      ),
    );
  }

  _getCurrentLocation() async {
    LatLng myLocation = await mapController.requestMyLocationLatLng();
    mapController.moveCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: widget.hotel.coordinate,
        zoom: 14.0,
      ),
    ),
    );

    // _updateCurrentLocation();

  }

  Future<void> _updateCurrentLocation() async {
    LatLng myLocation = await mapController.requestMyLocationLatLng();
    setState(() {
      myLatLng = myLocation;
    });
  }



  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }



  @override
  Widget build(BuildContext context) {
    // print('${widget.hotel.coordinate}');
    appState = StateWidget.of(context).state;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Xem trên bản đồ'),
      ),
      body: Stack(
        children: <Widget>[
          if (weMap != null)
            StreamBuilder<QuerySnapshot>(
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {

                  return weMap;
                }),

          if (_selectedSymbol != null)
            new Container(
              alignment: Alignment.center,
            ),
            new SafeArea(
              child: Container(
                alignment: Alignment.topCenter,
              ),
            )
        ],
      ),
      floatingActionButton: SpeedDial(
        /// both default to 16
        marginEnd: 18,
        marginBottom: 20,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),

        /// This is ignored if animatedIcon is non null
        // icon: Icons.menu,
        // activeIcon: Icons.close,
        // iconTheme: IconThemeData(color: Colors.grey[50], size: 30),

        /// Transition Builder between label and activeLabel, defaults to FadeTransition.
        // labelTransitionBuilder: (widget, animation) =>
        //     ScaleTransition(scale: animation, child: widget),

        /// The below button size defaults to 56 itself, its the FAB size + It also affects relative padding and other elements
        buttonSize: 56.0,
        visible: true,

        /// If true user is forced to close dial manually
        /// by tapping main button and overlay is not rendered.
        closeManually: false,

        /// If true overlay will render no matter what.
        renderOverlay: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        tooltip: 'Chức năng',
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        elevation: 8.0,
        shape: CircleBorder(),

        children: [
          SpeedDialChild(
            child: Icon(Icons.place),
            backgroundColor: Colors.orange,
            label: 'Chỉ đường',
            labelStyle: TextStyle(fontSize: 16.0, color: Colors.black),
            labelBackgroundColor: Colors.white,
            onTap: () => Navigator.pushNamed(context, '/route-page'),
            onLongPress: () => print('FIRST CHILD LONG PRESS'),
          ),
          SpeedDialChild(
            child: Icon(Icons.gps_fixed),
            backgroundColor: Colors.orange,
            label: 'Cập nhật vị trí',
            labelStyle: TextStyle(fontSize: 16.0, color: Colors.black),
            labelBackgroundColor: Colors.white,
            onTap: () => _getCurrentLocation(),
            onLongPress: () => print('SECOND CHILD LONG PRESS'),
          ),
        ],
      ),
    );
  }

}
