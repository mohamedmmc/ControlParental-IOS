//
//  UserViewModel.swift
//  mini_projet
//
//  Created by Mac Mini 5 on 19/11/2022.
//

import Foundation
import Alamofire
import SendbirdUIKit
class UserViewModel:ObservableObject{
    static let shareInstance = UserViewModel()
    
    
    @Published var VerificationEmail: String?
//    let hostAdresse="http://192.168.1.30:9090"
//    let hostAdresse="http://172.20.10.3:9090"
    let hostAdresse="https://aestetica.onrender.com"
    
    
    func Login (email:String,password:String,onSuccess: @escaping () -> Void ,onFailure: @escaping (_ errorMessage: String) -> Void){
        
        AF.request(hostAdresse+"/MiniProjet/login" , method: .post, parameters: ["email":email,"mdp": password] ,encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: User.self) {
                (response) in
                switch response.result {
                    
                case .success(let data): print("Login successful")
                    let defaults = UserDefaults.standard
                    defaults.set(data._id, forKey: "_id")
                    defaults.set(data.verified, forKey: "verified")
                    defaults.set(data.FullName, forKey: "FullName")
                    defaults.set(data.username, forKey: "username")
                    defaults.set(data.ProfilePic, forKey: "ProfilePic")
                    defaults.set(data.PhoneNumber, forKey: "PhoneNumber")
                    defaults.set(data.Description, forKey: "Description")
                    defaults.set(data.Gender, forKey: "Gender")
                    defaults.set(data.BirthDate, forKey: "BirthDate")
                    defaults.set(data.createdAt, forKey: "createdAt")
                    SBUGlobals.currentUser = SBUUser(userId: data._id!)
                    onSuccess()
                    
                    
                case .failure(let err):
                    onFailure(err.localizedDescription)
                    print("Login failed",err)
                    
                    return
                }
                
            }
    }
    
    func LoginGoogle (email:String,onSuccess: @escaping () -> Void ,onFailure: @escaping (_ errorMessage: String) -> Void){
        
        AF.request(hostAdresse+"/MiniProjet/loginGoogle" , method: .post, parameters: ["email":email] ,encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: User.self) {
                (response) in
                switch response.result {
                    
                case .success(let data): print("Login successful")
                    let defaults = UserDefaults.standard
                    defaults.set(data._id, forKey: "_id")
                    defaults.set(data.verified, forKey: "verified")
                    defaults.set(data.FullName, forKey: "FullName")
                    defaults.set(data.username, forKey: "username")
                    defaults.set(data.ProfilePic, forKey: "ProfilePic")
                    defaults.set(data.PhoneNumber, forKey: "PhoneNumber")
                    defaults.set(data.Description, forKey: "Description")
                    defaults.set(data.Gender, forKey: "Gender")
                    defaults.set(data.BirthDate, forKey: "BirthDate")
                    defaults.set(data.createdAt, forKey: "createdAt")
                    SBUGlobals.currentUser = SBUUser(userId: UserDefaults.standard.string(forKey: "_id")!)
                    onSuccess()
                    
                    
                case .failure(let err):
                    onFailure(err.localizedDescription)
                    print("Login failed",err)
                    
                    return
                }
                
            }
    }
    
    
    
    
    func register(email:String,mdp:String,FullName:String,confrimMdp:String,onSuccess: @escaping () -> Void ,onFailure: @escaping (_ errorMessage: String) -> Void)
    {
        AF.request(hostAdresse+"/MiniProjet/register" , method: .post, parameters: ["email":email,"mdp": mdp,"FullName":FullName,"confirmMdp":confrimMdp] ,encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: User.self) {
                (response) in
                switch response.result {
                case .success(let data): print("Registeration successful")
                    let defaults = UserDefaults.standard
                    
                    defaults.set(data._id, forKey: "_id")
                    defaults.set(data.verified, forKey: "verified")
                    defaults.set(data.email, forKey: "email")
                    defaults.set(data.FullName, forKey: "FullName")
                    defaults.set(data.username, forKey: "username")
                    defaults.set(data.ProfilePic, forKey: "ProfilePic")
                    defaults.set(data.PhoneNumber, forKey: "PhoneNumber")
                    defaults.set(data.Description, forKey: "Description")
                    defaults.set(data.Gender, forKey: "Gender")
                    defaults.set(data.BirthDate, forKey: "BirthDate")
                    defaults.set(data.createdAt, forKey: "createdAt")
                    SBUGlobals.currentUser = SBUUser(userId: UserDefaults.standard.string(forKey: "_id")!)
                    onSuccess()
                    
                case .failure(let err):
                    onFailure(err.localizedDescription)
                    print("Registeration failed",err)
                    
                    
                    return
                }
                
            }
    }
    
    
    
