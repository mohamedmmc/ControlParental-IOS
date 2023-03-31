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
    
    @IBOutlet weak var PostsTable: UITableView!
    @IBOutlet weak var ViewPopUp: UIView!
    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var PostImage: UIImageView!
    @IBOutlet weak var Upload: UIButton!
    @IBOutlet weak var UploadImage: UITextField!
    
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
        
        postViewModel.GetPost(id: "638cda56c7a6bd07dc06ed7a", onSuccess: {
            //self.PostsTable.reloadData()
            
              
        }, onFailure: {errorMessage in
            print("error") }
        )
        
        PostsTable.reloadData()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        postViewModel.GetPost(id: "638cda56c7a6bd07dc06ed7a", onSuccess: {
            
            print(self.postViewModel.UserPosts)
              
        }, onFailure: {errorMessage in
            print("error") }
        )
 
        //Pop up View
        ViewPopUp.layer.cornerRadius = 20
        ViewPopUp.isHidden = true
        
        Upload.setTitle("", for: .normal)
  
        
        PostsTable.dataSource = self
        PostsTable.delegate = self
        
        let Defaults = UserDefaults.standard
        let id = Defaults.string(forKey: "_id")
        
        PostViewModel().GetPost(id: id as! String, onSuccess: {
            self.PostsTable.reloadData()
            
            print(self.postViewModel.UserPosts)
              
        }, onFailure: {errorMessage in
          print("error")
            
        })
        
        
        
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
extension UIView {
    func addDashedBorder() {
        let color = UIColor.lightGray.cgColor
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [6,3]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 4).cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
}
