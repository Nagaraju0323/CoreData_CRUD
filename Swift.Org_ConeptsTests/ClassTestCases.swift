//
//  ClassTestCases.swift
//  Swift.Org_ConeptsTests
//
//  Created by Nagaraju on 14/11/24.
//

import XCTest
import Foundation
@testable import Swift_Org_Conepts

final class ClassTestCases: XCTestCase {

    var viewController : ViewController!
    override func setUp() {
        super.setUp()
        viewController = ViewController()
    }
    
    override func tearDown() {
        super.tearDown()
        viewController = nil
    }
    
    func testMemroyManage_loading() {
        viewController.memoryManagement()
        XCTAssertTrue(viewController.manger?.empl === viewController.employee)
        XCTAssertTrue(viewController.employee?.mang === viewController.manger)
        weak var manager = viewController.manger
        weak var employee = viewController.employee
        viewController.manger = nil
        viewController.employee  = nil
        XCTAssertNil(manager)
        XCTAssertNil(employee)
    }
    
    func testProtocol_loading() {
        viewController.manageProtocol()
        XCTAssertNotNil(viewController.album?.rating)
        XCTAssertEqual(viewController.album?.rating, "4.5")
    }
   

}
