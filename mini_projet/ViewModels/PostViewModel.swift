//
//  PostViewModel.swift
//  mini_projet
//
//  Created by Mac Mini 5 on 2/12/2022.
//

import Foundation
import Alamofire

class PostViewModel:ObservableObject{
    static let shareInstance = PostViewModel()

    @Published var UserPosts = [Post]()

    
    let hostAdresse="http://localhost:9090"
    
    func AddPost(title:String,description:String, photo: UIImage, onSuccess: @escaping () -> Void ,onFailure: @escaping (_ errorMessage: String) -> Void)
    {
        let defaults = UserDefaults.standard
       let  userid = defaults.string(forKey: "_id")
        
        let parameters = [
            "userId" : userid,
                    "title" : title,
                    "description": description]
        
        AF.upload(
                multipartFormData: { MultipartFormData in
                //    multipartFormData.append(imageData, withName: "user", fileName: "user.jpg", mimeType: "image/jpeg")

                    for (key, value) in parameters {
                        MultipartFormData.append(value!.data(using: String.Encoding.utf8)!, withName: key)
                    }

                    if let data = photo.jpegData(compressionQuality: 0.5) {
                        MultipartFormData.append(data, withName: "image", fileName: "image.jpeg", mimeType: "image/jpeg")
                                }


            }, to: hostAdresse+"/addPost/") .responseDecodable(of: Post.self) { response in
                debugPrint(response)
            }


            }
                  
                
                
        
    
        
    
    
    func GetPost(id:String,onSuccess: @escaping () -> Void ,onFailure: @escaping (_ errorMessage: String) -> Void)
        {
            AF.request(hostAdresse+"/getPost/"+id, method: .get,encoding: JSONEncoding.default)
                .validate()
                .responseDecodable(of: [Post].self) {
                    (response) in
                    switch response.result {
                        
                        case .success(let data):
                        self.UserPosts = data
                        print("Post get successful")
                        
                   
                        onSuccess()

                        //print(data)
                        
                        case .failure(let err):
                        onFailure(err.localizedDescription)
                        print("Failed to get post",err)
                        
                        return
                    }
                  
                    
                      
                    
                    
                }

    }
    func GetAllPosts() -> Array<Post>{
        
                var posts = [Post]()

                   var semaphore = DispatchSemaphore (value: 0)

                   let parameters = ""
                   let postData =  parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: hostAdresse+"/getAllPosts/" + UserDefaults.standard.string(forKey: "_id")!)!,timeoutInterval: Double.infinity)
                   request.httpMethod = "GET"
                   request.httpBody = postData
        print(request)
                   let task = URLSession.shared.dataTask(with: request) { data, response, error in
                     guard let data = data else {
                       print(String(describing: error))
                       semaphore.signal()
                       return
                     }
                       do {
                           posts = try JSONDecoder().decode(Array<Post>.self, from: data)
                           

                           
                        
                           
                           
                       } catch let err {
                           print(err)
                       }
                     //print(String(data: data, encoding: .utf8)!)
                     semaphore.signal()
                   }

                   task.resume()
                   semaphore.wait()
                   return posts

    }
    
    
    
    
    }
