//
//  FeedViewController.swift
//  mini_projet
//
//  Created by Mac Mini 5 on 25/11/2022.
//

import UIKit
import SwiftUI
import Foundation

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
   
    
    var allposts = PostViewModel.shareInstance.GetAllPosts()
    @ObservedObject var postViewModel = PostViewModel()
    @IBOutlet weak var allPostsTable: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allposts.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ncell")
        
        let contentView = cell?.contentView
        let title = contentView?.viewWithTag(1) as! UILabel
        let description = contentView?.viewWithTag(2) as! UITextView
        
        let username = contentView?.viewWithTag(4) as! UILabel

        let imageView = contentView?.viewWithTag(3) as! UIImageView
        
        let post = allposts[indexPath.row]
        
        title.text = post.title
        description.text = post.description
        username.text = allposts[indexPath.row].userId?.FullName
        if (allposts[indexPath.row].image == "no image"){
            imageView.image = UIImage(named: "user")
        } else{
            imageView.imageFromServerURL(urlString: allposts[indexPath.row].image!)
        }
        return cell!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.allposts = self.postViewModel.GetAllPosts()
        self.allPostsTable.reloadData()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
  

          // Hide the back button
          navigationItem.hidesBackButton = true

        

          // Set up table view
          allPostsTable.dataSource = self
        allPostsTable.delegate = self

        
    }

}
