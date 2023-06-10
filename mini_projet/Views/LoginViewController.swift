//
//  LoginViewController.swift
//  mini_projet
//
//  Created by Mac Mini 5 on 16/11/2022.
//

import UIKit
import Foundation
import GoogleSignIn
//import Alamofire
import SendbirdUIKit
import LocalAuthentication

class LoginViewController: UIViewController {


    let signInConfig = GIDConfiguration(clientID: "528986987218-ss2at3mvgmdvqlmq14fp90c8ca133r7a.apps.googleusercontent.com")
    
    //widgets
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var PasswordUILabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PasswordUILabel.sizeToFit()

        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
               view.addGestureRecognizer(tap)
         }
         @objc func dismissKeyboard() {
             view.endEditing(true)
         }

    @IBAction func LoginButton(_ sender: UIButton) {
        sender.isUserInteractionEnabled = false
        let activityIndicator = UIActivityIndicatorView(style: .white)
        activityIndicator.center = CGPoint(x: sender.bounds.size.width / 2, y: sender.bounds.size.height / 2)
        sender.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        let Email=EmailTextField.text!;
        let Password=PasswordTextField.text!;
        
   

        let emailPattern = #"^\S+@\S+\.\S+$"#
        let isEmail = Email.range(of: emailPattern,options: .regularExpression )
        
        if( Email.isEmpty || Password.isEmpty || (isEmail == nil))
        {
            //display alert
            
            displayAlert(UserMessage:"Missing or invalid information");
            return
    
        }
       
            UserViewModel().Login(email:Email, password: Password , onSuccess: {
                activityIndicator.stopAnimating()
                sender.isUserInteractionEnabled = true
                DispatchQueue.main.async {
                    if(UserDefaults.standard.bool(forKey: "verified")){
                        
                        self.performSegue(withIdentifier: "connect", sender: nil)
                    }else{
                        self.performSegue(withIdentifier: "otpResend", sender: nil)
                    }
                    
                }
          

                },
                                
                                onFailure: {
                (errorMessage) in
                self.displayAlert(UserMessage:"Invalid information");
                    print(errorMessage)
                activityIndicator.stopAnimating()
                sender.isUserInteractionEnabled = true
            });
    
        
        
    }
    
    @IBAction func ApplefaceId(_ sender: Any) {
        let context = LAContext()
                       var error: NSError? = nil
                       if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics
                                                    , error: &error) {
                           
                           let reason = "Please authorise with touch id!"
                           context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, error in
                               DispatchQueue.main.async {
                                   guard success , error == nil else {
                                       //failed
                                       let alert = UIAlertController(title: "Failed to Authentificate", message: "Please try again", preferredStyle: .alert)
                                       alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                                       self?.present(alert, animated: true)
                                       return
                                   }
                                   //show other screen success
                                   let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                   let Loading = storyboard.instantiateViewController(withIdentifier: "Home")
                                   self?.navigationController?.pushViewController(Loading, animated: false)
                               }
                           }
                       }
                       else {
                           let alert = UIAlertController(title: "Unavailable", message: "you can use this feature", preferredStyle: .alert)
                           alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                           self.present(alert, animated: true)
                           return
                       }

    }
    
    @IBAction func LoginWithGoogle(_ sender: Any) {
        
        
        
       /* let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let Home = storyboard.instantiateViewController(identifier: "Home")
               GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
                   guard error == nil else { return}
                   guard let user = user else { return }
                   
                   if let profiledata = user.profile {
                       
                     
                       let email : String = profiledata.email
                     UserViewModel().LoginGoogle(email: email, onSuccess: {
                           
                          self.navigationController?.pushViewController(Home, animated: false)
                           
                          },
                                           
                                           onFailure: {
                          (errorMessage) in
                         self.displayAlert(UserMessage:"Invalid information");
                              print(errorMessage)
                               
                      })
                   }
               }*/
 
    }
    
    func displayAlert(UserMessage:String){
        let myAlert=UIAlertController(title: "Alert", message: UserMessage,preferredStyle: UIAlertController.Style.alert);
        let okAction=UIAlertAction(    title: "Ok", style: UIAlertAction.Style.default,handler: nil);
        myAlert.view.tintColor = UIColor.red
        myAlert.addAction(okAction);
        
        present(myAlert, animated: true,completion: nil);
    }
    
    
}

