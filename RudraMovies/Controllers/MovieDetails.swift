//
//  MovieDetails.swift
//  RudraMovies
//
//  Created by hemanth on 29/03/21.
//

import UIKit

class MovieDetails: UIViewController {

    @IBOutlet weak var set2: UICollectionView!
    @IBOutlet weak var set1: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        set1.delegate = self
        set1.dataSource = self
        
        set2.delegate = self
        set2.dataSource = self
        
    }
    

}

extension MovieDetails : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == set1 {
            return 10
        } else {
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == set1 {
            let cell = set1.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as? HomeCollectionViewCell
            return cell!
        } else {
            let cell = set2.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell1", for: indexPath) as? HomeCollectionViewCell1
            return cell!        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == set1 {
            return CGSize(width: 100, height: 100)
        } else {
            return CGSize(width: 100, height: 100)
        }
    }
    
}
