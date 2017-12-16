//
//  UIImageViewExtensions.swift
//  iMMiConnect
//
//  Created by Pandiyaraj on 09/12/17.
//  Copyright © 2017 Pandiyaraj. All rights reserved.
//

import UIKit

extension UIImageView {
	/// Download image from url and set it in imageView with an optional completionHandler.
	public func download(from: URL?,
	                     contentMode: UIViewContentMode = .scaleAspectFit,
	                     placeHolder: UIImage? = nil,
	                     completionHandler: ((UIImage?, Error?) -> Void)? = nil) {
		
		image = placeHolder
		
		guard let url = from else {
			return
		}
		
		self.contentMode = contentMode
		
		
		URLSession.shared.dataTask(with: url) { (data, response, error) in
			guard
				let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
				let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
				let data = data, error == nil,
				let image = UIImage(data: data)
				else {
					completionHandler?(nil, error)
					return
			}
			DispatchQueue.main.async() { () -> Void in
				self.image = image
				completionHandler?(image, nil)
			}
			}.resume()
	}
	
    /// Make image view blurry
	func blur(withStyle: UIBlurEffectStyle = .light) {
		let blurEffect = UIBlurEffect(style: withStyle)
		let blurEffectView = UIVisualEffectView(effect: blurEffect)
		blurEffectView.frame = self.bounds
		blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
		self.addSubview(blurEffectView)
		self.clipsToBounds = true
	}
	
	/// Return a blurred version of an image view
	func blurred(withStyle: UIBlurEffectStyle = .light) -> UIImageView {
		return self.blurred(withStyle: withStyle)
	}
	
}
