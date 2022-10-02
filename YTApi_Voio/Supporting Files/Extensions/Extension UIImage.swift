//
//  Extension UIImage.swift
//  YYApi_Voyo
//
//  Created by Stas Bezhan on 01.10.2022.
//

import Foundation
import UIKit

extension UIImageView {
    
    func setImage(_ image: UIImage?, animated: Bool = true) {
            let duration = animated ? 1 : 0.0
            UIView.transition(with: self, duration: duration, options: .curveEaseInOut, animations: {
                self.image = image
            }, completion: nil)
        }
}
