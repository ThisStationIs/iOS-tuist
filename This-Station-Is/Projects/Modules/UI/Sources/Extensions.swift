//
//  Extensions.swift
//  UI
//
//  Created by min on 2023/12/28.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit

enum DateFormatType: String {
    // 23.03.09 17:37
    case dateTime = "yy.MM.dd HH:mm"
    case fullDate = "yyyy:mm:dd HH:mm:ss"
}

extension DateFormatter {
    func changeDateFormat(_ date: Date, format: DateFormatType) -> String {
        self.dateFormat = format.rawValue
        self.locale = Locale(identifier: "ko")
        self.timeZone = TimeZone(identifier: "KST")
        
        return self.string(from: date)
    }
    
    func changeStringToDate(_ string: String, format: DateFormatType) -> Date {
        self.dateFormat = format.rawValue
        self.locale = Locale(identifier: "ko")
        self.timeZone = TimeZone(identifier: "KST")
        guard let date = self.date(from: string) else { return Date() }
        
        return date
    }
}

// "2023-12-28T07:49:17.162371695
public func replaceDateFormatter(date: String) -> String {
    
    let changeDate = DateFormatter().changeStringToDate(date, format: .fullDate)
    print(changeDate)
    
    let stringDate = DateFormatter().changeDateFormat(changeDate, format: .dateTime)
    
    return stringDate
}


