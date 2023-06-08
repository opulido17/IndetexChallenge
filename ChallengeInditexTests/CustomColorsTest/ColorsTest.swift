//
//  ColorsTest.swift
//  ChallengeInditexTests
//
//  Created by Orlando Jose Pulido Marenco on 8/06/23.
//

@testable import ChallengeInditex
import XCTest

final class ColorsTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetColorCharacterStatus_whenStatusIsAlive_thenReturnGreenColor() {
        let status = "ALIVE"
        let getColor = CustomColor.getColorCharacterStatus(status)
        XCTAssertEqual(getColor, CustomColor.lightGreen)
    }
    
    func testGetColorCharacterStatus_whenStatusIsDead_thenReturnDarkRedColor() {
        let status = "DEAD"
        let getColor = CustomColor.getColorCharacterStatus(status)
        XCTAssertEqual(getColor, CustomColor.darkRed)
    }
    
    func testGetColorCharacterStatus_whenStatusIsAlive_thenReturnOpaqueGrayColor() {
        let status = "UNKOWN"
        let getColor = CustomColor.getColorCharacterStatus(status)
        XCTAssertEqual(getColor, CustomColor.opaqueGray)
    }
}
