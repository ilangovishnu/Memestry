//
//  GlobalViewController.swift
//  Memestry
//
//  Created by Vishnu Priya on 4/23/19.
//  Copyright © 2019 Codepath. All rights reserved.
//

import UIKit

class GlobalViewController: UIViewController {

    
    //Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = UIColor.blue
        // Do any additional setup after loading the view.
    }

}
extension GlobalViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCell", for: indexPath)
        
        return cell 
    }
    }
    
    

