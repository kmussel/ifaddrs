//
//  IPAddress.swift
//  service
//
//  Created by Mac Bellingrath on 1/10/17.
//
//
import Foundation
import CIfaddrs

public struct IPAddress {
  
  /// current IP address
  ///
  /// - Returns: a string representation of devices current ip address, or 0.0.0.0 if operation fails
  public static func current() -> String {
    let defaultAddress = "0.0.0.0"
    var ifaddr : UnsafeMutablePointer<ifaddrs>?
    
    guard getifaddrs(&ifaddr) == 0,
      let firstAddr = ifaddr else {
      return defaultAddress
    }
    
    defer {
      freeifaddrs(ifaddr)
    }
    
    // sequence of each interface on machine (ie wifi, cellular, bluetooth)
    return sequence(first: firstAddr, next: { $0.pointee.ifa_next })
      .lazy
      .flatMap { $0.pointee }
      .filter(isIPv4OrIPv6)
      .sorted(by: wifiThenCellularThenOther)
      .flatMap(readableString)
      .first ?? defaultAddress
  }
  
  
  /// IPv4 or IPv6
  ///
  /// - Returns: true if interface pointee's sa_family matches id for ipv4 or ipv6, otherwise false
  private static func isIPv4OrIPv6(interface: ifaddrs) -> Bool {
    let familyname = interface.ifa_addr.pointee.sa_family
    return familyname == UInt8(AF_INET) || familyname == UInt8(AF_INET6)
  }
  
  /// isWifiOrCellular
  ///
  /// - Parameter interface: ifaddrs
  /// - Returns: a bool if interfacename matches identifier for wifi or cellular
  private static func wifiThenCellularThenOther(interfaceOne one: ifaddrs, interfaceTwo two: ifaddrs) -> Bool {
      let name = String(cString: one.ifa_name)
      return name == IPAddress.wifi || name == IPAddress.cellular
  }
  
  /// readable string from interface
  ///
  /// - Parameter interface: ifaddrs
  /// - Returns: optional string, nil if operation fails
  private static func readableString(fromInterface interface: ifaddrs) -> String? {
    var addr = interface.ifa_addr.pointee
    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
    getnameinfo(&addr, socklen_t(interface.ifa_addr.pointee.sa_len), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
    return String(cString: hostname)
  }
  
  private static let cellular    = "pdp_ip0"
  private static let wifi        = "en0"
  private static let ipv4        = "ipv4"
  private static let ipv6        = "ipv6"
}