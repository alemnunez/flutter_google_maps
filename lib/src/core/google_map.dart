// Copyright (c) 2020, the MarchDev Toolkit project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';

import 'package:google_directions_api/google_directions_api.dart'
    show GeoCoord, DirectionsService;

import 'map_operations.dart';
import 'map_preferences.dart';

import 'google_map.state.dart'
    if (dart.library.html) '../web/google_map.state.dart'
    if (dart.library.io) '../mobile/google_map.state.dart';

/// This widget will try to occupy all available space
class GoogleMap extends StatefulWidget {
  const GoogleMap({
    Key key,
    this.minZoom,
    this.maxZoom,
    this.mapStyle,
    this.initialZoom = _zoom,
    this.mapType = MapType.roadmap,
    this.initialPosition = const GeoCoord(_defaultLat, _defaultLng),
    this.mobilePreferences = const MobileMapPreferences(),
    this.webPreferences = const WebMapPreferences(),
  })  : assert(mapType != null),
        assert(initialPosition != null),
        assert(initialZoom != null),
        assert(mobilePreferences != null),
        assert(webPreferences != null),
        super(key: key);

  /// The initial position of the map's camera.
  final GeoCoord initialPosition;

  /// The initial zoom of the map's camera.
  final double initialZoom;

  /// Type of map tiles to be rendered.
  final MapType mapType;

  /// The preferred minimum zoom level or null, if unbounded from below.
  final double minZoom;

  /// The preferred maximum zoom level or null, if unbounded from above.
  final double maxZoom;

  /// Sets the styling of the base map.
  ///
  /// Set to `null` to clear any previous custom styling.
  ///
  /// If problems were detected with the [mapStyle], including un-parsable
  /// styling JSON, unrecognized feature type, unrecognized element type, or
  /// invalid styler keys: [MapStyleException] is thrown and the current
  /// style is left unchanged.
  ///
  /// The style string can be generated using [map style tool](https://mapstyle.withgoogle.com/).
  /// Also, refer [iOS](https://developers.google.com/maps/documentation/ios-sdk/style-reference)
  /// and [Android](https://developers.google.com/maps/documentation/android-sdk/style-reference)
  /// style reference for more information regarding the supported styles.
  final String mapStyle;

  /// Set of mobile map preferences.
  final MobileMapPreferences mobilePreferences;

  /// Set of web map preferences.
  final WebMapPreferences webPreferences;

  static const _zoom = 12.0;
  static const _defaultLat = 34.0469058;
  static const _defaultLng = -118.3503948;

  /// Gets [MapOperations] interface via provided `key` of
  /// [GoogleMapStateBase] state.
  static MapOperations of(GlobalKey<GoogleMapStateBase> key) =>
      key.currentState;

  /// Initializer of [GoogleMap].
  ///
  /// `Required` if `Directions API` will be needed.
  /// For other cases, could be ignored.
  static void init(String apiKey) => DirectionsService.init(apiKey);

  @override
  GoogleMapState createState() => GoogleMapState();
}

abstract class GoogleMapStateBase extends State<GoogleMap>
    implements MapOperations {
  @protected
  String fixAssetPath(String icon) =>
      icon.endsWith('/marker_a.png') || icon.endsWith('/marker_b.png')
          ? 'packages/flutter_google_maps/'
          : '';
}
