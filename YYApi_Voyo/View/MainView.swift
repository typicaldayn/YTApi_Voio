//
//  ViewController.swift
//  YYApi_Voyo
//
//  Created by Stas Bezhan on 01.10.2022.
//

import UIKit

class MainView: UIViewController {

    enum CardState {
        case expanded
        case collapse
    }
    
    @IBOutlet weak var channelsPages: UIView!
    
    private var playerViewController: PlayerVC?
    
    private let playerHeight: CGFloat = 600
    let playerHandleArea: CGFloat = 65
    var cardVisible = false
    var nextState: CardState {
        return cardVisible ? .collapse : .expanded
    }
    var runningAnimations = [UIViewPropertyAnimator]()
    var progressOfAnimation: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlayer()
    }
    
    func setupPlayer() {
        playerViewController = PlayerVC(nibName: "PlayerVC", bundle: nil)
        self.addChild(playerViewController!)
        self.view.addSubview(playerViewController!.view)
        
        playerViewController?.view.frame = CGRect(x: 0, y: self.view.frame.height - playerHandleArea, width: self.view.bounds.width, height: playerHeight)
        playerViewController?.view.clipsToBounds = true
    }

}

