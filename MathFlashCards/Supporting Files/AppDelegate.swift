//
//  AppDelegate.swift
//  MathFlashCards
//
//  Created by Robert Ramirez on 11/13/18.
//  Copyright © 2018 Robert Ramirez. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)

    let cardDeckSelectorVC = CardDeckSelectorViewController()
    let cardNC = UINavigationController()
    let appearance = UINavigationBarAppearance()
    appearance.shadowColor = .clear
    if let deckFont = deckFont {
      appearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: deckFont.withSize(25)]
    }
    appearance.backgroundColor = UIColor.darkModeBackgroundColor
    UINavigationBar.appearance().standardAppearance = appearance
    cardNC.addChild(cardDeckSelectorVC)
    window?.rootViewController = cardNC
    window?.makeKeyAndVisible()

    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {}

  func applicationDidEnterBackground(_ application: UIApplication) {}

  func applicationWillEnterForeground(_ application: UIApplication) {}

  func applicationDidBecomeActive(_ application: UIApplication) {}

  func applicationWillTerminate(_ application: UIApplication) {}
}
