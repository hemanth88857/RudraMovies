//
//  TableViewCell2.swift
//  RudraMovies
//
//  Created by hemanth on 29/03/21.
//

import UIKit

class TableViewCell2: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var movieImg: UIImageView!
    
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieRelease: UILabel!
    @IBOutlet weak var movieVotes: UILabel!

    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
