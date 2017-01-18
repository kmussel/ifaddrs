
//
//  IPAddressTests.swift
//  service
//
//  Created by Mac Bellingrath on 1/10/17.
//
//
import XCTest
@testable import Ifaddrs

class IPAddressTests: XCTestCase {
  
  let testSubject = IPAddress.self
  
  func testGetsCurrentIPAddress() {
    let ipAddress = testSubject.current()
    XCTAssertNotEqual("0.0.0.0", ipAddress)
  }
}