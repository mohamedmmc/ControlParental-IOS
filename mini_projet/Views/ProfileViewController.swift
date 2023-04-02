//
//  ProfileViewController.swift
//  mini_projet
//
//  Created by Mac Mini 5 on 24/11/2022.
//

import UIKit
import SwiftUI
import Foundation

class ProfileViewController: UIViewController {
    
    @ObservedObject var userViewModel=UserViewModel()
    
    
    @IBOutlet weak var UsernameTextField: UITextField!
    @IBOutlet weak var PhoneTextField: UITextField!
    @IBOutlet weak var Gender: UISegmentedControl!
    @IBOutlet weak var BirthDate: UIDatePicker!
    @IBOutlet weak var DescriptionTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)

        /*let defaults = UserDefaults.standard
        let _id = defaults.object(forKey: "_id") as! String
        userViewModel.GetById(ID:_id )
        
        
        let username = defaults.object(forKey: "username") as! String
        let PhoneNumber = defaults.object(forKey: "PhoneNumber") as! String
        let Gender = defaults.object(forKey: "Gender") as! String
        let BirthDatee = defaults.object(forKey: "BirthDate") as! String
        let Description = defaults.object(forKey: "Description")as! String
    
        
        UsernameTextField.text = username;
        PhoneTextField.text = PhoneNumber;
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd'-'MM'-'yyyy"
        let date = dateFormatter.date(from: BirthDatee)
        BirthDate.date = date!;
        DescriptionTextField.text = Description;*/
        
        
        
        
        
    }
    

    @IBAction func SaveButton(_ sender: UIButton) {
        
        
        let Username=UsernameTextField.text;
        let Phone=PhoneTextField.text;
        let Gender=Gender.titleForSegment(at: Gender.selectedSegmentIndex);
        let BirthDate=BirthDate.date;
        let Description=DescriptionTextField.text;
        
        // Convert Date to String
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let DateString = formatter.string(from: Date())

 
    
        if( Username!.isEmpty || Phone!.isEmpty )
        {
            //display alert
            
            displayAlert(UserMessage:"All fields are required");
            return;
    
        }
        
        else{
            
            let defaults = UserDefaults.standard
            let _id = defaults.string(forKey: "_id") as! String
            print(_id);
            userViewModel.UpdateById(ID: _id, username: Username!, PhoneNumber: Phone!, Gender: Gender!, BirthDate: DateString, Description: Description!,    onSuccess: {
                
                
                // Switch to the new view controller
                DispatchQueue.main.async {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    guard let tabBarController = storyboard.instantiateViewController(withIdentifier: "Home") as? UITabBarController else {
                        return
                    }

                    let viewControllerToSelect = 3
                    tabBarController.selectedIndex = viewControllerToSelect
                    tabBarController.modalPresentationStyle = .fullScreen
                    self.present(tabBarController, animated: true, completion: nil)
                }
            
            
            },
                            
            onFailure: {
            (errorMessage) in
            self.displayAlert(UserMessage:"Something went wrong");
                print(errorMessage)
                
        })
        }

        
    }
    
    
    @IBAction func test(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil) // Remplacez "Main" par le nom de votre Storyboard
        let newViewController = storyboard.instantiateViewController(withIdentifier: "Login") // Remplacez "Login" par l'identifiant de votre nouvelle UIViewController
        newViewController.modalPresentationStyle = .fullScreen
        // Présenter la nouvelle UIViewController
        self.present(newViewController, animated: true, completion: nil)

    }
    func displayAlert(UserMessage:String){
        var myAlert=UIAlertController(title: "Alert", message: UserMessage,preferredStyle: UIAlertController.Style.alert);
        let okAction=UIAlertAction(title: "Ok", style: UIAlertAction.Style.default,handler: nil);
        myAlert.view.tintColor = UIColor.red
        okAction.setValue(UIColor.red, forKey: "titleTextColor")

        myAlert.addAction(okAction);
        
        present(myAlert, animated: true,completion: nil);
    }
    }

