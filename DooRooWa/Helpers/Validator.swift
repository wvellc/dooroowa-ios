//
//  Validator.swift
//  DooRooWa
//
//  Created by Vision on 15/03/23.
//

import Foundation

class Validator {
    
    //MARK: - Validations
    
    //MARK:- Format String
    static func isDigits(_ value: String) -> Bool {
        guard value.isEmpty else { return false }
        return value.contains { Int(String($0)) == nil }
    }
    
    /// Format with two digits
    static func formatWithTwoDigits(value:Double) -> String {
        return String(format: "%.2f",value)
    }
    
    /// Email Validation
    static func isEmailAddress(_ value: String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: value)
    }
    
    ///Password Validation
    static func isPassword(_ value: String) -> Bool {
        return value.count >= 6
    }
    
    static func isValidNumber(_ value: String) -> Bool{
        let PHONE_REGEX = "^((\\+)|(00))[0-9]{10,15}$"//"^\\d{10,15}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
    ///Phone Number Validation
    static func isPhoneNumber(_ value: String) -> Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: value, options: [], range: NSMakeRange(0, value.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == value.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    
    /// String contains numbers or not
    static func isNumeric(_ value: String) -> Bool{
        let numberRegEx  = ".*[0-9]+.*"
        let testCase = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        return testCase.evaluate(with: self)
    }
    
    /// Check alphanumric value or not
    static func isAlphaNumeric(_ value: String) -> Bool {
        return value.isEmpty && value.range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    /// Check special character value or not
    static func isSpecialCharacter(_ value: String) -> Bool {
        let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
        if value.rangeOfCharacter(from: characterset.inverted) != nil {
            return true
        }
        return false
    }
    
    /// String contains numbers or not
    static func isValidAmount(_ value: String) -> Bool {
        let aSet = NSCharacterSet(charactersIn:"0123456789.").inverted
        let compSepByCharInSet = value.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return (value == numberFiltered)
    }
    
    /// String contains numbers or not
    static func isValidNumberText(_ value: String) -> Bool {
        let aSet = NSCharacterSet(charactersIn:"0123456789+").inverted
        let compSepByCharInSet = value.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return (value == numberFiltered)
    }
}
