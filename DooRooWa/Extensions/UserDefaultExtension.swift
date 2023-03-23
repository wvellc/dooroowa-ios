//
//  UserDefaultExtension.swift
//
//  Created by Vision on 13/03/23.
//

import UIKit


extension UserDefaults {
    
    static var shared: UserDefaults {
        return UserDefaults.standard
    }
    
    /// User default data key
    enum Keys: String, CaseIterable {
        case user = "user"
        case appFirstLaunch = "appFirstLaunch"
    }
    
    static let arrNonRemovableKeys: [Keys] = [.appFirstLaunch]
    
    //MARK: - Class Functions
    
    /// Remove object
    func removeValue(key:String){
        UserDefaults.shared.removeObject(forKey: key)
    }
    
    /// Function remove all key from userdefaults
    func clearAllUserDefaultData() {
        for Key in Keys.allCases {
            if !UserDefaults.arrNonRemovableKeys.contains(where: { $0 == Key }) {
                UserDefaults.shared.removeObject(forKey: Key.rawValue)
            }
        }
    }
    
    /// Saving custom object in UserDefaults
    func saveCustomObject(_ object: Any, key: Keys) {
        let encodedObject = try? NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: true)
        UserDefaults.shared.set(encodedObject, forKey: key.rawValue)
        UserDefaults.shared.synchronize()
    }
    
    /// Retrive custom object from UserDefaults
    func retriveCustomObject(_ key: Keys) -> Any? {
        if let encodedObject = UserDefaults.shared.object(forKey: key.rawValue) as? Data {
            return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(encodedObject) as Any
        } else {
            return nil
        }
    }
    
    func isAppFirstLaunch() -> Bool {
        if let isAlreadySeenTutorial = UserDefaults.shared.retriveCustomObject(.appFirstLaunch) as? Bool {
            return !isAlreadySeenTutorial
        } else {
            UserDefaults.shared.saveCustomObject(true ,key: .appFirstLaunch)
            return true
        }
    }
}



