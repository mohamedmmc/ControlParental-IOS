//
//  user.swift
//  syncaid
//
//  Created by AhmedFatma on 11/11/2022.
//

import Foundation


struct User: Codable {
    
    
    let _id : String?
    let email : String?
    let mdp : String?
    let FullName: String?
    let confrimMdp:String?
    let verified:Bool?
    let otp:String?
    let username:String?
    let PhoneNumber:String?
    let Gender:String?
    let BirthDate:String?
    let Description:String?
    let otpReset:String?
    let ProfilePic:String?
    let createdAt:String?
    
    enum CodingKeys: String, CodingKey {
      
        case _id
        case email
        case mdp
        case FullName
        case confrimMdp
        case verified
        case otp
        case username
        case PhoneNumber
        case Gender
        case BirthDate
        case Description
        case otpReset
        case ProfilePic
        case createdAt
   
    }
    
    
    
 
    
    init(_id:String,email:String,mdp:String,FullName:String,confrimMdp:String,verified:Bool,otp:String,username:String,PhoneNumber:String,Gender:String,BirthDate:String,Description:String,otpReset:String, ProfilePic:String, createdAt:String)
    {
        self._id=_id
        self.email=email
        self.mdp=mdp
        self.FullName=FullName
        self.confrimMdp=confrimMdp
        self.verified=verified
        self.otp=otp
        self.username=username
        self.PhoneNumber=PhoneNumber
        self.Gender=Gender
        self.BirthDate=BirthDate
        self.Description=Description
        self.otpReset=otpReset
        self.ProfilePic=ProfilePic
        self.createdAt=createdAt
        
     
    }
                
}
