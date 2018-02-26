//
//  MovieContainerView.swift
//  upcoming-movies
//
//  Created by Marcos Schead on 26/02/18.
//  Copyright © 2018 Marcos Schead. All rights reserved.
//

import UIKit

class MovieContainerView: UIView {

    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = 3
        self.layer.shadowColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        self.layer.shadowRadius = 1.7
        self.layer.shadowOpacity = 0.45
    }

}
