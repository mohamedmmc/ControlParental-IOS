//
//  EmailVerificationOTPViewController.swift
//  mini_projet
//
//  Created by Mac Mini 5 on 21/11/2022.
//

import UIKit
import SwiftUI
import Foundation

class EmailVerificationOTPViewController: UIViewController {
    
    @IBOutlet weak var OTPtextField: UITextField!
    @ObservedObject var userViewModel=UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    


    
    
    @IBAction func ConfirmButton(_ sender: Any) {
        
        let OTP=OTPtextField.text;
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let Profile = storyboard.instantiateViewController(identifier: "Profile")
        
        if( OTP!.isEmpty)
         {
             //display alert
             
             displayAlert(UserMessage:"An OTP code is required");
             return;
            
         }
        
        let defaults = UserDefaults.standard
        let em = defaults.object(forKey: "userEmail")
        print(em)
        UserViewModel().verifyEmail(email:em as! String , otp: OTP!,
            onSuccess: {
            
            self.navigationController?.pushViewController(Profile, animated: false)
            
            },
                            
            onFailure: {
            (errorMessage) in
            self.displayAlert(UserMessage:"Invalid OTP");
                print(errorMessage)
                
        })
        
        
    }
    
    func displayAlert(UserMessage:String){
        var myAlert=UIAlertController(title: "Alert", message: UserMessage,preferredStyle: UIAlertController.Style.alert);
        let okAction=UIAlertAction(title: "Ok", style: UIAlertAction.Style.default,handler: nil);
        myAlert.view.tintColor = UIColor.red
        
        myAlert.addAction(okAction);
        
        present(myAlert, animated: true,completion: nil);
    }

}

