import 'dart:developer';
import 'dart:io';

import 'package:light_master_app/modules/dashboard/repositories/wled_rest_client.dart';
import 'package:multicast_dns/multicast_dns.dart';
import 'package:http/http.dart' as http;

class WLEDDevice {
  final String HostName;
  final InternetAddress Ip;
  const WLEDDevice(this.HostName, this.Ip);

  @override
  String toString() {
    return HostName + ' - ' + Ip.address;
  }
}

Stream<WLEDDevice> discoverWLEDDevices() async* {
  const String name = '_http._tcp';
  final MDnsClient client = MDnsClient();
  final WledRestClient wled = WledRestClient(httpClient: http.Client());

  // Start the client with default options.
  await client.start();
  await for (final PtrResourceRecord ptr in client
      .lookup<PtrResourceRecord>(ResourceRecordQuery.serverPointer(name))) {
    await for (final SrvResourceRecord srv in client.lookup<SrvResourceRecord>(
        ResourceRecordQuery.service(ptr.domainName))) {
      await for (final IPAddressResourceRecord ip
          in client.lookup<IPAddressResourceRecord>(
              ResourceRecordQuery.addressIPv4(srv.target))) {
        try {
          var state = await wled.fetchState(ip.address.address);
          yield WLEDDevice(state['info']['name'], ip.address);
        } catch (e) {
          log("${srv.name} is not a WLED-Instance");
        }
      }
      await for (final IPAddressResourceRecord ip
          in client.lookup<IPAddressResourceRecord>(
              ResourceRecordQuery.addressIPv6(srv.target))) {
        try {
          var state = await wled.fetchState(ip.address.address);
          yield WLEDDevice(state['info']['name'], ip.address);
        } catch (e) {
          log("${srv.name} is not a WLED-Instance");
        }
      }
    }
  }
  client.stop();
}
