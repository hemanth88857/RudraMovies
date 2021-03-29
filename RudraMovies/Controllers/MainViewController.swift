//
//  MainViewController.swift
//  RudraMovies
//
//  Created by hemanth on 28/03/21.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true

        
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }

    @IBAction func homeBtn1(_ sender: Any) {
        
  
        let nxtPage = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "HomePage2ViewController") as? HomePage2ViewController
        self.navigationController?.pushViewController(nxtPage!, animated: true)
    }
    

    @IBAction func homeBtn2(_ sender: Any) {
        let nxtPage = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "HomePage") as? HomePage
        self.navigationController?.pushViewController(nxtPage!, animated: true)
    }
}
