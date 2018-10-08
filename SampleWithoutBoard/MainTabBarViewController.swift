//
//  MainTabBarViewController.swift
//  SampleWithoutBoard
//
//  Created by 蒲生廣人 on 2018/08/26.
//  Copyright © 2018年 蒲生廣人. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let vc = Nav1ViewController()
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        let nv = UINavigationController(rootViewController: vc)
        
        let vc2 = Nav2ViewController()
        vc2.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 2)
        let nv2 = UINavigationController(rootViewController: vc2)
        
        setViewControllers([nv, nv2], animated: false)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
