//
//  PlayerVC.swift
//  YYApi_Voyo
//
//  Created by Stas Bezhan on 01.10.2022.
//

import UIKit
import YoutubeKit

class PlayerVC: UIViewController {
    
    private var player: YTSwiftyPlayer?
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
    
    @IBOutlet weak var arrow: UIImageView!
    @IBOutlet weak var handleArea: UIView!
    @IBOutlet var gradientView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradient.frame = gradientView.bounds
        gradient.cornerRadius = 20
        gradientView.layer.addSublayer(gradient)
        setPlayer(url: "bsM1qdGAVbU")
    }
    
    func setPlayer(url: String) {
        self.player = YTSwiftyPlayer(frame: CGRect(x: 0, y: 65, width: 390, height: 300),
                                     playerVars: [VideoEmbedParameter.playsInline(true),
                                                  .loopVideo(true),
                                                  .videoID(url),
                                                  .showRelatedVideo(true)])
        self.player?.autoplay = false
        self.view.addSubview(self.player!)
        self.player?.loadDefaultPlayer()
    }
}

extension PlayerVC: YTSwiftyPlayerDelegate {
    
}
