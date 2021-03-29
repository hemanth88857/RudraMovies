//
//  ServiceExtensions.swift
//  RudraMovies
//
//  Created by hemanth on 29/03/21.
//

import Foundation


import UIKit
import Alamofire
import SystemConfiguration


public class Reachability {
    
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    
}




class Services : NSObject {
    
    static let sharedInstance = Services()
    
    //signUp getperamters
    var _name: String!
    var _email: String!
    var _mobileNumber: String!
    var _message: String!
    
    var errMessage: String!
    let imageV = UIImageView()
    let indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    
    func loader(view: UIView) -> () {
        
        indicator.frame = CGRect(x: 0,y: 0,width: 75,height: 75)
        indicator.layer.cornerRadius = 8
        indicator.center = view.center
        
        indicator.color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.addSubview(indicator)
        indicator.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        indicator.bringSubviewToFront(view)
        
        indicator.startAnimating()
        
        view.isUserInteractionEnabled = true
        
    }
    
    func dissMissLoader()  {
        
        indicator.stopAnimating()
        imageV.removeFromSuperview()
        
    }
    
    
    
}



extension UIView {
    func fadeIn(_ duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)  }
    
    func fadeOut(_ duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }
}




extension Formatter {
    static let decimal: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = .current
        numberFormatter.maximumFractionDigits = 2 // your choice
        numberFormatter.maximumIntegerDigits = 6 // your choice
        return numberFormatter
    }()
}
extension FloatingPoint {
    var afficherUnFloat: String { Formatter.decimal.string(for: self) ?? "" }
}
