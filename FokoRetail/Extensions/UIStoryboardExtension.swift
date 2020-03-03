//
//  UIStoryboardExtension.swift
//  FokoRetail
//
//  Created by Rakesh Tripathi on 2020-02-27.
//  Copyright © 2020 Rakesh Tripathi. All rights reserved.
//

import UIKit

extension UIStoryboard {
  static func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: Bundle.main) }
  
  static func drawerMenuViewController() -> DrawerMenuViewController? {
    return mainStoryboard().instantiateViewController(withIdentifier: "DrawerMenuViewController") as? DrawerMenuViewController
  }
  
  static func centerViewController() -> CenterViewController? {
    return mainStoryboard().instantiateViewController(withIdentifier: "CenterViewController") as? CenterViewController
  }
}
