//
//  ForgotPasswordViewController.swift
//  mini_projet
//
//  Created by Mac Mini 5 on 21/11/2022.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    
    @IBOutlet weak var EmailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
               view.addGestureRecognizer(tap)
         }
         @objc func dismissKeyboard() {
             view.endEditing(true)
         }
    

    @IBAction func ResetLinkButton(_ sender: UIButton) {
        let EmailText=EmailTextField.text;
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ResetPassword = storyboard.instantiateViewController(identifier: "ResetPassword")
        
        let emailPattern = #"^\S+@\S+\.\S+$"#
        let isEmail = EmailText!.range(of: emailPattern,options: .regularExpression )
        
        if( EmailText!.isEmpty || isEmail == nil )
         {
             //display alert
             displayAlert(UserMessage:"Email address is required");
             return;
             
         }
        
        else{
            sender.isUserInteractionEnabled = false
            let activityIndicator = UIActivityIndicatorView(style: .white)
            activityIndicator.center = CGPoint(x: sender.bounds.size.width / 2, y: sender.bounds.size.height / 2)
            sender.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UserViewModel().getlink(email:EmailText!, onSuccess: {
                activityIndicator.stopAnimating()
                sender.isUserInteractionEnabled = true
                self.navigationController?.pushViewController(ResetPassword, animated: false)
                
                },
                                
                onFailure: {
                (errorMessage) in
                activityIndicator.stopAnimating()
                sender.isUserInteractionEnabled = true
                self.displayAlert(UserMessage:"Email not found");
                    print(errorMessage)
                    
            });
        }
      

    }
    
    func displayAlert(UserMessage:String){
        let myAlert=UIAlertController(title: "Alert", message: UserMessage,preferredStyle: UIAlertController.Style.alert);
        let okAction=UIAlertAction(    title: "Ok", style: UIAlertAction.Style.default,handler: nil);
        
        myAlert.addAction(okAction);
        
        present(myAlert, animated: true,completion: nil);
    }
}
