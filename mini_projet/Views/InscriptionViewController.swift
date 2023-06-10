//
//  InscriptionViewController.swift
//  mini_projet
//
//  Created by Mac Mini 5 on 16/11/2022.
//

import UIKit

class InscriptionViewController: UIViewController {

    //widgets
    @IBOutlet weak var FullNameTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var RepeatPasswordTextField: UITextField!
    
    
    //UserViewModel().Login
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
               view.addGestureRecognizer(tap)
         }
         @objc func dismissKeyboard() {
             view.endEditing(true)
         }
    
    //Actions
   @IBAction func ContinueButton(_ sender: UIButton) {
        
        let FullName=FullNameTextField.text;
        let EmailText=EmailTextField.text;
        let Password=PasswordTextField.text;
        let RepeatPassword=RepeatPasswordTextField.text;
       
       let storyboard = UIStoryboard(name: "Main", bundle: nil)
       let EmailOTP = storyboard.instantiateViewController(identifier: "EmailOTP")
       
       let emailPattern = #"^\S+@\S+\.\S+$"#
       let isEmail = EmailText!.range(of: emailPattern,options: .regularExpression )
       
       
        //validation des champs
        
       if( FullName!.isEmpty || EmailText!.isEmpty || Password!.isEmpty || RepeatPassword!.isEmpty )
        {
            //display alert
            
            displayAlert(UserMessage:"All fields are required");
            return;
            
        }
       if( isEmail == nil )
        {
            //display alert
            
            displayAlert(UserMessage:"Email not valid");
            return;
            
        }
        
        //password matching
        if(Password != RepeatPassword)
        {
            displayAlert(UserMessage:"Password and confirm password should match");
            return;
            
        }
       
       sender.isUserInteractionEnabled = false
       let activityIndicator = UIActivityIndicatorView(style: .white)
       activityIndicator.center = CGPoint(x: sender.bounds.size.width / 2, y: sender.bounds.size.height / 2)
       sender.addSubview(activityIndicator)
       activityIndicator.startAnimating()
        
       UserViewModel().register(email:EmailText!, mdp:Password!, FullName: FullName!, confrimMdp: RepeatPassword!,
            onSuccess: {
           activityIndicator.stopAnimating()
           sender.isUserInteractionEnabled = true
           SendBirdApi().SendBirdCreateAccount(user_id: UserDefaults.standard.string(forKey: "_id")!, nickname: UserDefaults.standard.string(forKey: "FullName")!, profile_url:"")
           
           self.navigationController?.pushViewController(EmailOTP, animated: false)
           
           },
                           
            onFailure: {
          
           (errorMessage) in
           activityIndicator.stopAnimating()
           sender.isUserInteractionEnabled = true
           self.displayAlert(UserMessage:"User already exist");
               print(errorMessage)
               
       });
        
        
     
       
     
    }
    
    
    
    func displayAlert(UserMessage:String){
        var myAlert=UIAlertController(title: "Alert", message: UserMessage,preferredStyle: UIAlertController.Style.alert);
        let okAction=UIAlertAction(	title: "Ok", style: UIAlertAction.Style.default,handler: nil);
        myAlert.view.tintColor = UIColor.red
        myAlert.addAction(okAction);
        
        present(myAlert, animated: true,completion: nil);
    }
}
