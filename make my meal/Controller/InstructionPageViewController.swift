//
//  InstructionPageViewController.swift
//  make my meal
//
//  Created by Insub Lim on 5/6/19.
//  Copyright © 2019 Insub Lim. All rights reserved.
//

import UIKit

class InstructionPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    //Lazy variable allows it to only be created if it is called upon. Allows for saving processing time.
    lazy var viewControllerList: [UIViewController] = {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        //Our 3 view controllers involved in the page view scrolling feature.
        let scanInstructionsViewController = storyBoard.instantiateViewController(withIdentifier: "ScanInstructions")
        let listInstructionsViewController = storyBoard.instantiateViewController(withIdentifier: "ListIntructions")
        let recipeInstructionsViewController = storyBoard.instantiateViewController(withIdentifier: "RecipeIntructions")
        
        //Add them into our view controller list to be used to move between the view controllers.
        return [scanInstructionsViewController, listInstructionsViewController, recipeInstructionsViewController]
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        
        if let firstViewController = viewControllerList.first {
            //Show the first view controller that the user should see.
            self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        // Do any additional setup after loading the view.
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        //Make sure there is a viewController in the view controller list we can use
        guard let viewControllerIndex = viewControllerList.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        //Make sure we are not going past the array bounds
        guard previousIndex >= 0 else {
            return nil
        }
        
        //Make sure we are not going over array bounds
        guard viewControllerList.count > previousIndex else {
            return nil
        }
        
        //Return the previous view controller we are going back to
        return viewControllerList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        //Make sure there is a viewController in the view controller list we can use
        guard let viewControllerIndex = viewControllerList.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        //Make sure we are not going past array bounds
        guard viewControllerList.count != nextIndex else {
            return nil
        }
        
        guard viewControllerList.count > nextIndex else {
            return nil
        }
        
        //Return next view controller in line
        return viewControllerList[nextIndex]
    }
}
