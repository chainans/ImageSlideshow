//
//  AlamofireSource.swift
//  Pods
//
//  Created by Petr Zvoníček on 14.01.16.
//
//

import Alamofire
import AlamofireImage

public class AlamofireSource: NSObject, InputSource {
    public static var sharedManager = Alamofire.Manager.sharedInstance
    
    var url: NSURL!
    var sManager: Manager?
    
    public init(url: NSURL, sessionManager: Manager? = nil) {
        self.url = url
        sManager = sessionManager
        super.init()
    }

    public init?(urlString: String, sessionManager: Manager? = nil) {
        self.sManager = sessionManager
        if let validUrl = NSURL(string: urlString) {
            self.url = validUrl
            super.init()
        } else {
            super.init()
            return nil
        }
    }
    
    public func setToImageView(imageView: UIImageView) {
        if sManager == nil {
            sManager = AlamofireSource.sharedManager
        }
        
        sManager!.request(.GET, self.url)
            .responseImage { response in
                if let image = response.result.value {
                    imageView.image = image
                }
        }
    }
    
}
