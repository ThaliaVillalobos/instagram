//
//  ImportImageViewController.swift
//  instagram
//
//  Created by Thalia Villalobos on 2/20/18.
//  Copyright © 2018 Thalia Villalobos. All rights reserved.
//

import UIKit
import Parse

class ImportImageViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

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
    
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            userImageView.image = image
        }else{
            //error message
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
