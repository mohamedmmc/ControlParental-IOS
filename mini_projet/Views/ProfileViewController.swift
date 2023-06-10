//
//  ProfileViewController.swift
//  mini_projet
//
//  Created by Mac Mini 5 on 24/11/2022.
//

import UIKit
import SwiftUI
import Foundation
import Kingfisher
class ProfileViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @ObservedObject var userViewModel=UserViewModel()
    
    
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var UsernameTextField: UITextField!
    @IBOutlet weak var PhoneTextField: UITextField!
    @IBOutlet weak var Gender: UISegmentedControl!
    @IBOutlet weak var BirthDate: UIDatePicker!
    @IBOutlet weak var DescriptionTextField: UITextField!
    let dateFormatter = DateFormatter()
    var picker_image: UIImage?
    @IBAction func pick(_ sender: Any) {
        let myPickerControllerGallery = UIImagePickerController()
                      myPickerControllerGallery.delegate = self
                      myPickerControllerGallery.sourceType = UIImagePickerController.SourceType.photoLibrary
                      myPickerControllerGallery.allowsEditing = true
                      self.present(myPickerControllerGallery, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let editedimage = info[.editedImage] as? UIImage else  {
                return
            }
            picker_image = editedimage
                  imageview.image = editedimage
                  
            self.dismiss(animated: true, completion: nil)
        }
    
    override func viewDidLoad() {
        dateFormatter.dateFormat = "dd-MM-yyyy"
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        if !((UserDefaults.standard.string(forKey: "username") ?? "").isEmpty) {
            UsernameTextField.text = UserDefaults.standard.string(forKey: "username")
        }
        if !((UserDefaults.standard.string(forKey: "PhoneNumber") ?? "").isEmpty) {
            PhoneTextField.text = UserDefaults.standard.string(forKey: "PhoneNumber")
        }
        if !((UserDefaults.standard.string(forKey: "Description") ?? "").isEmpty) {
            DescriptionTextField.text = UserDefaults.standard.string(forKey: "Description")
        }
        if !((UserDefaults.standard.string(forKey: "Gender") ?? "").isEmpty) {
            if (UserDefaults.standard.string(forKey: "Gender") == "Male"){
                Gender.selectedSegmentIndex = 0
            } else {
                Gender.selectedSegmentIndex = 1
            }
        }
        if ((UserDefaults.standard.string(forKey: "ProfilePic") ?? "").isEmpty){
            imageview.image = UIImage(named: "user")
        }else{
            imageview.imageFromServerURL(urlString: UserDefaults.standard.string(forKey: "ProfilePic")!)
        }
        if !((UserDefaults.standard.string(forKey: "BirthDate") ?? "").isEmpty) {
            if let birthDate = dateFormatter.date(from: UserDefaults.standard.string(forKey: "BirthDate")! ) {
                // Set the date picker's date to the birthDate
                BirthDate.date = birthDate
            }
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
               view.addGestureRecognizer(tap)
         }
         @objc func dismissKeyboard() {
             view.endEditing(true)
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
            sender.isUserInteractionEnabled = false
            let activityIndicator = UIActivityIndicatorView(style: .white)
            activityIndicator.center = CGPoint(x: sender.bounds.size.width / 2, y: sender.bounds.size.height / 2)
            sender.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            let defaults = UserDefaults.standard
            let _id = defaults.string(forKey: "_id")
            userViewModel.UpdateById(ID: _id!, username: Username!, PhoneNumber: Phone!, Gender: Gender!, BirthDate: DateString, Description: Description!, photo: picker_image,    onSuccess: {
                
                
                // Switch to the new view controller
                DispatchQueue.main.async {
                    
                    SendBirdApi().SendBirdUpdateProfil(user_id: _id!, nickname: Username!, profile_url: UserDefaults.standard.string(forKey: "ProfilePic") ?? "")
                    DispatchQueue.main.async {
                        let name = Notification.Name("updateProfil")
                        let notification = Notification(name: name)
                        NotificationCenter.default.post(notification)
                                 activityIndicator.stopAnimating()
                                 sender.isUserInteractionEnabled = true
                        if !(UserDefaults.standard.bool(forKey: "connectedBool")){
                            self.performSegue(withIdentifier: "homeSegue", sender: nil)
                        }else{
                            self.dismiss(animated: true)
                        }
                    }
                }
            
            
            },
                            
            onFailure: {
            (errorMessage) in
            self.displayAlert(UserMessage:"Something went wrong");
                print(errorMessage)
                // Stop the activity indicator and enable the button
                         activityIndicator.stopAnimating()
                         sender.isUserInteractionEnabled = true
                
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

