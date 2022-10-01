//
//  ViewController.swift
//  YYApi_Voyo
//
//  Created by Stas Bezhan on 01.10.2022.
//

import UIKit

class MainView: UIViewController {
    
    @IBOutlet weak var channelsPages: UIView!
    
    private var playerViewController: PlayerVC?
    private let playerHeight: CGFloat = 700
    private let playerHandleArea: CGFloat = 60
    private var playerVisible = false
    private var runningAnimations = [UIViewPropertyAnimator]()
    private var progressOfAnimation: CGFloat = 0
    private var visualEffectView: UIVisualEffectView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlayer()
    }
    
    
}


//PlayerView Methods and Properties
extension MainView {
    
    enum PlayerCurrentState {
        case expanded
        case collapse
    }

    private var nextState: PlayerCurrentState {
        return playerVisible ? .collapse : .expanded
    }
    
    
    //Setting up PlayerView
    private func setupPlayer() {
        visualEffectView = UIVisualEffectView()
        visualEffectView?.frame = self.view.frame
        playerViewController = PlayerVC(nibName: "PlayerVC", bundle: nil)
        self.addChild(playerViewController!)
        self.view.addSubview(playerViewController!.view)
        
        playerViewController?.view.frame = CGRect(x: 0, y: self.view.frame.height - playerHandleArea, width: self.view.bounds.width, height: playerHeight)
        playerViewController?.view.clipsToBounds = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapToOpenPlayer(_:)))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePlayerPan(_:)))
        playerViewController?.handleArea.addGestureRecognizer(tapGestureRecognizer)
        playerViewController?.handleArea.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc
    private func handleTapToOpenPlayer(_ recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            animateIfNeeded(state: nextState, duration: 1)
        default:
            break
        }
    }
    
    @objc
    private func handlePlayerPan(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            startInterctiveTransition(state: nextState, duration: 1)
        case .changed:
            let translation = recognizer.translation(in: self.playerViewController?.handleArea)
            var fractionComplete = translation.y / playerHeight
            fractionComplete = playerVisible ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            continueInteractiveTransition()
        default:
            break
        }
    }
    
    //Handlers for animations
    private func animateIfNeeded(state: PlayerCurrentState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) { [weak self] in
                guard let strongSelf = self else { return }
                switch state {
                case .expanded:
                    strongSelf.playerViewController?.view.frame.origin.y = strongSelf.view.frame.height  - strongSelf.playerHeight
                case .collapse:
                    strongSelf.playerViewController?.view.frame.origin.y = strongSelf.view.frame.height - strongSelf.playerHandleArea
                }
            }
            frameAnimator.addCompletion { [weak self] _ in
                self?.playerVisible = !(self?.playerVisible ?? false)
                self?.runningAnimations.removeAll()
            }
            
            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)
            
            let arrowAnimation = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
                switch state {
                case .expanded:
                    self.playerViewController?.arrow.setImage(UIImage(systemName: "chevron.down"), animated: true)
                case .collapse:
                    self.playerViewController?.arrow.setImage(UIImage(systemName: "chevron.up"), animated: true)
                }
            }
            arrowAnimation.startAnimation()
            runningAnimations.append(arrowAnimation)
        }
    }
    
    private func startInterctiveTransition(state: PlayerCurrentState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            //run animations
            animateIfNeeded(state: state, duration: duration)
        }
        for animator in runningAnimations {
            animator.pauseAnimation()
            progressOfAnimation = animator.fractionComplete
        }
    }
    
    private func updateInteractiveTransition(fractionCompleted: CGFloat) {
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + progressOfAnimation
        }
    }
    
    private func continueInteractiveTransition() {
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
    
}
