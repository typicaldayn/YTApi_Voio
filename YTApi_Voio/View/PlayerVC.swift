//
//  PlayerVC.swift
//  YYApi_Voyo
//
//  Created by Stas Bezhan on 01.10.2022.
//

import UIKit
import YoutubeKit
import GradientViewExtension

class PlayerVC: UIViewController {
    
    private var player: YTSwiftyPlayer?
    
    @IBOutlet weak var arrow: UIImageView!
    @IBOutlet weak var handleArea: UIView!
    var result: ChannelListRequest.Response?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    func setPlayer(url: String) {
        self.player = YTSwiftyPlayer(frame: CGRect(x: 0, y: 65, width: view.frame.width, height: 300),
                                         playerVars: [VideoEmbedParameter.playsInline(true),
                                                      .loopVideo(true),
                                                      .videoID(url),
                                                      .showRelatedVideo(true)])
            self.player?.autoplay = false
            DispatchQueue.main.async {
                guard self.player != nil else { fatalError() }
                self.view.addSubview(self.player!)
                self.player?.loadDefaultPlayer()
        }
    }
    
    func setBackground() {
        self.view.layer.cornerRadius = 20
        var gradient = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        gradient.setGradientBackground(startColor: UIColor.purple, endColor: UIColor(red: 116 / 255, green: 18 / 255, blue: 232 / 255, alpha: 1))
        
        self.view.layer.addSublayer(gradient.layer)
    }
}

extension PlayerVC: YTSwiftyPlayerDelegate {
    
}
