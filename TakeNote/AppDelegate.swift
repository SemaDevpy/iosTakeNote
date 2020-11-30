//
//  AppDelegate.swift
//  TakeNote
//
//  Created by Syimyk on 11/22/20.
//  Copyright © 2020 Syimyk. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        do{
                _ = try Realm()
            }catch{
                print("Error installing new Realm, \(error)")
            }
        
        return true
    }



}

