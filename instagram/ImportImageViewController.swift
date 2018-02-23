//
//  ImportImageViewController.swift
//  instagram
//
//  Created by Thalia Villalobos on 2/20/18.
//  Copyright © 2018 Thalia Villalobos. All rights reserved.
//

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

    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
 let resizeImageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: newSize.width, height:newSize.height)))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    //allow to select from photo library
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if var image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            image = resize(image: image, newSize: CGSize(width:1000, height:1000))
            print("before selecting image")
            userImageView.image = image
        }else{
            print("Something went wrong")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
