//
//  FormatterHelper.swift
//  Gazetteer
//
//  Created by Seymour Rodrigues on 19/05/2023.
//

import Foundation

struct FormatterHelper {
    
    /* Static Method to format the numbers to make it more readable */
    static func formattedNumberString(_ number: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        guard let formattedString = numberFormatter.string(from: NSNumber(value: number)) else {
            return String(number)
        }
        return formattedString
    }
    
    /* Static Method to format the time into string from timestamp to make it readable */
    static func formattedTimeString(_ timestamp: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        return dateFormatter.string(from: date)
    }
    
    /* Static Method to format the date into string from timestamp to make it readable */
    static func formattedDateString(_ timestamp: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        return dateFormatter.string(from: date)
    }
    
}
