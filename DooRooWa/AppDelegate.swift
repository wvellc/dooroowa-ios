//
//  AppDelegate.swift
//  DooRooWa
//
//  Created by Vision on 13/03/23.
//

import UIKit
import IQKeyboardManagerSwift
import Siren

@UIApplicationMain
class AppDelegate: UIResponder {
    
    //MARK: - Variables
    
    var window: UIWindow?
    var strDeviceToken = "abcd"
    
    //MARK: - Class Functions
    
    /// Initial settings when view loads
    fileprivate func doInitialSettings() {
        
        /* KeyBoard Display */
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.toolbarTintColor = ColorsConst.AppBlue
        IQKeyboardManager.shared.toolbarDoneBarButtonItemImage = #imageLiteral(resourceName: "svgClose")
        
        /* Setting app initial screen */ // Setting from splash screen
#if DEBUG
//                navigateToAuthenticationOrDashboardView()
#else
#endif
        //navigateToAuthenticationOrDashboardView()
      
       /* Navigation bar large title offset from left */
       UINavigationBar.appearance().shadowImage = UIImage()
       
        /* Check any new update for force update app */
        checkUpdate()
    }
    
    /// Setting app initial screen on user type and user data saved in UserDefaults
    func navigateToAuthenticationOrDashboardView(_ isShowTransition: Bool = true) {
        var aInitialViewController: UIViewController!
        if let _ = UserDefaults.shared.retriveCustomObject(.user) {
            //         let userModel = try? JSONDecoder().decode(UserModel.self, from: data)
            aInitialViewController = AppStoryboard.home.intialViewController()
        } else {
            aInitialViewController = AppStoryboard.auth.intialViewController()
        }
        //        self.window?.backgroundColor = UIColor.white
        setRoot(vc: aInitialViewController, isShowTransition: isShowTransition)
    }
    
    fileprivate func setRoot(vc: UIViewController, isShowTransition: Bool = true) {
        if let window = self.window {
            if let snapshot = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.screenshot() {
                vc.view.addSubview(snapshot)
                window.makeKeyAndVisible()
                UIView.transition(with: window, duration: isShowTransition ? 0.3 : 0, options: [.curveEaseInOut, .transitionCrossDissolve], animations: {
                    self.window?.rootViewController = vc
                    snapshot.alpha = 0
                }, completion: { isFinish in
                    if isFinish {
                        snapshot.removeFromSuperview()
                    }
                })
            } else {
                UIView.transition(with: window, duration: isShowTransition ? 0.3 : 0, options: [.curveEaseInOut, .transitionCrossDissolve], animations: {
                    window.rootViewController = vc
                })
            }
        }
    }
    
    /// Checking app new update and showing force app update alert
    fileprivate func checkUpdate() {
        let siren = Siren.shared
        siren.presentationManager = PresentationManager(alertTintColor: ColorsConst.AppBlue,
                                                        appName: AppConst.AppName,
                                                        alertTitle: "Please, Update Now!",
                                                        skipButtonTitle: "Click here to skip!",
                                                        forceLanguageLocalization: .english)
        
        siren.rulesManager = RulesManager(globalRules: .critical)
        siren.wail { results in
            switch results {
            case .success(let updateResults):
                print("AlertAction ", updateResults.alertAction)
                print("Localization ", updateResults.localization)
                print("Model ", updateResults.model)
                print("UpdateType ", updateResults.updateType)
            case .failure(let error):
                print("Error in Siren",error.localizedDescription)
            }
        }
    }
}
extension AppDelegate: UIApplicationDelegate {
    //MARK: - UIApplicationDelegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        doInitialSettings()
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        /* Setting notification badge count to zero when the app becomes active */
        application.applicationIconBadgeNumber = 0
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}
extension UIView {
    fileprivate func screenshot() -> UIView {
        let img = UIGraphicsImageRenderer(size: bounds.size).image { _ in
            drawHierarchy(in: CGRect(origin: .zero, size: bounds.size), afterScreenUpdates: true)
        }
        let view = UIImageView(frame: CGRect(origin: .zero, size: bounds.size))
        view.image = img
        return view
    }
}
