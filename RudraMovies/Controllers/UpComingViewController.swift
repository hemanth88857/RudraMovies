//
//  UpComingViewController.swift
//  RudraMovies
//
//  Created by hemanth on 27/03/21.
//

import UIKit
import Alamofire
import SDWebImage


class UpComingViewController: UIViewController,UIScrollViewDelegate {
    
    struct  GetmoviesData : Encodable {
        var popularity : String
        var overview : String
        var poster_path : String
        var backdrop_path : String
        var release_date : String
        var title : String
        var vote_average : String
        var vote_count : String
        var original_language: String
        
        
        
        
        
        init(popularity:String,overview : String,poster_path : String, release_date : String, title:String , vote_average:String , vote_count:String,backdrop_path:String,original_language:String)   {
            
            
            self.popularity = popularity
            self.overview = overview
            self.poster_path = poster_path
            self.release_date = release_date
            self.title = title
            self.vote_average = vote_average
            self.vote_count = vote_count
            self.backdrop_path = backdrop_path
            self.original_language = original_language
        } }
    
    var begin = false
    var x = 0
    
    var timer = Timer()
    var counter = 0
    
    @IBOutlet weak var pagingControl: UIPageControl!
    @IBOutlet weak var pagingCV: UICollectionView!
    @IBOutlet weak var upCmgCV: UICollectionView!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!

    var ApiData : [String : Any]!
    var movieApiData :[[String:Any]]!
    var moviesData = [GetmoviesData]()
    var imgArr = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.heightConstraints()
        if Reachability.isConnectedToNetwork() {
            self.UpCommingAPicall()
            
        } else {
            
            print("Check Network Connection")
            
            
        }
        
        
        upCmgCV.delegate = self
        upCmgCV.dataSource = self
        pagingCV.delegate = self
        pagingCV.dataSource = self
        
        pagingControl.hidesForSinglePage = true
        pagingControl.numberOfPages = imgArr.count
        pagingControl.currentPage = 0
        
        DispatchQueue.main.async {
            self.startTimer1()
        }
        
        
    }
    
    
    func heightConstraints(){
        DispatchQueue.main.async {
            
            let bounds = UIScreen.main.bounds
            let height = bounds.size.height
            
            if height == 667.0 || height == 736.0 || height == 667
            {
                self.topViewHeight.constant = 65
            }else if height >= 780.0
            {
                self.topViewHeight.constant = 85
            }
            else
            {
                self.topViewHeight.constant = 55
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func startTimer1() {
        
        Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true);
        
        
    }
    @objc func autoScroll() {
        
        if self.x < imgArr.count - 1 {
            self.x += 1
        } else {
            self.x = 0

        }
        self.pagingCV.scrollToItem(at: IndexPath(item: x, section: 0), at: .centeredHorizontally, animated: true)
        self.pagingControl.currentPage = x
        
        
    }
    
    
//    @objc func scrollToNextCell(){
//
//        let cellSize = CGSize(width: self.pagingCV.frame.width, height: self.pagingCV.frame.height);
//
//        let contentOffset = pagingCV.contentOffset
//
//        if begin == true
//        {
//
//            pagingCV.scrollRectToVisible(CGRect(), animated: true)
//            begin = false
//        }
//        else
//        {
//
//
//            pagingCV.scrollRectToVisible(CGRect(x: contentOffset.x + cellSize.width, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true);
//        }
//
//    }
    
    
//    func startTimer() {
//
//        Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(UpComingViewController.scrollToNextCell), userInfo: nil, repeats: true);
//
//
//    }
//
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//
//
//        pagingControl.currentPage = Int(floor((pagingCV.contentOffset.x / pagingCV.contentSize.width) * CGFloat(imgArr.count)))
//
//        if pagingCV.contentSize.width == pagingCV.contentOffset.x + self.view.frame.width
//        {
//            begin = true
//
//        }
//
//    }
//
//    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
//
//        scrollViewDidEndDecelerating(scrollView)
//
//    }
//
    
    
    
    
    
    @IBAction func backBtn(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: false)
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
                    let Floatpopularity = each["popularity"] as? Double
                    let overview = each["overview"] as? String
                    let poster_path = each["poster_path"] as? String
                    let backdrop_path = each["backdrop_path"] as? String
                    let release_date = each["release_date"] as? String
                    let title = each["title"] as? String
                    let original_language = each["original_language"] as? String
                    let Intvote_count = each["vote_count"] as? Int
                    
                    let vote_count = String(format: "%d", Intvote_count!)
                    
                    let img = String(format: "%@%@", imgurl,poster_path!)
                    let backDropimg = String(format: "%@%@", imgurl,backdrop_path!)
                    
                    self.imgArr.append(img)
                    
                    
                    let vote_average = each["vote_average"] as? Float
                    
                    var popularity = ""
                    if  Floatpopularity == nil {
                        popularity = ""
                        
                        
                    } else {
                        
                        popularity = Floatpopularity!.afficherUnFloat
                    }
                    
                    var voteCount = ""
                    
                    if  vote_average == nil {
                        voteCount = ""
                        
                        
                    } else {
                        voteCount = vote_average!.afficherUnFloat
                        
                    }
                    
                    self.moviesData.append(GetmoviesData(popularity: popularity, overview: overview!, poster_path: poster_path!, release_date: release_date!, title: title!, vote_average: voteCount,vote_count: vote_count,backdrop_path:backDropimg,original_language:original_language!))
                    
                }
                
                DispatchQueue.main.async {
                    
                    self.upCmgCV.reloadData()
                    
                    self.pagingCV.reloadData()
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
                
            }}}}


