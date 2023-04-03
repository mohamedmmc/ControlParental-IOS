//
//  AddPostViewController.swift
//  mini_projet
//
//  Created by Mac Mini 5 on 29/12/2022.
//

import UIKit

class AddPostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let postViewModel = PostViewModel()
    
    @IBOutlet weak var titleField: UITextField!
    
    @IBOutlet weak var descriptionField: UITextView!
    
    @IBOutlet weak var imageview: UIImageView!
    
    
    var picker_image: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func pick(_ sender: Any) {
        let myPickerControllerGallery = UIImagePickerController()
                      myPickerControllerGallery.delegate = self
                      myPickerControllerGallery.sourceType = UIImagePickerController.SourceType.photoLibrary
                      myPickerControllerGallery.allowsEditing = true
                      self.present(myPickerControllerGallery, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let editedimage = info[.editedImage] as? UIImage else  {
                return
            }
            picker_image = editedimage
                  imageview.image = editedimage
                  
            self.dismiss(animated: true, completion: nil)
        }
    
    
    @IBAction func publish(_ sender: Any) {
        
        // Check if UITextField is empty
        if titleField.text?.isEmpty ?? true {
            // Show alert
            let alert = UIAlertController(title: "Error", message: "Please enter a value in the title field", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        } else if imageview.image == nil {
            // Show alert
            let alert = UIAlertController(title: "Error", message: "Please select an image", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        } else {
            // Inputs are valid, proceed with sending the request to the server
            postViewModel.AddPost(title: titleField.text!, description: descriptionField.text!,photo: picker_image! , onSuccess: {
                
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)

                }            }, onFailure: {errorMessage in
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)

                }
            }
            )
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)

            }
        }
           
            
        
    }
}
