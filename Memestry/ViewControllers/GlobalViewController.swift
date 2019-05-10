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
   
    var memes = [[String: Any]]()
    
     override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        //view.backgroundColor = UIColor.blue
        // Do any additional setup after loading the view.
        //https://api.giphy.com/v1/gifs/search?api_key=0Fn6uXrY8pgsMbxZoyjRID0P1ZuxdOEA&q=memes
        //https://api.tumblr.com/v2/tagged?tag=meme&api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV
        let url = URL(string: "https://api.tumblr.com/v2/blog/daily-meme.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
        
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
               let responseDictionary = dataDictionary["response"] as! [String: Any]
                //data //response
                self.memes = responseDictionary["posts"] as! [[String: Any]]

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
        
        
        //let baseUrl = "http://giphy.com/gifs/"
        //let posterPath = meme["url"] as! String
        //let posterUrl = URL(string: baseUrl + posterPath)
       // let posterUrl = URL(string: posterPath)

        
       // cell.posterView.af_setImage(withURL: posterUrl!)
        
        //images ,fixed_height_small_still, 3
        if let photos = meme["photos"] as? [[String: Any]] {
            let photo = photos[0]
            let originalSize = photo["original_size"] as! [String: Any]
            let urlString = originalSize["url"] as! String
            let url = URL(string: urlString)
            cell.posterView.af_setImage(withURL: url!)
        
        }
        
        
//        if let photos = meme["images"] as? [[String: Any]] {
//            let photo = photos[3]
//            let originalSize = photo["fixed_height_small_still"] as! [String: Any]
//            let urlString = originalSize["url"] as! String
//            let url = URL(string: urlString)
//            cell.posterView.af_setImage(withURL: url!)
//        }
//
        return cell
    }

    
}





    