extension UpComingViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == pagingCV {
            pagingControl.numberOfPages = imgArr.count
            
            return imgArr.count
            
        } else {
            return imgArr.count
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == pagingCV {
            let cell = pagingCV.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell1", for: indexPath) as? HomeCollectionViewCell1
            
            
            cell?.pagingImg.sd_setImage(with: URL(string: imgArr[indexPath.row]))
            
            
            
            
            return cell!
            
        } else {
            let cell = upCmgCV.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as? HomeCollectionViewCell
            
            cell?.upCmgBackViewCmplt.layer.cornerRadius = 10
            cell?.upCmgBackViewCmplt.clipsToBounds = true
            
            cell?.upCmgImgCmplt.sd_setImage(with: URL(string: imgArr[indexPath.row]))
            
            cell?.movieVotes.text = moviesData[indexPath.row].vote_count
            cell?.movieName.text = moviesData[indexPath.row].title
            
            return cell!
        }
        
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == pagingCV {
           // let size = (pagingCV.frame.size.width - 10) / 1
           // return CGSize(width: size, height: size)

            return CGSize(width: self.pagingCV.frame.width-2/5, height: 170)
            
        } else {
            let size = (upCmgCV.frame.size.width - 10) / 2
            return CGSize(width: size, height: 240)

            //return CGSize(width: self.upCmgCV.frame.width-3/5, height: 240)
            
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == pagingCV {
            
        } else {
            
            
            
            let nxtPage = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "MovieDetailsViewController") as? MovieDetailsViewController
            
            nxtPage?.popularity = moviesData[indexPath.row].popularity
            nxtPage?.backdrop_path = moviesData[indexPath.row].backdrop_path
            nxtPage?.overview = moviesData[indexPath.row].overview
            nxtPage?.release_date = moviesData[indexPath.row].release_date
            nxtPage?.movieTitle = moviesData[indexPath.row].title
            nxtPage?.vote_average = moviesData[indexPath.row].vote_average
            nxtPage?.vote_count = moviesData[indexPath.row].vote_count
            nxtPage?.orginal_lang = moviesData[indexPath.row].original_language
            
            nxtPage?.id = "1"
            
            self.navigationController?.pushViewController(nxtPage!, animated: false)
            
            
        } }
    
    
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        if collectionView == pagingCV {
//            return 0
//
//
//        } else {
//            return 10
//
//        }
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
//    }
//
    
    
}


