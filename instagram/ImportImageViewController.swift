//
//  ImportImageViewController.swift
//  instagram
//
//  Created by Thalia Villalobos on 2/20/18.
//  Copyright © 2018 Thalia Villalobos. All rights reserved.
//

//************Fix image, does not display in database*************


import UIKit
import Parse

class ImportImageViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var capationTextField: UITextField!
    var window: UIWindow?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Allow user to click on the image to select a picture
    @IBAction func uploadImage(_ sender: AnyObject) {
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        image.allowsEditing = false
        
        self.present(image, animated: true)
        {
            //after it is complete
        }
    }
    
    
    @IBAction func submitImage(_ sender: AnyObject) {
        let imageText = capationTextField.text
        
        if userImageView.image == nil{
            //image is not includeded alert user
            print("Image not uploaded")
        }else{
            let posts = PFObject(className: "Posts")
            posts["imageText"] = imageText
            posts["user"] = PFUser.current()
            
            let imageData = UIImagePNGRepresentation(self.userImageView.image!)
            let parseImageFile = PFFile(name:"uploaded_image.png", data: imageData!)

            posts["imageFile"] = parseImageFile
            posts.saveInBackground()

            performSegue(withIdentifier: "backHome", sender: nil)
        }
    }

    
   
    
    //allow to select from photo library
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            print("before selecting image")
            userImageView.image = image
        }else{
            print("Something went wrong")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
