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
    var imageDate : [String]! = []
    
    var refreshControl: UIRefreshControl!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(HomeViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        tableView.dataSource = self
        fetchPosts()
        
    }
    
    func didPullToRefresh(_ refreshControl: UIRefreshControl){
        imageText = []
        imageFiles = []
        imageDate = []
        fetchPosts()
    }
    
    func fetchPosts(){
        let query = PFQuery(className: "Posts")
        query.order(byDescending: "_created_at")
        query.limit = 20
        query.findObjectsInBackground { (posts: [PFObject]?, Error) in
            for post in posts!{
                //print (post["imageFile"])
                //print (post["imageText"])
                //print(post.createdAt!.description)

                self.imageFiles.append(post["imageFile"] as! PFFile)
                self.imageText.append(post["imageText"] as! String)
                self.imageDate.append(post.createdAt!.description)
            }
            print(self.imageFiles.count)
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell){
           let posts = imageText[indexPath.row]
           let date = imageDate[indexPath.row]
           let detailViewController = segue.destination as! DetailViewController
           detailViewController.posts = posts
           detailViewController.date = date
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
        
        self.imageFiles[indexPath.row].getDataInBackground({ (imageData: Data?, error: Error?) -> Void in
            let image = UIImage(data: imageData!)
            if image != nil {
                cell.cellImage.image = image
            }
        })
        
        return cell
    }
    
}
