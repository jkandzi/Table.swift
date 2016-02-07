//
//  Table_swiftTests.swift
//  Table.swiftTests
//
//  Created by Justus Kandzi on 30/01/16.
//  Copyright © 2016 Justus Kandzi. All rights reserved.
//

import XCTest
@testable import Table

class MockPrinter: PrinterType {
    
    var lines = [String]()
    
    func put(string: String) {
        print(string)
        lines.append(string)
    }
}

class PrettyTableTests: XCTestCase {
    var table: Table!
    var printer: MockPrinter!
    
    override func setUp() {
        super.setUp()
        
        table = Table()
        printer = MockPrinter()
        table.printer = printer
    }
    
    override func tearDown() {
        table = nil
        
        super.tearDown()
    }
    
    func testEmptyTable() {
        let array = [[String]]()
        table.put(array)
        XCTAssertEqual(printer.lines[0], "")
    }
    
    func testSingleElementTable() {
        table.put([[1]])
        XCTAssertEqual(printer.lines[0], "+---+")
        XCTAssertEqual(printer.lines[1], "| 1 |")
        XCTAssertEqual(printer.lines[2], "+---+")
    }
    
    func testSingleElementTableWithDifferentSize() {
        table.put([[100]])
        XCTAssertEqual(printer.lines[0], "+-----+")
        XCTAssertEqual(printer.lines[1], "| 100 |")
        XCTAssertEqual(printer.lines[2], "+-----+")
    }
    
    func testTwoDimensionalTable() {
        table.put([[1, 2]])
        XCTAssertEqual(printer.lines[0], "+---+---+")
        XCTAssertEqual(printer.lines[1], "| 1 | 2 |")
        XCTAssertEqual(printer.lines[2], "+---+---+")
    }
    
    func testThreeDimensionalTable() {
        table.put([[1, 2], [3, 4]])
        XCTAssertEqual(printer.lines[0], "+---+---+")
        XCTAssertEqual(printer.lines[1], "| 1 | 2 |")
        XCTAssertEqual(printer.lines[2], "+---+---+")
        XCTAssertEqual(printer.lines[3], "| 3 | 4 |")
        XCTAssertEqual(printer.lines[4], "+---+---+")
    }
    
    func testTwoDimensionalTableWithDifferentSizes() {
        table.put([[0, 1000]])
        XCTAssertEqual(printer.lines[0], "+---+------+")
        XCTAssertEqual(printer.lines[1], "| 0 | 1000 |")
        XCTAssertEqual(printer.lines[2], "+---+------+")
    }
    
    func testThreeDimensionalTableWithDifferentSizes() {
        table.put([[10, 2000], [300, 4]])
        XCTAssertEqual(printer.lines[0], "+-----+------+")
        XCTAssertEqual(printer.lines[1], "| 10  | 2000 |")
        XCTAssertEqual(printer.lines[2], "+-----+------+")
        XCTAssertEqual(printer.lines[3], "| 300 | 4    |")
        XCTAssertEqual(printer.lines[4], "+-----+------+")
    }
    
    func testStringTable() {
        table.put([["A", "B", "C"], ["X", "XX", "XXX"], ["Hello", "World", "!"]])
        XCTAssertEqual(printer.lines[0], "+-------+-------+-----+")
        XCTAssertEqual(printer.lines[1], "| A     | B     | C   |")
        XCTAssertEqual(printer.lines[2], "+-------+-------+-----+")
        XCTAssertEqual(printer.lines[3], "| X     | XX    | XXX |")
        XCTAssertEqual(printer.lines[4], "+-------+-------+-----+")
        XCTAssertEqual(printer.lines[5], "| Hello | World | !   |")
        XCTAssertEqual(printer.lines[6], "+-------+-------+-----+")
    }
    
    func testBigTable() {
        let array = (1...20).map { x in
            (1...20).reduce([Int]()) { $0 + [x * $1] }
        }
        table.put(array)
    }
}
