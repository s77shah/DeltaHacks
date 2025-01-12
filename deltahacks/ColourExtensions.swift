//
//  ColourExtensions.swift
//  dh2
//
//  Created by Sania Shah on 2025-01-12.
//
import SwiftUI

extension Color {
    static let backgroundGreen = Color(hex: "5B714B") // Original Green
    static let lightGreen = Color(hex: "BFD8B2") // Lighter Green
    static let foregroundWhite = Color(hex: "FFFFFF") // White
    static let lightBrown = Color(hex: "EDDCC7") // Lighter Brown
    static let mediumBrown = Color(hex: "C89E77") // Original Brown

    // Helper initializer for hex colors
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = hex.startIndex
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let red = Double((rgbValue >> 16) & 0xFF) / 255.0
        let green = Double((rgbValue >> 8) & 0xFF) / 255.0
        let blue = Double(rgbValue & 0xFF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}
