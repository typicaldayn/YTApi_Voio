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
    
    private var stopped = true
    private var player: YTSwiftyPlayer?
    var result: ChannelListRequest.Response?
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var videoViews: UILabel!
    @IBOutlet weak var videoLabel: UILabel!
    @IBOutlet weak var videoSlider: UISlider!
    @IBOutlet weak var loudnessSlider: UISlider!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var arrow: UIImageView!
    @IBOutlet weak var handleArea: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setPlayer(url: String) {
        self.player = YTSwiftyPlayer(frame: CGRect(x: 0, y: 65, width: view.frame.width, height: 300),
                                     playerVars: [VideoEmbedParameter.playsInline(true),
                                                  .loopVideo(false),
                                                  .videoID(url),
                                                  .showRelatedVideo(false)])
        let playerPath = Bundle(for: PlayerVC.self).path(forResource: "player", ofType: "html")!
        let htmlString = try! String(contentsOfFile: playerPath, encoding: .utf8)
        self.player?.autoplay = false
        guard self.player != nil else { fatalError() }
        self.view.addSubview(self.player!)
        self.player?.loadPlayerHTML(htmlString)
    }
    
    func setBackground() {
        self.view.layer.cornerRadius = 20
        gradientView.frame = self.view.bounds
        gradientView.setGradientBackground(startColor: UIColor.purple, endColor: UIColor(red: 116 / 255, green: 18 / 255, blue: 232 / 255, alpha: 1))
    }
    
    @IBAction func nextVideo(_ sender: UIButton) {
        
    }
    
    @IBAction func stopPlayer(_ sender: UIButton) {
        if stopped {
            player?.playVideo()
            stopped.toggle()
        } else {
            player?.stopVideo()
            stopped.toggle()
        }
    }
    
    @IBAction func previousVideo(_ sender: UIButton) {
        player?.nextVideo()
    }
}

extension PlayerVC: YTSwiftyPlayerDelegate {
    
    func playerReady(_ player: YTSwiftyPlayer) {
        print("READY")
    }
    
    func player(_ player: YTSwiftyPlayer, didUpdateCurrentTime currentTime: Double) {
        self.videoSlider.value = Float(currentTime)
    }
    
}

