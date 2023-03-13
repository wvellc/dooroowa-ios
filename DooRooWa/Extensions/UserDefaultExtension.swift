//
//  UserDefaultExtension.swift
//
//  Created by Vision on 13/03/23.
//

import UIKit

let USERDEFAULTS = UserDefaults.standard

extension UserDefaults {
   
   /// User default data key
   enum Keys: String, CaseIterable {
      case user   = "user"
   }
   
   /// Remove object
   func removeValue(key:String){
      USERDEFAULTS.removeObject(forKey: key)
   }
   
   /// Function remove all key from userdefaults
   func clearAllUserDefaultData() {
      for Key in Keys.allCases {
         USERDEFAULTS.removeObject(forKey: Key.rawValue)
      }
   }
   
   /// Saving custom object in UserDefaults
   func saveCustomObject(_ object: Any, key: Keys) {
      let encodedObject = try? NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: true)
      UserDefaults.standard.set(encodedObject, forKey: key.rawValue)
      UserDefaults.standard.synchronize()
   }
   
   /// Retrive custom object from UserDefaults
   func retriveCustomObject(_ key: Keys) -> Any? {
      if let encodedObject = UserDefaults.standard.object(forKey: key.rawValue) as? Data {
         return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(encodedObject) as Any
      } else {
         return nil
      }
   }
}



