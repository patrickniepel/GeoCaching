//
//  AppDelegate.swift
//  GeoCaching
//
//  Created by Patrick Niepel on 18.04.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit
import Firebase
import GoogleMaps
import GooglePlaces
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        GMSServices.provideAPIKey("AIzaSyAvtNY_CoMXKjIYQN975jUszLAeEkx2gPc")
        GMSPlacesClient.provideAPIKey("AIzaSyAvtNY_CoMXKjIYQN975jUszLAeEkx2gPc")
        
        FirebaseApp.configure()
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        let random = arc4random_uniform(10)
        let luckyNumber = 7
        if random == luckyNumber {
            fatalError()
        }
        
        
        // Statusbar white
        UIApplication.shared.statusBarStyle = .lightContent
        
//        let loginStoryboard = UIStoryboard(name: "Login", bundle: nil)
//        let loginViewCtrl = loginStoryboard.instantiateViewController(withIdentifier: "storyboardID_login_vc") as! LoginViewController
//        let navigationCtrl = UINavigationController(rootViewController: loginViewCtrl)
//        navigationCtrl.navigationBar.tintColor = AppColor.tint
//        navigationCtrl.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
//        navigationCtrl.navigationBar.barTintColor = .black
//        navigationCtrl.navigationBar.isTranslucent = false
        
        
        let rootCtrl = createAppTabBarController()
        window?.rootViewController = rootCtrl
        

        let loginViewCtrl = goToLogin()
        
        rootCtrl.present(loginViewCtrl, animated: false, completion: nil)
        
        let source = CLLocationCoordinate2D(latitude: 50.171311, longitude: 12.1339323)
        let dest = CLLocationCoordinate2D(latitude: 51.3396955, longitude: 12.3730747)
        let dest2 = CLLocationCoordinate2D(latitude: 53.3396955, longitude: 12.3730747)
        
        RouteController().calculateEntireRoute(with: [source, dest, dest2], transportType: .any) { (distance, travelTime) in
             print("Distance: \(distance), Time: \(travelTime)")
        }
        
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
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}


// MARK: - Navigation

extension AppDelegate {
    func createAppTabBarController() -> UITabBarController {
        let uiTabBarVC = UITabBarController()
        
        let searchStoryboard = UIStoryboard(name: "Search", bundle: nil)
        let searchVC = searchStoryboard.instantiateViewController(withIdentifier: "storyboardID_search_vc") as! SearchViewController
        searchVC.title = "Search"
        
        let gameStoryboard = UIStoryboard(name: "Game", bundle: nil)
        let currentGameVC = gameStoryboard.instantiateViewController(withIdentifier: "storyboardID_game_vc") as! GameViewController
        currentGameVC.title = "Game"
        
        let createStoryboard = UIStoryboard(name: "Create", bundle: nil)
        let createGameVC = createStoryboard.instantiateViewController(withIdentifier: "storyboardID_create_vc") as! CreateGameViewController
        createGameVC.title = "Create"
        
        let highscoreStoryboard = UIStoryboard(name: "Highscore", bundle: nil)
        let highscoreVC = highscoreStoryboard.instantiateViewController(withIdentifier: "storyboardID_highscore_vc") as! HighscoreViewController
        highscoreVC.title = "Highscore"
        
        let profileStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        let profileVC = profileStoryboard.instantiateViewController(withIdentifier: "storyboardID_profile_vc") as! ProfileViewController
        profileVC.title = "Profile"
        
        var itemViewControllers = [searchVC, currentGameVC, createGameVC, highscoreVC, profileVC]
        
        for index in 0..<itemViewControllers.count {
            let viewCtrl = itemViewControllers[index]
            let navCtrl = UINavigationController(rootViewController: viewCtrl)
            navCtrl.navigationBar.barTintColor = AppColor.navigationBar
            navCtrl.navigationBar.tintColor = AppColor.text
            navCtrl.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
            itemViewControllers[index] = navCtrl
        }
        
        uiTabBarVC.viewControllers = itemViewControllers
        uiTabBarVC.tabBar.tintColor = AppColor.tint
        uiTabBarVC.tabBar.barTintColor = AppColor.background
        
        itemViewControllers.forEach { (item) in
            item.view.backgroundColor = .white
        }
        
        for index in 0..<itemViewControllers.count {
            let viewCtrl = itemViewControllers[index]
            if let tabBarItem = uiTabBarVC.tabBar.items?[index] {
                let lowercasedTitle = viewCtrl.title?.lowercased() ?? ""
                let iconName = "icon_\(lowercasedTitle)"
                tabBarItem.image = UIImage(named: iconName)
            }
        }
        
        return uiTabBarVC
    }

    func goToLogin() -> LoginViewController {
        let loginStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let loginViewCtrl = loginStoryboard.instantiateViewController(withIdentifier: "storyboardID_login_vc") as! LoginViewController
        
        return loginViewCtrl
    }
}