    func verifyEmail(email:String,otp:String,onSuccess: @escaping () -> Void ,onFailure: @escaping (_ errorMessage: String) -> Void)
    {
        AF.request(hostAdresse+"/MiniProjet/verify" , method: .post, parameters: ["email":email,"otp":otp] ,encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: User.self) {
                (response) in
                switch response.result {
                    
                case .success(let data): print("Verification successful")
                    let defaults = UserDefaults.standard
                    defaults.set(data.email, forKey: "email")
                    defaults.set(data.verified, forKey: "verified")
                    onSuccess()
                    
                case .failure(let err):
                    onFailure(err.localizedDescription)
                    print("Verification failed",err)
                    
                    
                    return
                }
                
                
            }
    }
    
    func resendOTP(id:String,onSuccess: @escaping () -> Void ,onFailure: @escaping (_ errorMessage: String) -> Void)
    {
        AF.request(hostAdresse+"/MiniProjet/resend/OTP" , method: .post, parameters: ["id":id] ,encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: User.self) {
                (response) in
                switch response.result {
                    
                case .success(let data): print("Verification successful")
                    let defaults = UserDefaults.standard
                    defaults.set(data.email, forKey: "email")
                    defaults.set(data.verified, forKey: "verified")
                    onSuccess()
                    
                case .failure(let err):
                    onFailure(err.localizedDescription)
                    print("Verification failed",err)
                    
                    
                    return
                }
                
                
            }
    }
    
    
    
    
    func getlink(email:String,onSuccess: @escaping () -> Void ,onFailure: @escaping (_ errorMessage: String) -> Void)
    {
        AF.request(hostAdresse+"/MiniProjet/getOTP" , method: .post, parameters: ["email":email] ,encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: User.self) {
                (response) in
                switch response.result {
                    
                case .success(let data): print("OTP sent to email")
                    let defaults = UserDefaults.standard
                    defaults.set(data.email, forKey: "email")
                    onSuccess()
                    
                    
                case .failure(let err):
                    onFailure(err.localizedDescription)
                    print("Failed to send OTP",err)
                    
                    
                    return
                }
                
            }
    }
    
    func resetPassword(email:String,mdp:String,otpReset:String,onSuccess: @escaping () -> Void ,onFailure: @escaping (_ errorMessage: String) -> Void)
    {
        AF.request(hostAdresse+"/MiniProjet/resetPassword" , method: .post, parameters: ["email":email,"mdp":mdp,"otpReset":otpReset] ,encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: User.self) {
                (response) in
                switch response.result {
                    
                case .success(let data): print("Password reset with success")
                    onSuccess()
                    
                case .failure(let err):
                    onFailure(err.localizedDescription)
                    print("Password reset failed",err)
                    
                    
                    return
                }
                
            }
    }
    
    func GetById(ID:String)
    {
        AF.request(hostAdresse+"/MiniProjet/"+ID, method: .get ,encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: User.self) {
                (response) in
                guard let data = response.value else { return }
                do {
                    let defaults = UserDefaults.standard
                    defaults.set(data._id, forKey: "_id")
                    defaults.set(data.verified, forKey: "verified")
                    defaults.set(data.email, forKey: "email")
                    defaults.set(data.FullName, forKey: "FullName")
                    defaults.set(data.username, forKey: "username")
                    defaults.set(data.ProfilePic, forKey: "ProfilePic")
                    defaults.set(data.PhoneNumber, forKey: "PhoneNumber")
                    defaults.set(data.Description, forKey: "Description")
                    defaults.set(data.Gender, forKey: "Gender")
                    defaults.set(data.createdAt, forKey: "createdAt")
                    defaults.set(data.BirthDate, forKey: "BirthDate")
                    
                    
                    print(data)
                }
                
            }
    }
    
    
    
