//
//  String+Extension.swift
//


import UIKit

extension String{
    
    //MARK:- Format String
    /// Removing whitespace and empty new line (remove space/new line from leading and trailing of text)
    func trim() -> String{
       let strTrimmed = (NSString(string:self)).trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       return strTrimmed
    }
    
   //MARK:- Convert to date
   
   /// Convert to date
   func toDate(format:String) -> Date? {
      let aDateFormatter = DateFormatter()
      aDateFormatter.dateFormat = format
      return aDateFormatter.date(from: self)
   }
   
   /// Convert  date to string with provided format
   func convertStringDateFormat(from:String, to:String) -> String {
      let aDateFormatter = DateFormatter()
      aDateFormatter.dateFormat = from
      let aDate = aDateFormatter.date(from: self) ?? Date()
      aDateFormatter.dateFormat = to
      return aDateFormatter.string(from: aDate)
   }
   
   /// Convert time stemp to string date
   func convertTimeStampToStringDate(format:String) -> String {
      let date = Date(timeIntervalSince1970: Double(self) ?? 0)
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = format
      dateFormatter.timeZone = .current
      return dateFormatter.string(from: date)
   }
   
   /// Convert format time If today or date
   func convertFormatDayIfTodayOrDate(format:String) -> String {
      /* Convert string date to into date */
      let date = Date(timeIntervalSince1970: Double(self) ?? 0)
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = Date.YYYY_MM_DD_HH_MM_SS
      dateFormatter.timeZone = .current
      let from = dateFormatter.string(from: date)
      let aStartDate = dateFormatter.date(from: from) ?? Date()
      
      
      let aDateFormatter = DateFormatter()
      aDateFormatter.dateFormat = Date.YYYY_MM_DD_HH_MM_SS
      aDateFormatter.timeZone = .current
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
         print("day", day)
         print("day int", Int(day))
         /* If month lessthan 0 or equal 0 */
         if (Int(day) == 0) {
            /* If day lessthan 0 or equal 0 */
            aStrResult = "Today"
         } else if (Int(day) == -1) {
            /* If day equal -1 */
            aStrResult = "Tomorrow"
         } else {
            /* Format Date */
            aStrResult = aStartDate.toString(format: format)
         }
      } else {
         /* Format Date */
         aStrResult = aStartDate.toString(format: format)
      }
      print("Formated date output --> \(aStrResult)")
      return aStrResult
   }
   
   //MARK: - Utilities
   
   /// Get height based on text
   func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
      let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
      let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
      return boundingBox.height
   }
   
   /// Get width based on text
   func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
      let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
      let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
      return boundingBox.width
   }
   
   ///Convert string to boolean
   func toBool() -> Bool? {
      let str = self.lowercased()
      switch str {
      case "true", "yes", "1":
         return true
      case "false", "no", "0":
         return false
      default:
         return nil
      }
   }
   
   /// Check text contains or not - remove caseSensivity
   func contains(matchedString:String) -> Bool {
      if((self.range(of: matchedString, options: String.CompareOptions.caseInsensitive, range: nil, locale: nil)) != nil){
         return true
      }else{
         return false
      }
   }
   
   /// Convert string to base64 String
   func encodeFromBase64() -> String? {
      guard let data = Data(base64Encoded: self) else {
         return nil
      }
      return String(data: data, encoding: .utf8)
   }
   
   /// Convert base64 string to string
   func decodeToBase64() -> String {
      return Data(self.utf8).base64EncodedString()
   }
   
   /// Generate random string
   static func randomString(length:Int) -> String {
      let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      let len = UInt32(letters.length)
      
      var randomString = ""
      for _ in 0 ..< length {
         let rand = arc4random_uniform(len)
         var nextChar = letters.character(at: Int(rand))
         randomString += NSString(characters: &nextChar, length: 1) as String
      }
      return randomString
   }
   
   /// String to URL
   func toURL() -> URL? {
      return URL.init(string: self)
   }
   
   func toDouble() -> Double{
      if let num = NumberFormatter().number(from: self) {
         return num.doubleValue
      }
      return 0.0
   }
   
   /// Capitalizing first letter of string
   func capitalizingFirstLetter() -> String {
      let first = String(self.prefix(1)).capitalized
      let other = String(self.dropFirst())
      return first + other
   }
   
   mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
   }
   
   //MARK: - Attributed String
   
   // Returns attributed string with options
   static func setAttributedText(normalText:String, attributeText:String, isUnderLine: Bool = false, color: UIColor, attributedColor: UIColor?, normalFontSize:CGFloat, attributredFontSize:CGFloat, attributredFont:String = AppFonts.ChalkboardSERegular) -> NSAttributedString {
      let commentString = NSMutableAttributedString(string: normalText + (" \(attributeText)"))
      commentString.addAttribute(NSAttributedString.Key.foregroundColor, value:  color, range: NSRange.init(location: 0, length: normalText.count))
      
      if isUnderLine {
         commentString.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: NSRange.init(location: normalText.count + 1, length: attributeText.count ))
      }
      if attributedColor != nil {
         commentString.addAttribute(NSAttributedString.Key.foregroundColor, value: attributedColor! , range: NSRange.init(location: normalText.count, length: attributeText.count + 1))
      } else {
         commentString.addAttribute(NSAttributedString.Key.foregroundColor, value: color , range: NSRange.init(location: 0, length: attributeText.count + 1))
      }
      commentString.addAttribute(NSAttributedString.Key.font, value: UIFont(name: attributredFont, size: attributredFontSize)! , range: NSRange.init(location: normalText.count, length: attributeText.count + 1))
      commentString.addAttribute(NSAttributedString.Key.font, value: UIFont(name: AppFonts.ChalkboardSERegular, size: normalFontSize)! , range: NSRange.init(location: 0, length: normalText.count))
      return commentString
   }
   
   static func setAttributedText(fullText:String, attributeTexts:[String], isUnderLine: Bool = false, color: UIColor, attributedColor: UIColor?, normalFontSize:CGFloat, attributredFontSize:CGFloat, attributredFont:String = AppFonts.ChalkboardSERegular) -> NSAttributedString {
      let commentString = NSMutableAttributedString(string: fullText)
      commentString.addAttribute(NSAttributedString.Key.foregroundColor, value:  color, range: NSRange.init(location: 0, length: fullText.count))
      for strAtt in attributeTexts {
         let range = (fullText as NSString).range(of: strAtt)
         if isUnderLine {
            commentString.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: range)
         }
         if attributedColor != nil {
            commentString.addAttribute(NSAttributedString.Key.foregroundColor, value: attributedColor! , range: range)
         } else {
            commentString.addAttribute(NSAttributedString.Key.foregroundColor, value: color , range: range)
         }
         commentString.addAttribute(NSAttributedString.Key.font, value: UIFont(name: attributredFont, size: attributredFontSize)! , range: range)
         commentString.addAttribute(NSAttributedString.Key.font, value: UIFont(name: AppFonts.ChalkboardSERegular, size: normalFontSize)! , range: range)
      }
      return commentString
   }
}

extension UITapGestureRecognizer {
   
   func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
      // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
      let layoutManager = NSLayoutManager()
      let textContainer = NSTextContainer(size: CGSize.zero)
      let textStorage = NSTextStorage(attributedString: label.attributedText!)
      
      // Configure layoutManager and textStorage
      layoutManager.addTextContainer(textContainer)
      textStorage.addLayoutManager(layoutManager)
      
      // Configure textContainer
      textContainer.lineFragmentPadding = 0.0
      textContainer.lineBreakMode = label.lineBreakMode
      textContainer.maximumNumberOfLines = label.numberOfLines
      let labelSize = label.bounds.size
      textContainer.size = labelSize
      
      // Find the tapped character location and compare it to the specified range
      let locationOfTouchInLabel = self.location(in: label)
      let textBoundingBox = layoutManager.usedRect(for: textContainer)
      let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
                                        y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
      let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x,
                                                   y: locationOfTouchInLabel.y - textContainerOffset.y);
      let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
      return NSLocationInRange(indexOfCharacter, targetRange)
   }
   
}
