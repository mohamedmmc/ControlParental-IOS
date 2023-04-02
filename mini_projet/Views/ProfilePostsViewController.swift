//
//  ProfilePostsViewController.swift
//  mini_projet
//
//  Created by Mac Mini 5 on 5/12/2022.
//

import UIKit
import SwiftUI
import Foundation

class ProfilePostsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @ObservedObject var postViewModel = PostViewModel()
    
    @IBOutlet weak var profileImage2: UIImageView!
    @IBOutlet weak var fullName2: UILabel!
    @IBOutlet weak var followersCount: UILabel!
    @IBOutlet weak var followingcount: UILabel!
    @IBOutlet weak var postCount: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var PostsTable: UITableView!
    @IBOutlet weak var ViewPopUp: UIView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var PostImage: UIImageView!
    @IBOutlet weak var Upload: UIButton!
    @IBOutlet weak var UploadImage: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 
        //Pop up View
        ViewPopUp.layer.cornerRadius = 20
        ViewPopUp.isHidden = true
        // Hide the back button
           navigationItem.hidesBackButton = true
        Upload.setTitle("", for: .normal)
        PostsTable.dataSource = self
        PostsTable.delegate = self
        
        //ProfileImage.imageFromServerURL(urlString: d)
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
        
        let url = URL(string: post.image!)
        let data = try? Data(contentsOf: url!)

        if let imageData = data {
            let image = UIImage(data: imageData)
            imageView.image = image
        }
        return cell!
    }
    
  
    override func viewDidAppear(_ animated: Bool) {
        
        postViewModel.GetPost(id: "", onSuccess: {
            //self.PostsTable.reloadData()
            
              
        }, onFailure: {errorMessage in
            print("error") }
        )
        
        PostsTable.reloadData()

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

