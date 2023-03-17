//
//  DateExtension.swift
//
//

import UIKit

extension Date {
   
   //MARK: - Variables
   
   static let YYYY_MM_DD_HH_MM_SS_zzzz = "yyyy-MM-dd HH:mm:ss +zzzz"
   static let YYYY_MM_DD_HH_MM_SS = "yyyy-MM-dd HH:mm:ss"
   static let YYYY_MM_DD = "yyyy-MM-dd"
   static let YYYYMMDD = "yyyy MM dd"
   static let DD_MMMM_YYYY = "dd MMMM, yyyy"
   static let DD_MMM_YYYY_HH_MM_A = "dd MMM yyyy hh:mm a"
   static let DD_MMM_YYYY = "dd MMM yyyy"
   static let HH_MM_SS = "HH:mm:ss"
   static let HH_MM_A = "hh:mm a"
   static let E = "E"

   //MARK:- Date Formate To String
   
   /// Converting date to string
   func toString(format:String = YYYY_MM_DD_HH_MM_SS) -> String {
      let aDateFormatter = DateFormatter()
      aDateFormatter.dateFormat = format
      return aDateFormatter.string(from: self)
   }
   
   /// Date format to string
   func toString(formatFrom:String, formatTo:String) -> String {
      let aDateFormatter = DateFormatter()
      aDateFormatter.dateFormat = formatFrom
      let aStrDate = aDateFormatter.string(from: self)
      aDateFormatter.dateFormat = formatTo
      let aDate = aDateFormatter.date(from: aStrDate) ?? Date()
      return aDateFormatter.string(from: aDate)
   }
   
   /// Date fromate with timezone
   static func convertDateToLocal(strDate:String, oldFormate strOldFormate:String, newFormate strNewFormate:String) -> String{
      let dateFormatterUTC:DateFormatter = DateFormatter()
      dateFormatterUTC.dateFormat = strOldFormate /* Set old format */
      /* Convert date from input string */
      if let oldDate:Date = dateFormatterUTC.date(from: strDate) as Date? {
         dateFormatterUTC.timeZone = NSTimeZone.local
         dateFormatterUTC.dateFormat = strNewFormate /* new date format for output */
         /* Convert dateInUTC into string and set into output */
         if let strNewDate = dateFormatterUTC.string(from: oldDate as Date) as String? {
            return strNewDate
         }
         return strDate
      }
      return strDate
   }
   
   //MARK: - Calendar Functions
   
   /// Returns upcoming day
   func getNextDay() -> Date {
      return Calendar.current.date(byAdding: .day, value: 1, to: self) ?? Date()
   }
   
   /// Returns upcoming year
   func getNextYear() -> Date {
      return Calendar.current.date(byAdding: .year, value: 1, to: self) ?? Date()
   }
   
   /// Returns current year
   func getCurrentYear() -> Int {
      return Calendar.current.component(.year, from: self)
   }
   
   /// Returns current day
   func getCurrentDay() -> Int {
      return Calendar.current.component(.day, from: self)
   }
   
   /// Returns current week day
   func getCurrentWeekDay() -> Int {
      return Calendar.current.component(.weekday, from: self)
   }
   
   /// Returns current month
   func getCurrentMonth() -> Int {
      return Calendar.current.component(.month, from: self)
   }
   /// Returns days count in this month
   func getDaysInMonth() -> Range<Int> {
      return Calendar.current.range(of: .day, in: .month, for: self) ?? 0..<0
   }
   
   /// Time difference in seconds
   static func timeDifference(date:Date) -> Int {
      //convert strDateUTC into date
      let startDate = date
      let endDate =  Date()
      
      //find difference between start and enddate
      let dateSecondsComponents = Calendar.current.dateComponents([Calendar.Component.second], from: startDate, to: endDate)
      return dateSecondsComponents.second ?? 0
   }
   
   /// Convert format time If today or date
   static func convertFormatTimeIfTodayOrDate(from:String) -> String {
      /* Convert string date to into date */
      let aDateFormatter = DateFormatter()
      aDateFormatter.dateFormat = YYYY_MM_DD_HH_MM_SS
      aDateFormatter.timeZone = .current
      let aStartDate = aDateFormatter.date(from: from) ?? Date()
      let aEndDate = aDateFormatter.date(from: Date().toString()) ?? Date()
      
      /* Finding months difference between start and enddate */
      let aDifference = aEndDate.timeIntervalSince(aStartDate)
      let aMonthComponents = Calendar.current.dateComponents([Calendar.Component.month], from: aStartDate, to: aEndDate)
      
      /* Finding difference in minutes, hours, and day */
      let minutes = aDifference / 60
      print(minutes)
      
      let hours = minutes/60
      print(hours)
      
      let day = minutes / 1440
      
      /* Returns formated date or time */
      var aStrResult = ""
      if aMonthComponents.month ?? 0 <= 0 {
         /* If month lessthan 0 or equal 0 */
         if (Int(day) <= 0) {
            /* If day lessthan 0 or equal 0 */
            aStrResult = aStartDate.toString(format: HH_MM_A)
         } else {
            /* Format Date */
            aStrResult = aStartDate.toString(format: DD_MMM_YYYY_HH_MM_A)
         }
      } else {
         /* Format Date */
         aStrResult = aStartDate.toString(format: DD_MMM_YYYY_HH_MM_A)
      }
      print("Formated date output --> \(aStrResult)")
      return aStrResult
   }
}
