//
//  Post.swift
//  mini_projet
//
//  Created by Mac Mini 5 on 2/12/2022.
//

import Foundation


struct Post: Codable {
    
    
    let _id : String?
    let title : String?
    let description : String?
    let userId:User?
    let image: String?
    
   
    
    enum CodingKeys: String, CodingKey {
      
        case _id
        case title
        case description
        case image
        case userId
   
    }
    
    
    
 
    
    init(_id:String,title:String,description:String,image:String,userId:User)
    {
        self._id=_id
        self.title=title
        self.description=description
        self.image=image
        self.userId=userId
  
        
     
    }
                
        }
    
