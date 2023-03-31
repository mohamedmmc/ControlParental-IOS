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
        
        

        
        username.text = allposts[indexPath.row].userId!
    
        
        
        
        let url = URL(string: post.image!)
        let data = try? Data(contentsOf: url!)

        if let imageData = data {
            let image = UIImage(data: imageData)
            imageView.image = image
        }
        return cell!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        allPostsTable.dataSource = self
        allPostsTable.delegate = self
        
    }
    
    
    
    
    
    
    

}








    




