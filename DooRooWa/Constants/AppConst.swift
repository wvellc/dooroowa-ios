//
//  AppConstant.swift
//  DooRooWa
//
//  Created by Vision on 13/03/23.
//

import UIKit

class AppConst: NSObject {
   /* Common */
   static let AppName                      = "DooRooWa"
   
   static let APPDELEGATE                  = UIApplication.shared.delegate as! AppDelegate
   
   static let ScreenWidth                  = UIScreen.main.bounds.width
   static let ScreenHeight                 = UIScreen.main.bounds.height
   
   static let AppSite                      = "https://wvelabs.com/solutions/"

}

//MARK: - Structs

/* Fonts */
struct AppFonts {
  static let ChalkboardSERegular            = "ChalkboardSE-Regular"
  static let ChalkboardSELight              = "ChalkboardSE-Light"
  static let ChalkboardSEBold               = "ChalkboardSE-Bold"
}
