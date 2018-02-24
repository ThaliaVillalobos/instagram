//
//  DetailViewController.swift
//  instagram
//
//  Created by Thalia Villalobos on 2/23/18.
//  Copyright © 2018 Thalia Villalobos. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!

    var posts:String = ""
    var date:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        textLabel.text = posts

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ssZZZZZ"
        
        let date = dateFormatter.date(from: self.date)
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "EEEE, MMM d, yyyy"
        dateLabel.text = dateFormatterPrint.string(from: date!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   }
