//
//  MovieDetailsViewController.swift
//  RudraMovies
//
//  Created by hemanth on 28/03/21.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    var popularity = ""
    var overview = ""
    var backdrop_path = ""
    var release_date = ""
    var movieTitle = ""
    var vote_average = ""
    var vote_count = ""
    var orginal_lang = ""
    var id = ""
    
    
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var movieNameLbl: UILabel!
    @IBOutlet weak var releaseDateLbl: UILabel!
    @IBOutlet weak var movieratingLbl: UILabel!
    @IBOutlet weak var movieType: UILabel!
    @IBOutlet weak var movieViews: UILabel!
    @IBOutlet weak var movielang: UILabel!
    @IBOutlet weak var popularityLbl: UILabel!
    @IBOutlet weak var overviewText: UITextView!
    @IBOutlet weak var moviePoster: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.heightConstraints()
        if id == "1" {
            
            self.movieType.text = "Coming Soon"
        } else {
            self.movieType.text = "In Theater's"
        }
        
        if vote_average == ""
        {
            self.movieratingLbl.text = "In Review"
            
        } else {
            self.movieratingLbl.text = vote_average
            
        }
        
        
        
        backView.layer.cornerRadius = 20
        backView.clipsToBounds = true
        self.movieNameLbl.text = movieTitle
        self.releaseDateLbl.text = release_date
        self.overviewText.text = overview
        self.movielang.text = orginal_lang
        self.movieViews.text = vote_count
        self.popularityLbl.text = popularity
        
        
        moviePoster.sd_setImage(with: URL(string: backdrop_path))
        overviewText.isEditable = false
        
        
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
    
    
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    
}

