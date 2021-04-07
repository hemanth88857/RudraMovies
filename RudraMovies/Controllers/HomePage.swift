//
//  HomePage.swift
//  RudraMovies
//
//  Created by hemanth on 27/03/21.
//

import UIKit
import  Alamofire
import SDWebImage

class HomePage: UIViewController {
    
    
    @IBOutlet weak var upCmgCV: UICollectionView!
    @IBOutlet weak var topRatedCV: UICollectionView!
    @IBOutlet weak var topView: UIView!
    
    
    var ApiData : [String : Any]!
    var movieApiData :[[String:Any]]!
    var imgArr = [String]()
    
    var TPApiData : [String : Any]!
    var TPmovieApiData :[[String:Any]]!
    var TPimgArr = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        upCmgCV.delegate = self
        upCmgCV.dataSource = self
        
        topRatedCV.delegate = self
        topRatedCV.dataSource = self
        
        
        
        if Reachability.isConnectedToNetwork() {
            self.TopRatedAPicall()
            self.UpCommingAPicall()
        } else {
            print("Check Network Connection")
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func upCmgBtn(_ sender: Any) {
        let nxtPage = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "UpComingViewController") as? UpComingViewController
        self.navigationController?.pushViewController(nxtPage!, animated: true)
    }
    
    @IBAction func topRtdBtn(_ sender: Any) {
        
        let nxtPage = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "TopRatedViewController") as? TopRatedViewController
        self.navigationController?.pushViewController(nxtPage!, animated: false)
        
    }
    
    
    
    func TopRatedAPicall(){
        
        Services.sharedInstance.loader(view: self.view)
        
        let contactsCell = "https://api.themoviedb.org/3/movie/top_rated?api_key=428002360992c58776bfb7c50738d5c8"
        let imgurl = "https://image.tmdb.org/t/p/w500"
        let urlString = contactsCell.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        print(contactsCell)
        
        
        
        Alamofire.request(urlString!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { [self] response in
            
            
            if response.response?.statusCode == 200 {
                let responseData = response.result.value   as? [String: AnyObject]
                // print(responseData)
                
                self.TPApiData = responseData
                Services.sharedInstance.dissMissLoader()
                
                self.TPmovieApiData = TPApiData["results"] as? [[String:Any]]
                
                
                for  each in self.TPmovieApiData {
                    
                    let poster_path = each["poster_path"] as? String
                    
                    
                    let img = String(format: "%@%@", imgurl,poster_path!)
                    self.TPimgArr.append(img)
                    
                }
                
                DispatchQueue.main.async {
                    
                    self.topRatedCV.reloadData()
                }
            } else {
                
                if let responseData = response.result.value   as? [String: Any] {
                    
                    if let message_ = responseData["message"] {
                        print("reqmess \(message_)")
                    }
                    else {
                        print("No error message from server")                                                                
                    }
                }
                
                Services.sharedInstance.dissMissLoader()
                
            }}
        
    }
    
    func UpCommingAPicall(){
        Services.sharedInstance.loader(view: self.view)
        
        
        let contactsCell = "https://api.themoviedb.org/3/movie/upcoming?api_key=428002360992c58776bfb7c50738d5c8"
        let imgurl = "https://image.tmdb.org/t/p/w500"
        let urlString = contactsCell.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        print(contactsCell)
        
        
        
        Alamofire.request(urlString!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { [self] response in
            
            
            if response.response?.statusCode == 200 {
                let responseData = response.result.value   as? [String: AnyObject]
                // print(responseData)
                
                self.ApiData = responseData
                Services.sharedInstance.dissMissLoader()
                
                self.movieApiData = ApiData["results"] as? [[String:Any]]
                
                
                for  each in self.movieApiData {
                    
                    let poster_path = each["poster_path"] as? String
                    
                    
                    let img = String(format: "%@%@", imgurl,poster_path!)
                    self.imgArr.append(img)
                    
                }
                
                DispatchQueue.main.async {
                    
                    self.upCmgCV.reloadData()
                }
            } else {
                
                if let responseData = response.result.value   as? [String: Any] {
                    
                    if let message_ = responseData["message"] {
                        print("reqmess \(message_)")
                    }
                    else {
                        print("No error message from server")
                        
                        
                    }
                }
                Services.sharedInstance.dissMissLoader()
                
            }}}
    
    
    @IBAction func backBtn(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: false)
    }
    
    
}


extension HomePage:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == topRatedCV {
            return TPimgArr.count
        } else {
            return imgArr.count
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == topRatedCV {
            let cell = topRatedCV.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell1", for: indexPath) as? HomeCollectionViewCell1
            
            cell?.topCmgBackView.layer.cornerRadius = 10
            cell?.topCmgBackView.clipsToBounds = true
            
            cell?.topCmgImg.sd_setImage(with: URL(string: TPimgArr[indexPath.row]))
            
            
            return cell!
        } else {
            let cell = upCmgCV.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as? HomeCollectionViewCell
            
            cell?.upCmgBackView.layer.cornerRadius = 10
            cell?.upCmgBackView.clipsToBounds = true
            cell?.upCmgImg.sd_setImage(with: URL(string: imgArr[indexPath.row]))
            
            
            return cell!
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == topRatedCV {
            let size = (topRatedCV.frame.size.width - 5) / 3
            return CGSize(width: size, height: 100)

          //  return CGSize(width: self.topRatedCV.frame.size.width/3, height: 100)
        } else {
            let size = (upCmgCV.frame.size.width - 5) / 3
            return CGSize(width: size, height: 100)

           // return CGSize(width: self.upCmgCV.frame.size.width/3, height: 100)
        } }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == topRatedCV {
            let nxtPage = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "TopRatedViewController") as? TopRatedViewController
            self.navigationController?.pushViewController(nxtPage!, animated: false)
            
        } else {
            let nxtPage = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "UpComingViewController") as? UpComingViewController
            self.navigationController?.pushViewController(nxtPage!, animated: false)
        }
    }
    
}
