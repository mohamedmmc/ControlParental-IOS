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
    }
    

    @IBAction func ContinueButton(_ sender: Any) {
        UserViewModel().resendOTP(id: UserDefaults.standard.string(forKey: "_id")!) {
            print("email envoyé")
            
        } onFailure: { errorMessage in
            print(errorMessage)
        }

    }
    
}
