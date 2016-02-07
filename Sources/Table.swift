//
//  Table.swift
//  Table.swift
//
//  Created by Justus Kandzi on 30/01/16.
//  Copyright © 2016 Justus Kandzi. All rights reserved.
//

protocol PrinterType {
    func put(string: String)
}

struct Printer: PrinterType {
    func put(string: String) {
        print(string)
    }
}

public struct Table {
    
    lazy var printer: PrinterType = {
        Printer()
    }()
    
    public init() {}
    
    public mutating func put<T>(data: [[T]]) {
        guard let firstRow = data.first where !firstRow.isEmpty else {
            printer.put("")
            return
        }
        
        let borderString = borderStringForData(data)
        printer.put(borderString)
        
        data.forEach { row in
            let rowString = zip(row, columns(data))
                .map { String($0).padding($1.maxWidth()) }
                .reduce("|") { $0 + $1 + "|" }
            printer.put(rowString)
            printer.put(borderString)
        }
    }
    
    func borderStringForData<T>(data: [[T]]) -> String {
        return columns(data)
            .map { "-".repeated($0.maxWidth() + 2) }
            .reduce("+") { $0 + $1 + "+" }
    }
    
    func columns<T>(data: [[T]]) -> [[T]] {
        var result = [[T]]()
        for i in (0..<(data.first?.count ?? 0)) {
            result.append(data.map { $0[i] })
        }
        return result
    }
    
}

extension Array {
    func maxWidth() -> Int {
        guard let maxElement = self.maxElement({ a, b in
            return String(a).characters.count < String(b).characters.count
        }) else { return 0 }
        return String(maxElement).characters.count
    }
}

extension String {
    func padding(padding: Int) -> String {
        let padding = padding + 1 - self.characters.count
        guard padding >= 0 else { return self }
        return " " + self + " ".repeated(padding)
    }
    
    func repeated(count: Int) -> String {
        return Array(count: count, repeatedValue: self).joinWithSeparator("")
    }
}
