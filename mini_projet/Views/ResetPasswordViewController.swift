//
//  ResetPasswordViewController.swift
//  mini_projet
//
//  Created by Mac Mini 5 on 21/11/2022.
//

import UIKit

class ResetPasswordViewController: UIViewController {

    
    @IBOutlet weak var NewPasswordTextField: UITextField!
    @IBOutlet weak var ConfirmPasswordTextField: UITextField!
    
    
    @IBOutlet weak var OTPTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    @IBAction func ResetPasswordButton(_ sender: Any) {
        
        let NewPassword=NewPasswordTextField.text;
        let ConfirmPassword=ConfirmPasswordTextField.text;
        let OTP=OTPTextField.text;
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let Login = storyboard.instantiateViewController(identifier: "Login")
        
        
        if( NewPassword!.isEmpty || ConfirmPassword!.isEmpty || OTP!.isEmpty)
         {
             //display alert
             
             displayAlert(UserMessage:"All fields are required");
             return;
             
         }
         
         //password matching
         if(NewPassword != ConfirmPassword)
         {
             displayAlert(UserMessage:"Passwords should match");
             return;
             
         }
        
        let defaults = UserDefaults.standard
        let em = defaults.object(forKey: "userEmail")
        print(em!)
        UserViewModel().resetPassword(email:em as! String ,mdp:NewPassword!, otpReset: OTP!,
            onSuccess: {
            
            self.navigationController?.pushViewController(Login, animated: false)
            
            },
                            
            onFailure: {
            (errorMessage) in
            self.displayAlert(UserMessage:"Invalid OTP");
                print(errorMessage)
                
        })
        
    }
    
    func displayAlert(UserMessage:String){
        var myAlert=UIAlertController(title: "Alert", message: UserMessage,preferredStyle: UIAlertController.Style.alert);
        let okAction=UIAlertAction(    title: "Ok", style: UIAlertAction.Style.default,handler: nil);
        myAlert.view.tintColor = UIColor.red
        
        myAlert.addAction(okAction);
        
        present(myAlert, animated: true,completion: nil);
    }

}
