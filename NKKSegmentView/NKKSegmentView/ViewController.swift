//
//  ViewController.swift
//  NKKSegmentView
//
//  Created by Khanh Nguyen on 4/21/17.
//  Copyright © 2017 nkkhanh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var contentView: UIView!

    var segmentView : NKKSegmentView!
    var pageContentVC: PageViewController!
    var pageNameVCs = ["Page 1","Page 2","Page 3"]
    var pageIdVCs = ["page1VC","page2VC","page3VC"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    private func initUI(){
        let frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: UIScreen.main.bounds.size.width, height: 50))
        
        //Segment View
        segmentView = NKKSegmentView(frame: frame, tabs: pageNameVCs)
        segmentView.setSelectedTab(tabIndex: 0)
        segmentView.delegate = self
        contentView.addSubview(segmentView)
        
        let seperatorView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: UIScreen.main.bounds.size.width, height: 1)))
        seperatorView.backgroundColor = UIColor.init(rgb: 0xeeeeee)
        segmentView.addSubview(seperatorView)
        
        
        initPageVCs()
    }
    
    private func initPageVCs(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        pageContentVC = storyboard.instantiateViewController(withIdentifier: "pageVC") as! PageViewController
        let page1VC = storyboard.instantiateViewController(withIdentifier: "page1VC")
        pageContentVC.setViewControllers([page1VC], direction: .forward, animated: false, completion: nil)
        pageContentVC.view.frame = CGRect(x: 0, y: segmentView.frame.height, width: segmentView.frame.width, height: contentView.frame.height)
        pageContentVC.dataSource = self
        pageContentVC.delegate = self
        addChildViewController(pageContentVC)
        contentView.addSubview(pageContentVC.view)
        pageContentVC.didMove(toParentViewController: self)
    }
    


}


extension ViewController : NKKSegmentViewDelegate{
    func didSelectTabAtIndex(tabIndex: Int) {
        let nextVC = getItemController(itemIndex: tabIndex)
        if let page = pageContentVC {
            page.setViewControllers([nextVC!], direction: .forward, animated: false, completion: nil)
        }
    }
}

extension ViewController : UIPageViewControllerDataSource{
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let viewVC = viewController as! PageContentViewController
        let index = viewVC.pageIndex
        if index == 0 {
            return nil
        }
        let newIndex = index - 1
        return getItemController(itemIndex: newIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let viewVC = viewController as! PageContentViewController
        let index = viewVC.pageIndex
        if index == pageNameVCs.count - 1 {
            return nil
        }
        let newIndex = index + 1
        return getItemController(itemIndex: newIndex)
    }
    
    func getItemController(itemIndex: Int) -> PageContentViewController? {
        
        if itemIndex < pageIdVCs.count {
            let pageItemController = storyboard?.instantiateViewController(withIdentifier: pageIdVCs[itemIndex]) as! PageContentViewController
            pageItemController.pageIndex = itemIndex
            pageItemController.title = pageNameVCs[itemIndex]
            return pageItemController
        }
        
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pageIdVCs.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}

extension ViewController : UIPageViewControllerDelegate{
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if finished {
            let currentPage = pageViewController.viewControllers!.first as! PageContentViewController
            segmentView.setSelectedTab(tabIndex: currentPage.pageIndex)
        }
    }
}
