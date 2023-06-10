//
//  SendOTPEmailViewController.swift
//  mini_projet
//
//  Created by Mac Mini 5 on 21/11/2022.
//

import UIKit

class SendOTPEmailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)

        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
               view.addGestureRecognizer(tap)
         }
         @objc func dismissKeyboard() {
             view.endEditing(true)
         }
    
    @IBAction func menuButton(_ sender: Any) {
        performSegue(withIdentifier: "mainMenuSegue", sender: nil)
    }
    
    @IBAction func ContinueButton(_ sender: UIButton) {
        sender.isUserInteractionEnabled = false
        let activityIndicator = UIActivityIndicatorView(style: .white)
        activityIndicator.center = CGPoint(x: sender.bounds.size.width / 2, y: sender.bounds.size.height / 2)
        sender.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UserViewModel().resendOTP(id: UserDefaults.standard.string(forKey: "_id")!) {
            print("email envoyé")
            activityIndicator.stopAnimating()
            sender.isUserInteractionEnabled = true
        } onFailure: { errorMessage in
            activityIndicator.stopAnimating()
            sender.isUserInteractionEnabled = true
            print(errorMessage)
        }

    }
    
}
