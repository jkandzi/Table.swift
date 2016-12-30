//
//  Table.swift
//  Table.swift
//
//  Created by Justus Kandzi on 30/01/16.
//  Copyright © 2016 Justus Kandzi. All rights reserved.
//

protocol PrinterType {
    func put(_ string: String)
}

struct Printer: PrinterType {
    func put(_ string: String) {
        print(string)
    }
}

public struct Table {
    
    lazy var printer: PrinterType = {
        Printer()
    }()
    
    public init() {}
    
    public mutating func put<T>(_ data: [[T]]) {
        guard let firstRow = data.first, !firstRow.isEmpty else {
            printer.put("")
            return
        }
        
        let borderString = borderStringForData(data)
        printer.put(borderString)
        
        data.forEach { row in
            let rowString = zip(row, columns(data))
                .map { String(describing: $0).padding($1.maxWidth()) }
                .reduce("|") { $0 + $1 + "|" }
            printer.put(rowString)
            printer.put(borderString)
        }
    }
    
    func borderStringForData<T>(_ data: [[T]]) -> String {
        return columns(data)
            .map { "-".repeated($0.maxWidth() + 2) }
            .reduce("+") { $0 + $1 + "+" }
    }
    
    func columns<T>(_ data: [[T]]) -> [[T]] {
        var result = [[T]]()
        for i in (0..<(data.first?.count ?? 0)) {
            result.append(data.map { $0[i] })
        }
        return result
    }
    
}

extension Array {
    func maxWidth() -> Int {
        guard let maxElement = self.max(by: { a, b in
            return String(describing: a).characters.count < String(describing: b).characters.count
        }) else { return 0 }
        return String(describing: maxElement).characters.count
    }
}

extension String {
    func padding(_ padding: Int) -> String {
        let padding = padding + 1 - self.characters.count
        guard padding >= 0 else { return self }
        return " " + self + " ".repeated(padding)
    }
    
    func repeated(_ count: Int) -> String {
        return Array(repeating: self, count: count).joined(separator: "")
    }
}
