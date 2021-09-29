//
//  TabBarViewController.swift
//  leBaluchon
//
//  Created by Christophe Expleo on 27/09/2021.
//

import UIKit

class TabBarViewController: UITabBarController {

    // MARK: - IBOutlet
    @IBOutlet weak var appTabBar: UITabBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        let appearance = appTabBar.standardAppearance
                appearance.stackedLayoutAppearance.normal.iconColor = UIColor(named: "unselectedIconTabBar")
                appearance.stackedLayoutAppearance.selected.iconColor = UIColor(named: "selectedIconTabBar")
    }
}
