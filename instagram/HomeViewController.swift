//
//  HomeViewController.swift
//  instagram
//
//  Created by Thalia Villalobos on 2/20/18.
//  Copyright © 2018 Thalia Villalobos. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDataSource {
  
    @IBOutlet var tableView: UITableView!
    
    var imageFiles : [PFFile]! = []
    var imageText : [String]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        let query = PFQuery(className: "Posts")
        query.order(byDescending: "createdAt")
        query.findObjectsInBackground { (posts: [PFObject]?, Error) in
            for post in posts!{
                //print (post["imageFile"])
               //print (post["imageText"])

              self.imageFiles.append(post["imageFile"] as! PFFile)
              self.imageText.append(post["imageText"] as! String)
            }
            print(self.imageFiles.count)
            self.tableView.reloadData()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageFiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        
        cell.imageTextLabel.text = imageText[indexPath.row]
        
        return cell
    }
    
}
