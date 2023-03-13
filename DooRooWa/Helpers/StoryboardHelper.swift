//
//  StoryboardHelper.swift
//  DooRooWa
//
//  Created by Vision on 13/03/23.
//

import UIKit

enum AppStoryboard: String {

    case splash = "Splash"
    case auth = "Auth"
    
    var instance: UIStoryboard {
      return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }

    func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {
        let storyboardId = (viewControllerClass as UIViewController.Type).storyBoardId
        return instance.instantiateViewController(withIdentifier: storyboardId) as! T
    }

    func intialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
}
extension UIViewController {
    
    class var storyBoardId: String{
        return "\(self)"
    }

    static func instatiateFromStoryBoard(appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
}

