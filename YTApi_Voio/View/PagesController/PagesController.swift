//
//  PagesController.swift
//  YYApi_Voyo
//
//  Created by Stas Bezhan on 01.10.2022.
//

import UIKit

class PagesController: UIPageViewController {
    
    private var pages = [UIViewController]()
    private var pageControl = UIPageControl()
    private let initialPage = 0
    private var currentPage = 0
    private var timer: Timer?
    private var manager: NetworkingManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPagesController()
        style()
        layout()
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(changeSlide), userInfo: nil, repeats: true)
        selectPlaylist()
    }
    
    
    @objc private func changeSlide() {
        currentPage += 1
        if currentPage < pages.count {
            setViewControllers([pages[currentPage]], direction: .forward, animated: false)
        } else {
            currentPage = 0
            setViewControllers([pages[currentPage]], direction: .forward, animated: false)
        }
        pageControl.currentPage = currentPage
    }
    
    func selectPlaylist() {
        guard let pages = pages as? [Page] else { return }
        pages.forEach { page in
            page.view.setOnClickListener {
                print("CLICK")
            }
//            if page == FirstPageVC() {
//
//            }
        }
        
    }
    
}

extension PagesController {
    
    private func setupPagesController() {
        dataSource = self
        delegate = self
        
        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
        
        let firstPage = FirstPageVC()
        let secondPage = SecondPageVC()
        let thirdPage = ThirdPageVC()
        let fourthPage = FourthPageVC()
        
        pages.append(firstPage)
        pages.append(secondPage)
        pages.append(thirdPage)
        pages.append(fourthPage)
        
        setViewControllers([pages[initialPage]], direction: .forward, animated: false)
    }
    
    
    @objc private func pageControlTapped(_ sender: UIPageControl) {
        setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true)
    }
    
    private func style() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.pageIndicatorTintColor = .placeholderText
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
    }
    
    private func layout() {
        view.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: pageControl.bottomAnchor,
                                         multiplier: 1),
        ])
    }
    
}

//MARK: - DataSource Methods
extension PagesController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currentIndex == 0 {
            return pages.last
        } else {
            return pages[currentIndex - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]
        } else {
            return pages.first
        }
    }
}


//MARK: - Delegate Methods
extension PagesController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
        
        pageControl.currentPage = currentIndex
    }
    
}

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */

