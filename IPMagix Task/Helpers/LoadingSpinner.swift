//
//  LoadingSpinner.swift
//  IPMagix Task
//
//  Created by Mohamed Samy on 5/30/21.
//

import UIKit
import NVActivityIndicatorView

let windowView = UIApplication.shared.keyWindow?.rootViewController?.view

let activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: (UIApplication.shared.keyWindow?.rootViewController?.view.frame.midX ?? 0) - 50 / 2, y: (UIApplication.shared.keyWindow?.rootViewController?.view.frame.midY ?? 0) - 50 / 2, width: 50, height: 50), color: UIColor.lightGray)

let dimmedView = UIView(frame: UIApplication.shared.keyWindow?.rootViewController?.view.frame ?? CGRect())

extension UIViewController {
   func showLoader() {
    self.navigationController?.setNavigationBarHidden(true, animated: true)
    self.tabBarController?.tabBar.isHidden = true
        view.isUserInteractionEnabled = false
    let dimmedView = UIView(frame: CGRect(origin: CGPoint(x: UIScreen.main.bounds.origin.x, y: UIScreen.main.bounds.origin.x), size: CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)))
        dimmedView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        let activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: view.frame.midX - 50 / 2, y: view.frame.midY - 50 / 2, width: 50, height: 50), color: UIColor.black.withAlphaComponent(0.6))
        dimmedView.addSubview(activityIndicatorView)
        view.addSubview(dimmedView)
        activityIndicatorView.startAnimating()
    }
    func hideLoader() {
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        view.isUserInteractionEnabled = true
        let v = view.subviews.last
        v?.removeFromSuperview()
    }
}
