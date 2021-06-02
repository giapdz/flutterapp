import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/models/request.dart';
import 'package:foodapp/models/state.dart';
import 'package:foodapp/ui/widgets/card_infomation.dart';
import 'package:foodapp/util/auth.dart';
import 'package:foodapp/util/state_widget.dart';
import 'package:foodapp/wemap/route.dart';
import 'package:wemapgl/wemapgl.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';


class FullMap extends StatefulWidget {
  const FullMap();

  @override
  State<StatefulWidget> createState() => FullMapState();
}

class FullMapState extends State<FullMap> {
  FullMapState();
  static final CameraPosition _kInitialPosition = const CameraPosition(
    target: LatLng(21.038282, 105.782885),
    zoom: 11.0,
  );
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
  RequestModel _userNeedHelp;
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
    initTokenFCM();
    _position = _kInitialPosition;
    _isMoving = true;
    weMap = WeMap(
      initialCameraPosition: _kInitialPosition,
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

    mapController.addListener(_onMapChanged);
    mapController.onSymbolTapped.add(_onSymbolTapped);
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

  _updateSelectedSymbol(SymbolOptions changes) {
    if (_selectedSymbol != null)
      mapController.updateSymbol(_selectedSymbol, changes);
  }

  // _add(LatLng latlng, Map<String, dynamic> requestData, String uid) async {
  //   Symbol symbol = await mapController?.addSymbol(
  //       SymbolOptions(
  //         geometry: latlng,
  //         iconImage: "assets/symbols/help.png",
  //       ),
  //       requestData);
  //   userSymbol.update(uid, (value) => symbol, ifAbsent: () => symbol);
  //   userSymbolData.update(uid, (value) => requestData,
  //       ifAbsent: () => requestData);
  //
  //   // setState(() {
  //   //   _symbolCount += 1;
  //   // });
  // }
  //
  // _remove(String uid) {
  //   var symbol = userSymbol[uid];
  //   if (symbol != null) {
  //     mapController.removeSymbol(symbol);
  //   }
  //
  //   // setState(() {
  //   //   _symbolCount -= 1;
  //   // });
  // }

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
    // mapController.moveCamera(CameraUpdate.newCameraPosition(
    //   CameraPosition(
    //     target: myLocation,
    //     zoom: 14.0,
    //   ),
    // ),
    // );
    // WeMapSearchBar(
    //   location: myLocation,
    //   onSelected: (_place) {
    //     setState(() {
    //       place = _place;
    //     });
        mapController.moveCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: myLocation,
              zoom: 14.0,
            ),
          ),
        );
        // mapController.showPlaceCard(place);
      // },
      // onClearInput: () {
      //   setState(() {
      //     place = null;
      //     mapController.showPlaceCard(place);
      //   });
      // };
    // );
    _updateCurrentLocation();
  }

  Future<void> _updateCurrentLocation() async {
    LatLng myLocation = await mapController.requestMyLocationLatLng();
    setState(() {
      myLatLng = myLocation;
    });
    Auth.updateLocationUserFirestore(
        appState.user.userId, myLocation.latitude, myLocation.longitude);
  }



  // _updateHelper(RequestModel requestModel) {
  //   setState(() {
  //     _userNeedHelp = requestModel;
  //   });
  // }


  _drawRoute() async {
    if (_isDrawRouter) {
        mapController.clearCircles();
        mapController.clearLines();
      return WeMapSearchBar(
        location: myLatLng,
        onSelected: (_place) {
          setState(() {
            place = _place;
          });
          mapController.moveCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: place.location,
                zoom: 14.0,
              ),
            ),
          );
          mapController.showPlaceCard(place);
        },
        onClearInput: () {
          setState(() {
            place = null;
            mapController.showPlaceCard(place);
          });
        },
      );
    }
    if (_userNeedHelp == null || _userNeedHelp.place == null) return;
    if (myLatLng == null) {
      await _updateCurrentLocation();
      if (myLatLng == null) {
        print("Không lấy được vị trí");
        return;
      }
    }
    mapController.clearCircles();
    mapController.clearLines();
    List<LatLng> points = [];
    points.add(myLatLng);
    points.add(_userNeedHelp.place.location);
    final json = await directionAPI.getResponseMultiRoute(
        0, points); //0 = car, 1 = bike, 2 = foot
    List<LatLng> _route = directionAPI.getRoute(json);
    List<LatLng> _waypoins = directionAPI.getWayPoints(json);
    if (_route != null) {
      await mapController.addLine(
        LineOptions(
          geometry: _route,
          lineColor: "#00904a",
          lineWidth: 5.0,
          lineOpacity: 1,
        ),
      );
      await mapController.addCircle(CircleOptions(
          geometry: _waypoins[0],
          circleRadius: 8.0,
          circleColor: '#d3d3d3',
          circleStrokeWidth: 1.5,
          circleStrokeColor: '#00904a'));
      for (int i = 1; i < _waypoins.length; i++) {
        await mapController.addCircle(CircleOptions(
            geometry: _waypoins[i],
            circleRadius: 8.0,
            circleColor: '#ffffff',
            circleStrokeWidth: 1.5,
            circleStrokeColor: '#00904a'));
      }
      setState(() {
        _isDrawRouter = true;
      });
    }
  }

  Future<void> initTokenFCM() async {
    String token = await FirebaseMessaging.instance.getToken();
    await saveTokenToDatabase(token);
    FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);
  }

  Future<void> saveTokenToDatabase(String token) async {
    // Assume user is logged in for this example
    String userId = FirebaseAuth.instance.currentUser.uid;

    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'tokens': token,
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
                stream: FirebaseFirestore.instance
                    .collection('requests')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    RequestModel userNeedHelp;
                    RequestModel myHelp;
                    //mapController?.clearSymbols();
                    var newListRequest = snapshot.data.docs
                        .map((e) => RequestModel.fromDocument(e));

                    // userSymbol.removeWhere((key, value) {
                    //   var list = newListRequest
                    //       .where((element) => element.userId == key);
                    //   if (list.isEmpty) {
                    //     _remove(key);
                    //     userSymbolData.remove(key);
                    //   }
                    //   return list.isEmpty;
                    // });

                    newListRequest.forEach((newRequest) {
                      if (newRequest.place != null) {
                        var oldSymbol = userSymbol[newRequest.userId];
                        var oldDataJson = userSymbolData[newRequest.userId];
                        var oldData = oldDataJson != null
                            ? RequestModel.fromJson(oldDataJson)
                            : null;
                        // if (oldSymbol != null) {
                        //   if (oldData.createAt != newRequest.createAt ||
                        //       oldData.status != newRequest.status ||
                        //       oldData.helperId != newRequest.helperId) {
                        //     _remove(newRequest.userId);
                        //     _add(newRequest.place.location, newRequest.toJson(),
                        //         newRequest.userId);
                        //   }
                        // } else {
                        //   _add(newRequest.place.location, newRequest.toJson(),
                        //       newRequest.userId);
                        // }

                        // Nếu đang trợ giúp ai đó
                        if (newRequest.helperId == appState.user.userId &&
                            newRequest.status == "waiting") {
                          userNeedHelp = newRequest;
                        }
                        if (newRequest.userId == appState.user.userId) {
                          myHelp = newRequest;
                        }
                      }
                    });
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      // _updateHelper(userNeedHelp);
                    });
                  }

                  _drawRoute();
                  return weMap;
                }),
          if (_selectedSymbol != null)
            new Container(
              alignment: Alignment.center,
              child: CardInfomation(
                requestModel: RequestModel.fromJson(_selectedSymbol.data),
                onCloseBtn: _onUnSelectedSymbol,
                onOpenMapBtn: () {
                  WeMapPlace mylocation = WeMapPlace(location: myLatLng);
                  WeMapPlace destination =
                      RequestModel.fromJson(_selectedSymbol.data).place;
                  Navigator.pushNamed(context, '/route-page',
                      arguments: ScreenRouteArguments(mylocation, destination));
                },
              ),
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
        // orientation: SpeedDialOrientation.Down,
        // childMarginBottom: 2,
        // childMarginTop: 2,
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
