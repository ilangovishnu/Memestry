//
//  HomeViewController.swift
//  Memestry
//
//  Created by Vishnu Priya on 4/23/19.
//  Copyright © 2019 Codepath. All rights reserved.




import UIKit
import FirebaseAuth
import FirebaseDatabase
import Alamofire

class HomeViewController: UIViewController {

  

    
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [Post]()


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        loadPosts()
        //view.backgroundColor = UIColor.yellow
        // Do any additional setup after loading the view.
//        let post = Post(captionText: "text", photoUrlString: "url1")
//        print(post.caption)
//        print(post.photoUrl)
    }

    func loadPosts(){
        Database.database().reference().child("posts").observe(.childAdded){
            (snapshot: DataSnapshot) in

            if let dict = snapshot.value as? [String: Any]
            {

                let captionText = dict["caption"] as! String
                let photoUrlString = dict["photoUrl"] as! String
                let post = Post(captionText: captionText, photoUrlString: photoUrlString)
                self.posts.append(post)
                print(self.posts)
                self.tableView.reloadData()


            }
           //print(snapshot.value)
        }

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

extension HomeViewController: UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
        //return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
        //let cell = UITableViewCell()
        //cell.textLabel?.text = "\(indexPath.row)"
        cell.backgroundColor = UIColor.cyan
        cell.textLabel?.text = posts[indexPath.row].caption
        //cell.newPosterView?/.af_setImage = posts[indexPath.row].photoUrl
        return cell
    }



}
