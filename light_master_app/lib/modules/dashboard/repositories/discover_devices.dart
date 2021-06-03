import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bonsoir/bonsoir.dart';
import 'package:flutter/material.dart';
import 'package:light_master_app/modules/dashboard/models/light.dart';
import 'package:light_master_app/modules/dashboard/models/light_source.dart';
import 'package:light_master_app/modules/dashboard/repositories/wled_rest_client.dart';
import 'package:http/http.dart' as http;
import 'package:multicast_dns/multicast_dns.dart';
import 'package:universal_platform/universal_platform.dart';

/// Provider model that allows to handle Bonsoir discoveries.
class WLEDDiscoveryModel extends ChangeNotifier {
  final WledRestClient wled;
  static const String type = '_http._tcp';
  final _controller = StreamController<List<LightSource>>();

  /// The current Bonsoir discovery object instance.
  BonsoirDiscovery _bonsoirDiscovery;

  /// The current MDnsClient discovery object instance.
  MDnsClient _mdnsDiscovery;

  /// Contains all discovered (and resolved) services.
  final List<LightSource> _resolvedServices = [];

  /// The subscription object.
  StreamSubscription<BonsoirDiscoveryEvent> _subscriptionBonsoir;
  Stream<PtrResourceRecord> _subscriptionMDnsClient;

  /// Creates a new Bonsoir discovery model instance.
  WLEDDiscoveryModel(this.wled) {
    start();
  }

  /// Returns all discovered (and resolved) services.
  List<LightSource> get discoveredServices => List.of(_resolvedServices);

  Stream<List<LightSource>> get discoverWLEDDevices => _controller.stream;

  /// Starts the Bonsoir discovery.
  Future<void> start() async {
    if (UniversalPlatform.isIOS || UniversalPlatform.isAndroid) {
      if (_bonsoirDiscovery == null || _bonsoirDiscovery.isStopped) {
        _bonsoirDiscovery = BonsoirDiscovery(type: type);
        await _bonsoirDiscovery.ready;
      }

      await _bonsoirDiscovery.start();
      _subscriptionBonsoir =
          _bonsoirDiscovery.eventStream.listen(_onEventOccurredBonsoir);
    } else if (!UniversalPlatform.isWeb) {
      if (_mdnsDiscovery == null) {
        _mdnsDiscovery = MDnsClient();
      }
      await _mdnsDiscovery.start();
      _subscriptionMDnsClient = _mdnsDiscovery
          .lookup<PtrResourceRecord>(ResourceRecordQuery.serverPointer(type));
      _subscriptionMDnsClient.listen(_onEventOccurredMDnsClient);
    }
  }

  /// Stops the Bonsoir discovery.
  void stop() {
    if (UniversalPlatform.isIOS) {
      _subscriptionBonsoir?.cancel();
      _subscriptionBonsoir = null;
      _bonsoirDiscovery?.stop();
    } else if (!UniversalPlatform.isWeb) _mdnsDiscovery.stop();
  }

  /// Triggered when a Bonsoir discovery event occurred.
  Future<void> _onEventOccurredBonsoir(BonsoirDiscoveryEvent event) async {
    if (event.service == null || !event.isServiceResolved) {
      return;
    }

    if (event.type == BonsoirDiscoveryEventType.DISCOVERY_SERVICE_RESOLVED) {
      ResolvedBonsoirService service = event.service;
      try {
        var state = await wled.fetchState(service.ip);
        var mainseg = state['state']['seg'][state['state']['mainseg']];
        final light = LightSource(
            service.ip,
            state['info']['name'],
            state['state']['on'],
            mainseg['fx'] == 0
                ? SolidLight(Color.fromRGBO(mainseg['col'][0][0],
                    mainseg['col'][0][1], mainseg['col'][0][2], 1))
                : EffectLight(mainseg['fx'], mainseg['bri'], mainseg['sx']));
        _resolvedServices.add(light);
        notifyListeners();
        _controller.sink.add(_resolvedServices);
        log("${light.toString()} is a WLED-Instance");
      } catch (e) {
        log("$service is not a WLED-Instance");
      }
    }
  }

  /// Triggered when a MDnsClient discovery event occurred.
  Future<void> _onEventOccurredMDnsClient(PtrResourceRecord ptr) async {
    await for (final SrvResourceRecord srv
        in _mdnsDiscovery.lookup<SrvResourceRecord>(
            ResourceRecordQuery.service(ptr.domainName))) {
      await for (final IPAddressResourceRecord ip
          in _mdnsDiscovery.lookup<IPAddressResourceRecord>(
              ResourceRecordQuery.addressIPv4(srv.target))) {
        try {
          var state = await wled.fetchState(ip.address.address);
          var mainseg = state['state']['seg'][state['state']['mainseg']];
          final light = LightSource(
              ip.address.address,
              state['info']['name'],
              state['state']['on'],
              mainseg['fx'] == 0
                  ? SolidLight(Color.fromRGBO(mainseg['col'][0][0],
                      mainseg['col'][0][1], mainseg['col'][0][2], 1))
                  : EffectLight(mainseg['fx'], mainseg['bri'], mainseg['sx']));
          _resolvedServices.add(light);
          notifyListeners();
          _controller.sink.add(_resolvedServices);
          log("${light.toString()} is a WLED-Instance");
        } catch (e) {
          log("${srv.name} is not a WLED-Instance");
        }
      }
      await for (final IPAddressResourceRecord ip
          in _mdnsDiscovery.lookup<IPAddressResourceRecord>(
              ResourceRecordQuery.addressIPv6(srv.target))) {
        try {
          var state = await wled.fetchState(ip.address.address);
          var mainseg = state['state']['seg'][state['state']['mainseg']];
          final light = LightSource(
              ip.address.address,
              state['info']['name'],
              state['state']['on'],
              mainseg['fx'] == 0
                  ? SolidLight(Color.fromRGBO(mainseg['col'][0][0],
                      mainseg['col'][0][1], mainseg['col'][0][2], 1))
                  : EffectLight(mainseg['fx'], mainseg['bri'], mainseg['sx']));
          _resolvedServices.add(light);
          notifyListeners();
          _controller.sink.add(_resolvedServices);
          log("${light.toString()} is a WLED-Instance");
        } catch (e) {
          log("${srv.name} is not a WLED-Instance");
        }
      }
    }
  }

  @override
  void dispose() {
    stop();
    _controller.close();
    super.dispose();
  }
}
