//
//  HomePage2ViewController.swift
//  RudraMovies
//
//  Created by hemanth on 28/03/21.
//

import UIKit
import Alamofire
import SDWebImage

class HomePage2ViewController: UIViewController {
    
    
    
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
    
    
    struct  GetmoviesData1 : Encodable {
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
    
    @IBOutlet weak var upCmgTV: UITableView!
    @IBOutlet weak var topRatedTV: UITableView!    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var View1: UIView!
    @IBOutlet weak var View2: UIView!
    @IBOutlet weak var upCmgView: UIView!
    @IBOutlet weak var topRatedView: UIView!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    
    
    var ApiData : [String : Any]!
    var movieApiData :[[String:Any]]!
    var moviesData = [GetmoviesData]()
    var imgArr = [String]()
    
    var TPApiData : [String : Any]!
    var TPmovieApiData :[[String:Any]]!
    var TpmoviesData = [GetmoviesData1]()
    var TPimgArr = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.HeightConstraints()
        self.Outlets()
        
        upCmgTV.delegate = self
        upCmgTV.dataSource = self
        
        topRatedTV.delegate = self
        topRatedTV.dataSource = self
        
        if Reachability.isConnectedToNetwork() {
            self.TopRatedAPicall()
            self.UpCommingAPicall()
            
        } else {
            
            print("Check Network Connection")
            
            
        }
        
    }
    
    func HeightConstraints(){
        DispatchQueue.main.async {
            
            let bounds = UIScreen.main.bounds
            let height = bounds.size.height
            
            if height == 667.0 || height == 736.0 || height == 667
            {
                self.topViewHeight.constant = 110
            }else if height >= 780.0
            {
                self.topViewHeight.constant = 130
            }
            else
            {
                self.topViewHeight.constant = 110
            }
        }
    }
    func Outlets(){
        self.topRatedView.isHidden = true
        self.topRatedTV.isHidden = true
        
        self.mainView.layer.cornerRadius = 25
        self.mainView.clipsToBounds      = true
        
        self.View1.layer.cornerRadius = 25
        self.View1.clipsToBounds = true
        self.View1.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.5843137255, blue: 0.1490196078, alpha: 1)
        self.View2.layer.cornerRadius = 25
        self.View2.clipsToBounds = true
        self.View2.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func upCmgBtn(_ sender: Any) {
        self.topRatedView.isHidden = true
        self.topRatedTV.isHidden = true
        
        self.upCmgView.isHidden = false
        self.upCmgTV.isHidden = false
        
        self.View1.layer.cornerRadius = 25
        self.View1.clipsToBounds = true
        self.View1.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.5843137255, blue: 0.1490196078, alpha: 1)
        
        self.View2.layer.cornerRadius = 25
        self.View2.clipsToBounds = true
        self.View2.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        
        
        self.upCmgTV.reloadData()
        self.topRatedTV.reloadData()
        
        
    }
    
    @IBAction func topRtdBtn(_ sender: Any) {
        self.upCmgView.isHidden = true
        self.upCmgTV.isHidden = true
        self.topRatedView.isHidden = false
        self.topRatedTV.isHidden = false
        self.View2.layer.cornerRadius = 25
        self.View2.clipsToBounds = true
        self.View2.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.5843137255, blue: 0.1490196078, alpha: 1)
        
        self.View1.layer.cornerRadius = 25
        self.View1.clipsToBounds = true
        self.View1.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        self.upCmgTV.reloadData()
        self.topRatedTV.reloadData()
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
                    
                    self.upCmgTV.reloadData()
                    
                    
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
                    
                    self.TPimgArr.append(img)
                    
                    
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
                    
                    
                    
                    
                    self.TpmoviesData.append(GetmoviesData1(popularity: popularity, overview: overview!, poster_path: poster_path!, release_date: release_date!, title: title!, vote_average: voteCount,vote_count: vote_count,backdrop_path:backDropimg,original_language:original_language!))
                    
                }
                
                DispatchQueue.main.async {
                    
                    self.topRatedTV.reloadData()
                    
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





extension HomePage2ViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == topRatedTV {
            return TPimgArr.count
        } else {
            return imgArr.count
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == topRatedTV {
            
            let cell = topRatedTV.dequeueReusableCell(withIdentifier: "TableViewCell2", for: indexPath) as? TableViewCell2
            
            cell?.backView.layer.cornerRadius = 20
            cell?.backView.clipsToBounds = true
            
            cell?.movieImg.layer.cornerRadius = 20
            cell?.movieImg.clipsToBounds = true
            
            
            
            
            cell?.movieImg.sd_setImage(with: URL(string: TPimgArr[indexPath.row]))
            cell?.movieVotes.text = TpmoviesData[indexPath.row].vote_count
            cell?.movieName.text =  TpmoviesData[indexPath.row].title
            cell?.movieRelease.text =  TpmoviesData[indexPath.row].popularity
            
            
            
            return cell!
            
        } else {
            
            
            
            
            
            let cell = upCmgTV.dequeueReusableCell(withIdentifier: "TableViewCell1", for: indexPath) as? TableViewCell1
            
            cell?.backView.layer.cornerRadius = 20
            cell?.backView.clipsToBounds = true
            
            cell?.movieImg.layer.cornerRadius = 20
            cell?.movieImg.clipsToBounds = true
            
            cell?.movieImg.sd_setImage(with: URL(string: imgArr[indexPath.row]))
            cell?.movieVotes.text = moviesData[indexPath.row].vote_count
            cell?.movieName.text =  moviesData[indexPath.row].title
            cell?.movieRelease.text =  moviesData[indexPath.row].release_date
            
            return cell!
            
        }}
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == topRatedTV {
            let nxtPage = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "MovieDetailsViewController") as? MovieDetailsViewController
            
            nxtPage?.popularity = TpmoviesData[indexPath.row].popularity
            nxtPage?.backdrop_path = TpmoviesData[indexPath.row].backdrop_path
            nxtPage?.overview = TpmoviesData[indexPath.row].overview
            nxtPage?.release_date = TpmoviesData[indexPath.row].release_date
            nxtPage?.movieTitle = TpmoviesData[indexPath.row].title
            nxtPage?.vote_average = TpmoviesData[indexPath.row].vote_average
            nxtPage?.vote_count = TpmoviesData[indexPath.row].vote_count
            nxtPage?.orginal_lang = TpmoviesData[indexPath.row].original_language
            
            nxtPage?.id = "2"
            self.navigationController?.pushViewController(nxtPage!, animated: false)
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
        }
    }
    
}
