//
//  PlayerVC.swift
//  YYApi_Voyo
//
//  Created by Stas Bezhan on 01.10.2022.
//

import UIKit

class PlayerVC: UIViewController {

    private lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [
            UIColor(red: 234 / 255, green: 65 / 255, blue: 140 / 255, alpha: 1).cgColor,
            UIColor(red: 156 / 255, green: 34 / 255, blue: 201 / 255, alpha: 1).cgColor,
            UIColor(red: 116 / 255, green: 18 / 255, blue: 232 / 255, alpha: 1).cgColor
        ]
        gradient.locations = [0, 0.5, 1]
        return gradient
    }()

    @IBOutlet var gradientView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gradient.frame = gradientView.bounds
        gradient.cornerRadius = 20
        gradientView.layer.addSublayer(gradient)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
