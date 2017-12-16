//
//  UIViewControllerExtensions.swift
//  iMMiConnect
//
//  Created by Pandiyaraj on 09/12/17.
//  Copyright © 2017 Pandiyaraj. All rights reserved.
//

import UIKit

public extension UIViewController {
	/// Assign as listener to notification.
	public func addNotificationObserver(name: Notification.Name, selector: Selector) {
		NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
	}
	
	/// Return true if ViewController is onscreen and not hidden.
	public var isVisible: Bool {
		// http://stackoverflow.com/questions/2777438/how-to-tell-if-uiviewcontrollers-view-is-visible
		return self.isViewLoaded && view.window != nil
	}
	
	/// Return navigationBar in a ViewController.
	public var navigationBar: UINavigationBar? {
		return navigationController?.navigationBar
	}
	
	/// Unassign as listener to notification.
	public func removeNotificationObserver(name: Notification.Name) {
		NotificationCenter.default.removeObserver(self, name: name, object: nil)
	}
	
	/// Unassign as listener from all notifications.
	public func removeNotificationsObserver() {
		NotificationCenter.default.removeObserver(self)
	}
    
    func showAlert(title: String, contentText: String, actions: [UIAlertAction]?) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: contentText, preferredStyle: .alert)
            
            if actions != nil{
                if let acctions = actions {
                    for action in acctions {
                        alertController.addAction(action)
                    }
                }
            }else{
                let okAlert : UIAlertAction = UIAlertAction.init(title: "Ok", style: .default, handler: nil)
                alertController.addAction(okAlert)
            }
           
            
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    public func loadingIndicator(show : Bool) -> Void {
        let tag = 9876
        if show {
            var rect: CGRect = self.view.frame
            rect.origin.y=0
            let subView = UIView(frame: rect)
            subView.backgroundColor = UIColor.black
            subView.tag = tag
            subView.alpha = 0.5
            
            //            let imageView = UIImageView()
            //            imageView.center = subView.center
            //            imageView.image = UIImage(named: "")
            //            subView.addSubview(imageView)
            //
            //            let contentLabel = UILabel()
            //            contentLabel.frame = CGRect(x: 35, y: imageView.frame.maxY, width: subView.frame.size.width - 70, height: 30)
            //            contentLabel.text = "Trade Executed. Good Luck!"
            //            contentLabel.textColor = UIColor.white
            //            contentLabel.textAlignment = .center
            //            subView.addSubview(contentLabel)
            //
            
            
            let indicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
            indicator.center = subView.center
            indicator.startAnimating()
            subView.addSubview(indicator)
            
            self.view.addSubview(subView)
            self.view.bringSubview(toFront: subView)
        } else {
            for view in self.view.subviews{
                if view.tag == tag {
                    view.removeFromSuperview()
                }
            }
        }
        
    }
}




extension UISplitViewController {
    
    /// Obtain the master/primary UIViewController.
    public var masterViewController: UIViewController {
        return viewControllers[0]
    }
    
    
    /// Obtain the detail/secondary UIViewController, if present.
    public var detailViewController: UIViewController? {
        guard viewControllers.count > 1 else { return nil }
        return viewControllers[1]
    }
    
}
