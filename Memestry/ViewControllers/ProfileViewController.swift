//
//  ProfileViewController.swift
//  Memestry
//
//  Created by Vishnu Priya on 4/23/19.
//  Copyright © 2019 Codepath. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    var user = [User]()
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        //view.backgroundColor = UIColor.red
        // Do any additional setup after loading the view.
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
         retrieveUsers()
        
    }
    
    func retrieveUsers(){
        
    let ref = Database.database().reference()
        ref.child("users").queryOrderedByKey().observeSingleEvent(of: .value, with: {snapshot in
            let users = snapshot.value as! [String : AnyObject]
            self.user.removeAll()
            for (_, value) in users {
                if let uid = value["username"] as? String{
                    if uid != Auth.auth().currentUser!.uid {
                        let userToShow = User()
                        if let fullName = value["username"] as? String, let imagePath = value["profileImageUrl"] as? String {
                            
                            
                            userToShow.imagePath = imagePath
                            userToShow.fullName = fullName
                            userToShow.userID = uid
                            self.user.append(userToShow)
                        }

                    }
                }
            }
            
            self.tableView.reloadData()
            
        })
        
        ref.removeAllObservers()
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell
        
        cell.nameLabel.text = self.user[indexPath.row].fullName
        cell.userID = self.user[indexPath.row].userID
        cell.userImage.downloadImage(from: self.user[indexPath.row].imagePath)
        checkFollowing(indexPath: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    let uid = Auth.auth().currentUser!.uid
    let ref = Database.database().reference()
    let key = ref.child("users").childByAutoId().key
        
    var isFollower = false
        
    ref.child("users").child(uid).child("following").queryOrderedByKey().observeSingleEvent(of: .value, with:
        { snapshot in
            
            if let following = snapshot.value as? [String : AnyObject] {
                for (ke, value) in following
                {
                    if (value as! String) == self.user[indexPath.row].userID {
                    isFollower = true
                    
                    ref.child("users").child(uid).child("following/\(ke)").removeValue()
                    ref.child("users").child(self.user[indexPath.row].userID).child("followers/\(ke)").removeValue()
                    self.tableView.cellForRow(at: indexPath)?.accessoryType = .none
                }
            }
        
        }
            
            if !isFollower{
                let following = ["following/\(key)" : self.user[indexPath.row].userID]
                 let followers = ["followers/\(key)" : uid]
                
                ref.child("users").child("uid").updateChildValues(following)
                ref.child("users").child(self.user[indexPath.row].userID).updateChildValues(followers)
                
                self.tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
                
            }

    })
        ref.removeAllObservers()
}
    
    func checkFollowing(indexPath: IndexPath) {
        
        let uid = Auth.auth().currentUser!.uid
        let ref = Database.database().reference()
        
        ref.child("users").child(uid).child("following").queryOrderedByKey().observeSingleEvent(of: .value, with:
        
            { snapshot in
                
                if let following = snapshot.value as? [String : AnyObject] {
                    for (_, value) in following
                    {
                        if (value as! String) == self.user[indexPath.row].userID {
                
                            self.tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
                        }
                    }
                    
                }
                
        })
        
        ref.removeAllObservers()
    
        
        
        
        
    }
    
    
    
    
    
    
}

extension UIImageView {
    
    func downloadImage(from imgURL: String){
        
        let url = URLRequest(url: URL(string: imgURL)!)
        let task = URLSession.shared.dataTask(with: url){
            (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        
        }
        
        task.resume()
    }
    
    
    
}
