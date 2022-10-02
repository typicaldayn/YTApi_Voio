//
//  MainViewModel.swift
//  YYApi_Voyo
//
//  Created by Stas Bezhan on 01.10.2022.
//

import UIKit

class MainViewModel {
    
    enum PlayerCurrentState {
        case expanded
        case collapse
    }
    
    var progressOfAnimation: CGFloat = 0
    let playerHandleArea: CGFloat = 60
    let playerHeight: CGFloat = 700
    var playerVisible = false
    var nextState: PlayerCurrentState {
        return playerVisible ? .collapse : .expanded
    }
    var runningAnimations = [UIViewPropertyAnimator]()
    var visualEffectView: UIVisualEffectView?
   
}