    func findUserById(id: String) -> User {
        var user = User(_id: "", email: "", mdp: "", FullName: "", confrimMdp: "", verified: false, otp: "", username: "", PhoneNumber: "", Gender: "", BirthDate: "", Description: "", otpReset: "",ProfilePic: "",createdAt: "")
        var semaphore = DispatchSemaphore (value: 0)
        
        var request = URLRequest(url: URL(string: hostAdresse+"/MiniProjet/"+id)!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                semaphore.signal()
                return
            }
            do {
                user = try JSONDecoder().decode(User.self, from: data)
                let defaults = UserDefaults.standard
                defaults.set(user._id, forKey: "_id")
                defaults.set(user.verified, forKey: "verified")
                defaults.set(user.email, forKey: "email")
                defaults.set(user.FullName, forKey: "FullName")
                defaults.set(user.username, forKey: "username")
                defaults.set(user.ProfilePic, forKey: "ProfilePic")
                defaults.set(user.PhoneNumber, forKey: "PhoneNumber")
                defaults.set(user.Description, forKey: "Description")
                defaults.set(user.Gender, forKey: "Gender")
                defaults.set(user.BirthDate, forKey: "BirthDate")
                defaults.set(user.createdAt, forKey: "createdAt")
                
            } catch let err {
                print(err)
            }
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
        return user
        
    }
    
    func UpdateById(ID:String,username:String,PhoneNumber:String,Gender:String,BirthDate:String,Description:String,photo: UIImage?,onSuccess: @escaping () -> Void ,onFailure: @escaping (_ errorMessage: String) -> Void)
    {
        
        let parameters = [
            "username" : username,
            "PhoneNumber" : PhoneNumber,
            "Gender": Gender,
            "BirthDate": BirthDate,
            "Description": Description]
        
        AF.upload(
            multipartFormData: { MultipartFormData in
                
                for (key, value) in parameters {
                    MultipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }
               if ((photo) != nil){
                    if let data = photo!.jpegData(compressionQuality: 0.5) {
                        MultipartFormData.append(data, withName: "image", fileName: "image.jpeg", mimeType: "image/jpeg")
                    }
                }
                
                
                
            }, to: hostAdresse+"/MiniProjet/update/"+ID, method: .put) .responseDecodable(of: User.self) { response in
                switch response.result {
                    
                case .success(let data):
                    guard let data = response.value else { return }
                    do {
                        let defaults = UserDefaults.standard
                        DispatchQueue.main.async {
                            defaults.set(data.email, forKey: "email")
                            defaults.set(data.verified, forKey: "verified")
                            defaults.set(data.username, forKey: "username")
                            defaults.set(data.ProfilePic, forKey: "ProfilePic")
                            defaults.set(data.PhoneNumber, forKey: "PhoneNumber")
                            defaults.set(data.Description, forKey: "Description")
                            defaults.set(data.Gender, forKey: "Gender")
                            defaults.set(data.createdAt, forKey: "createdAt")
                            defaults.set(data.BirthDate, forKey: "BirthDate")
                        }
                    }
                    onSuccess()
                    
                case .failure(let err):
                    onFailure(err.localizedDescription)
                    print("Password reset failed",err)
                    
                    
                    return
                }
             
                
            }
    }
        
        func logOut()
        {
            AF.request(hostAdresse+"/MiniProjet/logOut", method: .post,encoding: JSONEncoding.default)
                .validate()
                .responseDecodable(of: User.self) {
                    (response) in
                    guard let data = response.value else { return }
                    do {
                        print(data)
                    }
                    
                }
        }

        
    }
