//
//  HomeViewController.swift
//  Memestry
//
//  Created by Vishnu Priya on 4/23/19.
//  Copyright © 2019 Codepath. All rights reserved.




import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import Alamofire

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  //new
    var poster = [Poster]()

    
    @IBOutlet weak var tableView: UITableView!
    
//    var posts = [Post]()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
         //Uncomment later
        //loadPosts()
        
        retrieveUsers()
        
        //view.backgroundColor = UIColor.yellow
        // Do any additional setup after loading the view.
//        let post = Post(captionText: "text", photoUrlString: "url1")
//        print(post.caption)
//        print(post.photoUrl)
    }

    
    //Uncomment later
//    func loadPosts(){
//        Database.database().reference().child("posts").observe(.childAdded){
//            (snapshot: DataSnapshot) in
//
//            if let dict = snapshot.value as? [String: Any]
//            {
//
//                let captionText = dict["caption"] as! String
//                let photoUrlString = dict["photoUrl"] as! String
//                let post = Post(captionText: captionText, photoUrlString: photoUrlString)
//                self.posts.append(post)
//                print(self.posts)
//                self.tableView.reloadData()
//
//
//            }
//           //print(snapshot.value)
//        }
//
//    }
    
    
    //new adddition
    
    //queryOrderedByKey()
    func retrieveUsers(){
        
        let ref = Database.database().reference()
        ref.child("posts").queryOrderedByKey().observeSingleEvent(of: .value, with: {snapshot in
            let users = snapshot.value as! [String : AnyObject]
            self.poster.removeAll()
            for (_, value) in users {
               // if let uid = value["username"] as? String{
                 //   if uid != Auth.auth().currentUser!.uid {
                        let userToShow = Poster()
                        if let caption = value["caption"] as? String, let imagePath = value["photoUrl"] as? String {
                            
                            
                            userToShow.imagePath = imagePath
                            userToShow.caption = caption
                            //userToShow.userID = uid
                            self.poster.append(userToShow)
                        }
                        
                 //   }
               // }
            }
            
            self.tableView.reloadData()
            
        })
        
        ref.removeAllObservers()
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        
        cell.captionLabel.text = self.poster[indexPath.row].caption
        //cell.userID = self.user[indexPath.row].userID
        cell.posterView.downloadImage(from: self.poster[indexPath.row].imagePath)
        //checkFollowing(indexPath: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return poster.count ?? 0
    }
    
    
    
    


    @IBAction func logout_TouchUpInside(_ sender: Any) {
        //print(Auth.auth().currentUser!)
        do{
            try Auth.auth().signOut()
        }
        catch let logoutError {

            print(logoutError)
        }
        //print(Auth.auth().currentUser!)

        let storyboard = UIStoryboard(name: "Start", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier:  "LoginViewController")

        self.present(loginVC, animated: true, completion: nil)
    }


}

//extension UIImageView {
//
//    func downloadImage(from imgUrl: String){
//
//        let url = URLRequest(url: URL(string: imgUrl)!)
//        let task = URLSession.shared.dataTask(with: url){
//            (data, response, error) in
//            if error != nil {
//                print(error!)
//                return
//            }
//
//            DispatchQueue.main.async {
//                self.image = UIImage(data: data!)
//            }
//
//        }
//
//        task.resume()
//    }
//
//
//
//}


//uncomment later


//extension HomeViewController: UITableViewDataSource{
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return posts.count
//        //return 100
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
//        //let cell = UITableViewCell()
//        //cell.textLabel?.text = "\(indexPath.row)"
//        cell.backgroundColor = UIColor.cyan
//        cell.textLabel?.text = posts[indexPath.row].caption
//        //cell.newPosterView?/.af_setImage = posts[indexPath.row].photoUrl
//        return cell
//    }
//
//
//
//}
