//
//  GlobalViewController.swift
//  Memestry
//
//  Created by Vishnu Priya on 4/23/19.
//  Copyright © 2019 Codepath. All rights reserved.
//

import UIKit
import AlamofireImage

class GlobalViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   

    
    //MARK: Outlets
    
    @IBOutlet var tableView: UITableView!
    //let images = ["a","b","c"]
    var memes = [[String: Any]]()
    
     override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        //view.backgroundColor = UIColor.blue
        // Do any additional setup after loading the view.
        let url = URL(string: "https://api.giphy.com/v1/gifs/trending?api_key=0Fn6uXrY8pgsMbxZoyjRID0P1ZuxdOEA&limit=5&rating=G")!
        
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                self.memes = dataDictionary["data"] as! [[String: Any]]

                // Store the returned array of dictionaries in our posts property
                self.tableView.reloadData()
               // print(dataDictionary)
                
                
            }
        }
        task.resume()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell", for: indexPath) as! MemeCell
        //  let post = posts[indexPath.row]
        let meme = memes[indexPath.row]
        //let title = movie["title"] as! String
       // let synopsis = movie["overview"] as! String
        
        
        //cell.titleLabel.text = title
        //cell.synopsisLabel.text = synopsis
        
        let baseUrl = "http://giphy.com/gifs/"
        let posterPath = meme["url"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        
        cell.posterView.af_setImage(withURL: posterUrl!)
        
        return cell
    }

    
}





    

