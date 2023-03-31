//
//  CompleteInscriptionViewController.swift
//  mini_projet
//
//  Created by Mac Mini 5 on 19/11/2022.
//

import UIKit

class CompleteInscriptionViewController: UIViewController {

    @IBOutlet weak var UsernameTextField: UITextField!
    @IBOutlet weak var PhoneTextField: UITextField!
    @IBOutlet weak var Gender: UISegmentedControl!
    @IBOutlet weak var BirthDate: UIDatePicker!
    @IBOutlet weak var Description: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func FinalizeButton(_ sender: UIButton) {
        
        let Username=UsernameTextField.text;
        let Phone=PhoneTextField.text;
        let description=Description.text;
        
    
        if( Username!.isEmpty || Phone!.isEmpty || description!.isEmpty )
        {
            //display alert
            
            displayAlert(UserMessage:"All fields are required");
            return;
    
        }

        
    }
    
    func displayAlert(UserMessage:String){
        var myAlert=UIAlertController(title: "Alert", message: UserMessage,preferredStyle: UIAlertController.Style.alert);
        let okAction=UIAlertAction(    title: "Ok", style: UIAlertAction.Style.default,handler: nil);
    
        myAlert.addAction(okAction);
        
        present(myAlert, animated: true,completion: nil);
    }
    
        
    }
    


