//
//  ViewController.swift
//  Promptu
//
//  Created by Andrew Jin on 1/7/17.
//  Copyright © 2017 DailyGummies. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {

    @IBOutlet weak var facebookLoginButton: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        facebookLoginButton.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error!.localizedDescription)
            return
        }
        
        let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            print("User logged in with fb...")
        })
    }
    
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        try! FIRAuth.auth()!.signOut()
        print("User logged out of fb..?")
    }

}

