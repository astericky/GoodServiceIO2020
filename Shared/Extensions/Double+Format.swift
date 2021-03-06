//
//  Double+format.swift
//  iOS
//
//  Created by Chris Sanders on 6/22/20.
//

extension Double {
    func format(f: Int) -> String {
        return String(format: "%.\(f)f", self)
    }
    
    func convertDecimalToPercentString() -> String {
        "\((self * 100).format(f: 2))%"
    }
}
