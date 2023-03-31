//
//  ProfileFeedViewController.swift
//  mini_projet
//
//  Created by Mac Mini 5 on 5/12/2022.
//

import UIKit

class ProfileFeedViewController: UITabBarController {

        
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*ViewPopUp.layer.cornerRadius = 24
        ViewPopUp.isHidden = true*/
    }
    

    @IBAction func SaveButton(_ sender: Any)
    {
        
        /*let titre=TitletextField.text;
        let Description=DescriptionTextField.text;
    
        //validation des champs
        
       if( titre!.isEmpty)
        {
            //display alert
            
            displayAlert(UserMessage:"All fields are required");
            return;
            
        }
        
        PostViewModel().AddPost(title: titre!, description: Description!,
             onSuccess: {
            
            print("post added with success")
            
            },
                            
             onFailure: {
            
            (errorMessage) in
            self.displayAlert(UserMessage:"Failed to add Post");
                print(errorMessage)
                
        });*/
    
    }
    
    func displayAlert(UserMessage:String){
        var myAlert=UIAlertController(title: "Alert", message: UserMessage,preferredStyle: UIAlertController.Style.alert);
        let okAction=UIAlertAction(    title: "Ok", style: UIAlertAction.Style.default,handler: nil);
        myAlert.view.tintColor = UIColor.red
        myAlert.addAction(okAction);
        
        present(myAlert, animated: true,completion: nil);
    }
    
    

    @IBAction func AddButton(_ sender: Any) {
        //ViewPopUp.isHidden = false
    }
    
    
 
    @IBAction func ExitButton(_ sender: Any) {
       //ViewPopUp.isHidden = true
    }
    
}
