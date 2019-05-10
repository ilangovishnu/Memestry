//
//  CameraViewController.swift
//  Memestry
//
//  Created by Vishnu Priya on 4/23/19.
//  Copyright © 2019 Codepath. All rights reserved.
//

import UIKit
import ProgressHUD
import Firebase
import FirebaseStorage
import FirebaseDatabase

class CameraViewController: UIViewController {
    
    @IBOutlet weak var captionTextView: UITextView!
    
    @IBOutlet weak var photo: UIImageView!
    
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var removeButton: UIBarButtonItem!
    
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = UIColor.green
        // Do any additional setup after loading the view.
      
        // Recognizes user tap gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleSelectPhoto))
        photo.addGestureRecognizer(tapGesture)
        photo.isUserInteractionEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
        handlePost()
    }
    
    
    func handlePost(){
        if selectedImage != nil {
            self.shareButton.isEnabled = true
            self.removeButton.isEnabled = true
            self.shareButton.backgroundColor = UIColor(red: 0 ,green: 0, blue: 0, alpha: 1)
        }
        else
        {
            self.shareButton.isEnabled = false
            self.removeButton.isEnabled = false
            self.shareButton.backgroundColor = .lightGray

        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func handleSelectPhoto() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
    }
    
    
    @IBAction func shareButton_TouchUpInside(_ sender: Any) {
         view.endEditing(true)

        ProgressHUD.show("Waiting...",interaction: false)
        if let profileImg = self.selectedImage, let imageData = profileImg.jpegData(compressionQuality: 0.1){
            let photoIdString = NSUUID().uuidString
            let storageRef = Storage.storage().reference(forURL: "gs://memestry-1b5b0.appspot.com").child("posts").child(photoIdString)
            storageRef.putData(imageData, metadata: nil, completion: {(metadata, error) in
                if error != nil {
                    return
                }

                storageRef.downloadURL(completion: { (url, error) in

                    if let photoUrl = url?.absoluteString {


                        self.sendDataToDatabase(photoUrl: photoUrl)

                    }

                }

                )

            })
        }
        else
        {
            ProgressHUD.showError("Image can't be empty")
        }


    }
    
    
    @IBAction func remove_TouchUpInside(_ sender: Any) {
        clean()
        handlePost()
    }
    
    
    func sendDataToDatabase(photoUrl: String){
        let uid = Auth.auth().currentUser?.uid
       let ref = Database.database().reference()
        let postsReference = ref.child("posts")
        let newPostId = postsReference.childByAutoId().key
        let newPostReference = postsReference.child(newPostId!)
        newPostReference.setValue(["userId": uid,"photoUrl": photoUrl, "caption": captionTextView.text!] ,withCompletionBlock:
            { (error,ref) in
            if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
            }

                ProgressHUD.showSuccess("Success")
//                self.captionTextView.text = ""
//                self.photo.image = UIImage(named: "image_placeholder")
//                self.selectedImage = nil
                self.clean()
                self.tabBarController?.selectedIndex = 0
        })

    }
    
    func clean(){
        self.captionTextView.text = ""
        self.photo.image = UIImage(named: "image_placeholder")
        self.selectedImage = nil
    }
    
}


                            
        
extension CameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
     @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        print("finish picking image media")
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImage = image
            photo.image = image
        }
        dismiss(animated: true, completion: nil)
        
    }
    

}
