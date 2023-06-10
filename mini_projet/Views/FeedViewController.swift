//
//  FeedViewController.swift
//  mini_projet
//
//  Created by Mac Mini 5 on 25/11/2022.
//

import UIKit
import SwiftUI
import Foundation
import Lottie
class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
   
    
    var allposts = PostViewModel.shareInstance.GetAllPosts()
    @ObservedObject var postViewModel = PostViewModel()
    @IBOutlet weak var allPostsTable: UITableView!
    @IBOutlet weak var animationView: LottieAnimationView!

    
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
        let heart = contentView?.viewWithTag(75) as! UIImageView
        let likes = contentView?.viewWithTag(5) as! UILabel
        let post = allposts[indexPath.row]
        
        title.text = post.title
        description.text = post.description
        username.text = post.userId?.FullName
        if let likesCount = post.likes?.count {
            likes.text = "Likes: \(likesCount)"
        } else {
            likes.text = "Likes: 0"
        }
        if let currentUserId = UserDefaults.standard.string(forKey: "_id"),
            let postLikes = post.likes,
            postLikes.contains(currentUserId) {
            heart.image = UIImage(systemName: "heart.fill")
        }else{
            heart.image = UIImage(systemName: "heart")
        }


        if (post.image == "no image"){
            imageView.image = UIImage(named: "user")
        } else{
            imageView.imageFromServerURL(urlString: post.image!)
        }
        return cell!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.allposts = self.postViewModel.GetAllPosts()
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.5
        animationView.isHidden = true
        animationView.play()
        if(self.allposts.isEmpty){
            self.allPostsTable.isHidden = true
            self.animationView.isHidden = false
        }else{
            self.allPostsTable.isHidden = false
            self.animationView.isHidden = true
        }
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
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var archive = UIContextualAction()
        if let postLikes = allposts[indexPath.row].likes, postLikes.contains(UserDefaults.standard.string(forKey: "_id")!) {
            // _id exists in the list of likes for this post
            archive = UIContextualAction(style: .normal, title: "Dislike") { [weak self] (action, view, completionHandler) in
                self?.handleMoveToArchive(indexPath: indexPath)
                completionHandler(true)
            }
            archive.backgroundColor = .systemRed
        } else {
            // _id does not exist in the list of likes for this post
            archive = UIContextualAction(style: .normal, title: "Like") { [weak self] (action, view, completionHandler) in
                self?.handleMoveToArchive(indexPath: indexPath)
                completionHandler(true)
            }
            archive.backgroundColor = .systemGreen
        }
             let configuration = UISwipeActionsConfiguration(actions: [archive])
            
                    return configuration
    }
    
    private func handleMoveToArchive(indexPath:IndexPath) {
        postViewModel.likeUnlike(postId: allposts[indexPath.row]._id!) { success in
            if success{
                DispatchQueue.main.async {
                    self.allposts = self.postViewModel.GetAllPosts()
                    self.allPostsTable.reloadData()
                }
              
            }
        }
    }
}
