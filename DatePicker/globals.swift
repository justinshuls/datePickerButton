//
//  globals.swift
//  DatePicker
//
//  Created by Justin Shulman on 11/20/16.
//  Copyright © 2016 JLS. All rights reserved.
//

import Foundation

func dateFromString(dateString: String) -> NSDate {
    var dateString = dateString
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss zzz"
    
    //temp bug fix REMOVE
    if dateFormatter.date(from: dateString) == nil {
        dateString = "1970-01-01 00:00:00 EDT"
    }
    
    let convertedDate = dateFormatter.date(from: dateString)
    
    return convertedDate! as NSDate
}

func stringFromDate(date: NSDate) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss zzz"
    return dateFormatter.string(from: date as Date)
}

func dateFormat(date: NSDate, dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = dateStyle
    dateFormatter.timeStyle = timeStyle
    return dateFormatter.string(from: date as Date)
}
