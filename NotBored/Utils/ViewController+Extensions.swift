//
//  ViewController+Extensions.swift
//  NotBored
//
//  Created by Jorge Andres Restrepo Gutierrez on 8/06/22.
//

import UIKit

//MARK: - Spinner View
fileprivate var aView: UIView?

extension UIViewController {
    
    func showSpinner() {
        aView = UIView(frame: self.view.bounds)
        aView?.backgroundColor = UIColor.white
        
        let ai = UIActivityIndicatorView(style: .large)
        ai.color = nBColors.titleColor
        ai.center = aView!.center
        ai.startAnimating()
        aView?.addSubview(ai)
        self.view.addSubview(aView!)
    }
    
    func removeSpinner() {
        aView?.removeFromSuperview()
        aView = nil
    }
}
