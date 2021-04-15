//
//  AppDelegate.swift
//  Diss-Hits
//
//  Created by Jesus Caballero on 4/6/21.
//

import UIKit
import Parse
import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    struct userInfo {
        var userId = (String)();                  //for clients-side use only
        var idToken = (String)();                 //Safe to send to server
        var fullName = (String)();
        var givenName = (String)();
        var familyName = (String)();
        var email = (String)();
    }
    
    var loggedInInfo = userInfo();

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            if(error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.");
            } else {
                print("\(error.localizedDescription)");
            }
            return;
        }
        loggedInInfo.userId = user.userID;                  //for clients-side use only
        loggedInInfo.idToken = user.authentication.idToken; //Safe to send to server
        loggedInInfo.fullName = user.profile.name;
        loggedInInfo.givenName = user.profile.givenName;
        loggedInInfo.familyName = user.profile.familyName;
        loggedInInfo.email = user.profile.email;
        // ...
        print("User: \(String(describing: loggedInInfo.fullName))")
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations for when the user signs out of the app here
        print("Signed Out!")
        
        loggedInInfo.userId = String();
        loggedInInfo.idToken = String();
        loggedInInfo.fullName = String();
        loggedInInfo.givenName = String();
        loggedInInfo.familyName = String();
        loggedInInfo.email = String();
    }
    
    func getUserData() -> userInfo {
        return loggedInInfo;
    }
    
    
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let parseConfig = ParseClientConfiguration {
                        $0.applicationId = "uwqBr1CTjRwkLnUy5w1EfMmbHXrlmNGFzgKuClUF" // <- UPDATE
                        $0.clientKey = "jmJtsvTeo7W7Jn10uaj9IsnLU2F4TtgRCOC9Vvx2" // <- UPDATE
                        $0.server = "https://parseapi.back4app.com/"
                }
                Parse.initialize(with: parseConfig)
        
        // Initialize sign-in
        GIDSignIn.sharedInstance().clientID = "184872027484-veuvrg7pn6kqpu3unrvcr7b0h38lh60o.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

