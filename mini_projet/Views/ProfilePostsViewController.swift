//
//  ProfilePostsViewController.swift
//  mini_projet
//
//  Created by Mac Mini 5 on 5/12/2022.
//

import UIKit
import SwiftUI
import Foundation
import Lottie

class ProfilePostsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @ObservedObject var postViewModel = PostViewModel()
    
    @IBOutlet weak var profileImage2: UIImageView!
    @IBOutlet weak var fullName2: UILabel!
    @IBOutlet weak var postCount: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var PostsTable: UITableView!
    @IBOutlet weak var ViewPopUp: UIView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var PostImage: UIImageView!
    @IBOutlet weak var Upload: UIButton!
    @IBOutlet weak var animationView: LottieAnimationView!
    @IBOutlet weak var UploadImage: UITextField!
    

    @IBAction func logOut(_ sender: UIButton) {
        DispatchQueue.main.async {
            UserDefaults.standard.removeObject(forKey: "_id")
            UserDefaults.standard.removeObject(forKey: "email")
            UserDefaults.standard.removeObject(forKey: "username")
            UserDefaults.standard.removeObject(forKey: "ProfilePic")
            UserDefaults.standard.removeObject(forKey: "FullName")
            UserDefaults.standard.removeObject(forKey: "PhoneNumber")
            UserDefaults.standard.removeObject(forKey: "Description")
            UserDefaults.standard.removeObject(forKey: "Gender")
            UserDefaults.standard.removeObject(forKey: "BirthDate")
            self.performSegue(withIdentifier: "logoutt", sender: nil)
        }
    
    }
    @IBAction func updateProfil(_ sender: Any) {
        performSegue(withIdentifier: "updateProfil", sender: nil)
    }
    override func viewDidLoad() {
        if let defaults = UserDefaults.standard.dictionaryRepresentation() as? [String:Any] {
            for (key, value) in defaults {
                print("\(key) = \(value)")
            }
        }

        super.viewDidLoad()
        
        //Pop up View
        ViewPopUp.layer.cornerRadius = 20
        ViewPopUp.isHidden = true
        // Hide the back button
           navigationItem.hidesBackButton = true
        Upload.setTitle("", for: .normal)
        PostsTable.dataSource = self
        PostsTable.delegate = self
            
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.5
        animationView.isHidden = true
        animationView.play()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.postViewModel.UserPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let contentView = cell?.contentView
        let title = contentView?.viewWithTag(1) as! UILabel
        let description = contentView?.viewWithTag(2) as! UILabel
        let imageView = contentView?.viewWithTag(3) as! UIImageView
        
        let post = self.postViewModel.UserPosts[indexPath.row]
        
        title.text = post.title
        description.text = post.description
        if (post.image == "no image"){
            imageView.image = UIImage(named: "user")
        } else{
            imageView.imageFromServerURL(urlString: post.image!)
        }
        return cell!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.postViewModel.UserPosts = self.postViewModel.GetPost()
        self.postCount.text = String(self.postViewModel.UserPosts.count )
        fullName.text = UserDefaults.standard.string(forKey: "FullName") ?? "Not Provided"
        fullName2.text = UserDefaults.standard.string(forKey: "FullName")  ?? "Not Provided"
        userName.text = "@ " + (UserDefaults.standard.string(forKey: "username") ?? "Not Proviedd")
        if ((UserDefaults.standard.string(forKey: "ProfilePic") ?? "").isEmpty){
            ProfileImage.image = UIImage(named: "user")
            profileImage2.image = UIImage(named: "user")
        }else{
            ProfileImage.imageFromServerURL(urlString: UserDefaults.standard.string(forKey: "ProfilePic")!)
            profileImage2.imageFromServerURL(urlString: UserDefaults.standard.string(forKey: "ProfilePic")!)
        }
        if(self.postViewModel.UserPosts.isEmpty){
            self.PostsTable.isHidden = true
            self.animationView.isHidden = false
        }else{
            self.PostsTable.isHidden = false
            self.animationView.isHidden = true
        }
        self.PostsTable.reloadData()
    }
    
    

    func displayAlert(UserMessage:String){
        var myAlert=UIAlertController(title: "Alert", message: UserMessage,preferredStyle: UIAlertController.Style.alert);
        let okAction=UIAlertAction(    title: "Ok", style: UIAlertAction.Style.default,handler: nil);
        myAlert.addAction(okAction);
        
        present(myAlert, animated: true,completion: nil);
    }
    
    

    @IBAction func AddUIButton(_ sender: Any) {
        ViewPopUp.isHidden = false
    }
    
    
    
    
}

