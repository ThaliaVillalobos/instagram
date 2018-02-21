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

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
            posts.saveInBackground(block: { (sccess:Bool, error: NSError?) -> Void in
                if error == nil{
                    //create an image data
                    let imageData = UIImagePNGRepresentation(self.userImageView.image!)
                    let parseImageFile = PFFile(name:"uploaded_image.png", data: imageData!)
                    posts["imageFile"] = parseImageFile
                    posts.saveInBackground(block: { (sccess:Bool, error: NSError?) -> Void in
                        if error == nil{
                            print ("data uploaded")
                        }else{
                            print("error")
                        }
                    } as? PFBooleanResultBlock)
                }
            } as? PFBooleanResultBlock)
        }
    }

    @IBAction func backHome(_ sender: AnyObject) {
        performSegue(withIdentifier: "goHome", sender: self)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            userImageView.image = image
        }else{
            print("Something went wrong")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
