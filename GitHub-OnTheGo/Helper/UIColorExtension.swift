//
//  UIColorExtension.swift
//  GitHub-OnTheGo
//
//  Created by mitul jindal on 12/11/17.
//  Copyright © 2017 mitul jindal. All rights reserved.
//

import UIKit

extension UIColor {
//    Custom color
    static var github = UIColor(red: 37/255, green: 41/255, blue: 46/255, alpha: 1)
}

extension UIImageView {
    
    func downloadImageFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
        }.resume()
    }
}
