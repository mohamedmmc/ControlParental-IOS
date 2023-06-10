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
import SendbirdUIKit
import SendBirdSDK
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
    @IBOutlet weak var Joined: UILabel!
    @IBOutlet weak var UploadImage: UITextField!
    

    @IBAction func logOut(_ sender: UIButton) {
        DispatchQueue.main.async {
              let defaults = UserDefaults.standard
              defaults.removeObject(forKey: "_id")
              defaults.removeObject(forKey: "verified")
              defaults.removeObject(forKey: "email")
              defaults.removeObject(forKey: "FullName")
              defaults.removeObject(forKey: "username")
              defaults.removeObject(forKey: "ProfilePic")
              defaults.removeObject(forKey: "PhoneNumber")
              defaults.removeObject(forKey: "Description")
              defaults.removeObject(forKey: "Gender")
              defaults.removeObject(forKey: "BirthDate")
              defaults.set(false, forKey: "connectedBool")
            defaults.synchronize() // persist the changes to disk

              SBDMain.clearCachedData(completionHandler: nil)
              SBDMain.disconnect(completionHandler: nil)
              
              DispatchQueue.main.async {
                  self.performSegue(withIdentifier: "logoutt", sender: nil)
              }
          }
    
    }
    @IBAction func updateProfil(_ sender: Any) {
        performSegue(withIdentifier: "updateProfil", sender: nil)
    }
    @objc func profileUpdated(){
            if (!(UserDefaults.standard.string(forKey: "ProfilePic") ?? "").isEmpty){
                ProfileImage.imageFromServerURL(urlString: UserDefaults.standard.string(forKey: "ProfilePic")!)
                profileImage2.imageFromServerURL(urlString: UserDefaults.standard.string(forKey: "ProfilePic")!)
            }else{
                ProfileImage.image = UIImage(named: "user")
                profileImage2.image = UIImage(named: "user")
            }
            if (!(UserDefaults.standard.string(forKey: "FullName") ?? "").isEmpty){
                fullName.text = UserDefaults.standard.string(forKey: "FullName")!
            }
        if (!(UserDefaults.standard.string(forKey: "username") ?? "").isEmpty){
            userName.text =  "@ " + (UserDefaults.standard.string(forKey: "username") ?? "Not Proviedd")
        }
        
    }
    override func viewDidLoad() {
      

        super.viewDidLoad()
        let name = Notification.Name("updateProfil")
        NotificationCenter.default.addObserver(self, selector: #selector(profileUpdated), name: name, object: nil)
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
        Joined.text = UserDefaults.standard.string(forKey: "createdAt")!.formattedDateJoined()
        if ((UserDefaults.standard.string(forKey: "ProfilePic") ?? "").isEmpty){
            ProfileImage.image = UIImage(named: "user")
            profileImage2.image = UIImage(named: "user")
        }else{
//            ProfileImage.imageFromServerURL(urlString: UserDefaults.standard.string(forKey: "ProfilePic")!)
//            profileImage2.imageFromServerURL(urlString: UserDefaults.standard.string(forKey: "ProfilePic")!)
            profileImage2.kf.setImage(with: URL(string: UserDefaults.standard.string(forKey: "ProfilePic")!))
            ProfileImage.kf.setImage(with: URL(string: UserDefaults.standard.string(forKey: "ProfilePic")!))
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

