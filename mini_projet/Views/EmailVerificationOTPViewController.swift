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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
               view.addGestureRecognizer(tap)
         }
         @objc func dismissKeyboard() {
             view.endEditing(true)
         }
    


    
    
    @IBAction func ConfirmButton(_ sender: UIButton) {
       
        let OTP=OTPtextField.text;

        // Get a reference to the storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        // Get a reference to the view controller you want to switch to
        guard let Profile = storyboard.instantiateViewController(withIdentifier: "Profile") as? ProfileViewController else {
            return
        }
        if( OTP!.isEmpty)
         {
             //display alert
             
             displayAlert(UserMessage:"An OTP code is required");
             return;
            
         }
        
        let defaults = UserDefaults.standard
        let em = defaults.string(forKey: "email")
        sender.isUserInteractionEnabled = false
        let activityIndicator = UIActivityIndicatorView(style: .white)
        activityIndicator.center = CGPoint(x: sender.bounds.size.width / 2, y: sender.bounds.size.height / 2)
        sender.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UserViewModel().verifyEmail(email:em! , otp: OTP!,
            onSuccess: {

            activityIndicator.stopAnimating()
            sender.isUserInteractionEnabled = true
                // Switch to the new view controller
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "continue", sender: nil)
                    //self.navigationController?.pushViewController(Profile, animated: true)
                }
            
            
            },
                            
            onFailure: {
            (errorMessage) in
            activityIndicator.stopAnimating()
            sender.isUserInteractionEnabled = true
            self.displayAlert(UserMessage:"Invalid OTP");
                
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

