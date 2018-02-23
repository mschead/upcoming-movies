//
//  DownloadFromURL.swift
//  upcoming-movies
//
//  Created by Marcos Schead on 22/02/18.
//  Copyright © 2018 Marcos Schead. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {

    func downloadImageFrom(link: String, contentMode: UIViewContentMode) {
        URLSession.shared.dataTask( with: NSURL(string: link)! as URL, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                self.contentMode =  contentMode
                if let data = data { self.image = UIImage(data: data) }
            }
        }).resume()
    }

}

