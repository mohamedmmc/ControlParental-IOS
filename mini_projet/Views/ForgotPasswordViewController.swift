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
            UserViewModel().getlink(email:EmailText!, onSuccess: {
            
                self.navigationController?.pushViewController(ResetPassword, animated: false)
                
                },
                                
                onFailure: {
                (errorMessage) in
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
