//
//  ViewController.swift
//  YYApi_Voyo
//
//  Created by Stas Bezhan on 01.10.2022.
//

import UIKit

class MainView: UIViewController {
    
    @IBOutlet weak var lowerCollectionView: UICollectionView!
    @IBOutlet weak var upperCollectionView: UICollectionView!
    @IBOutlet weak var channelsPages: UIView!
    @IBOutlet weak var topPlaylistName: UILabel!
    @IBOutlet weak var botPlaylistName: UILabel!
    
    private var viewModel = MainViewModel()
    private var playerViewController: PlayerVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlayer()
        setUpCollections()
    }
    
    private func setUpCollections() {
        lowerCollectionView.delegate = self
        lowerCollectionView.dataSource = self
        upperCollectionView.delegate = self
        upperCollectionView.dataSource = self
        
        lowerCollectionView.register(UINib(nibName: Constants.botPlaylistCell, bundle: nil), forCellWithReuseIdentifier: Constants.botPlaylistCell)
        upperCollectionView.register(UINib(nibName: Constants.topPlayilistCell, bundle: nil), forCellWithReuseIdentifier: Constants.topPlayilistCell)
    }
    
}

//MARK: - CollectionViews
extension MainView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == upperCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.topPlayilistCell, for: indexPath) as? TopPlaylistCell else { return UICollectionViewCell() }
            cell.videoImage.image = .add
            return cell
        } else if collectionView == lowerCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.botPlaylistCell, for: indexPath) as? BotPlaylistCell else { return UICollectionViewCell() }
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        playerViewController?.setPlayer(url: "NIOMtSzfpck")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

//MARK: - PlayerView Methods and Properties
extension MainView {
    
    //Setting up PlayerView
    private func setupPlayer() {
        viewModel.visualEffectView = UIVisualEffectView()
        viewModel.visualEffectView?.frame = self.view.frame
        playerViewController = PlayerVC(nibName: "PlayerVC", bundle: nil)
        self.addChild(playerViewController!)
        self.view.addSubview(playerViewController!.view)
        
        playerViewController?.view.frame = CGRect(x: 0, y: self.view.frame.height - viewModel.playerHandleArea, width: self.view.bounds.width, height: viewModel.playerHeight)
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
            guard playerViewController != nil else { return }
            animateIfNeeded(state: viewModel.nextState, duration: 1)
        default:
            break
        }
    }
    
    @objc
    private func handlePlayerPan(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            startInterctiveTransition(state: viewModel.nextState, duration: 1)
        case .changed:
            let translation = recognizer.translation(in: self.playerViewController?.handleArea)
            var fractionComplete = translation.y / viewModel.playerHeight
            fractionComplete = viewModel.playerVisible ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            continueInteractiveTransition()
        default:
            break
        }
    }
    
    private func animateIfNeeded(state: MainViewModel.PlayerCurrentState, duration: TimeInterval) {
        if viewModel.runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) { [weak self] in
                guard let strongSelf = self else { return }
                switch state {
                case .expanded:
                    self?.playerViewController?.view.frame.origin.y = strongSelf.view.frame.height  - strongSelf.viewModel.playerHeight
                case .collapse:
                    self?.playerViewController?.view.frame.origin.y = strongSelf.view.frame.height - strongSelf.viewModel.playerHandleArea
                }
            }
            frameAnimator.addCompletion { [weak self] _ in
                self?.viewModel.playerVisible = !(self?.viewModel.playerVisible ?? false)
                self?.viewModel.runningAnimations.removeAll()
            }
            
            frameAnimator.startAnimation()
            viewModel.runningAnimations.append(frameAnimator)
            
            let arrowAnimation = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) { [weak self] in
                switch state {
                case .expanded:
                    self?.playerViewController?.arrow.setImage(UIImage(systemName: "chevron.down"), animated: true)
                case .collapse:
                    self?.playerViewController?.arrow.setImage(UIImage(systemName: "chevron.up"), animated: true)
                }
            }
            arrowAnimation.startAnimation()
            viewModel.runningAnimations.append(arrowAnimation)
        }
    }
    
    private func startInterctiveTransition(state: MainViewModel.PlayerCurrentState, duration: TimeInterval) {
        if viewModel.runningAnimations.isEmpty {
            //run animations
            animateIfNeeded(state: state, duration: duration)
        }
        for animator in viewModel.runningAnimations {
            animator.pauseAnimation()
            viewModel.progressOfAnimation = animator.fractionComplete
        }
    }
    
    private func updateInteractiveTransition(fractionCompleted: CGFloat) {
        for animator in viewModel.runningAnimations {
            animator.fractionComplete = fractionCompleted + viewModel.progressOfAnimation
        }
    }
    
    private func continueInteractiveTransition() {
        for animator in viewModel.runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
    
}
