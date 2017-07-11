//
//  ESTabBarController.swift
//
//  Created by Vincent Li on 2017/2/8.
//  Copyright (c) 2013-2016 ESTabBarController (https://github.com/eggswift/ESTabBarController)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit

/*
 * ESTabBarItem继承自UITabBarItem，目的是为ESTabBarItemContentView提供UITabBarItem属性的设置。
 * 目前支持大多常用的属性，例如image, selectedImage, title, tag 等。
 *
 * Unsupport properties:
 *  MARK: UIBarItem properties
 *      1. var isEnabled: Bool
 *      2. var landscapeImagePhone: UIImage?
 *      3. var imageInsets: UIEdgeInsets
 *      4.  var landscapeImagePhoneInsets: UIEdgeInsets
 *      5. func setTitleTextAttributes(_ attributes: [String : Any]?, for state: UIControlState)
 *      6. func titleTextAttributes(for state: UIControlState) -> [String : Any]?
 *  MARK: UITabBarItem properties
 *      7. var titlePositionAdjustment: UIOffset
 *      8. func setBadgeTextAttributes(_ textAttributes: [String : Any]?, for state: UIControlState)
 *      9. func badgeTextAttributes(for state: UIControlState) -> [String : Any]?
 */
@available(iOS 8.0, *)
open class ESTabBarItem: UITabBarItem {
    
    /// Customize content view
    open var contentView: ESTabBarItemContentView?
    
    // MARK: UIBarItem properties
    open override var title: String? // default is nil
        {
        didSet { self.contentView?.title = title }
    }
    
    open override var image: UIImage? // default is nil
        {
        didSet { self.contentView?.image = image }
    }
    
    // MARK: UITabBarItem properties
    open override var selectedImage: UIImage? // default is nil
        {
        didSet { self.contentView?.selectedImage = selectedImage }
    }
    
    open override var badgeValue: String? // default is nil
        {
        get { return contentView?.badgeValue }
        set(newValue) { contentView?.badgeValue = newValue }
    }
    
    /// Override UITabBarItem.badgeColor, make it available for iOS8.0 and later.
    /// If this item displays a badge, this color will be used for the badge's background. If set to nil, the default background color will be used instead.
    @available(iOS 8.0, *)
    open override var badgeColor: UIColor? {
        get { return contentView?.badgeColor }
        set(newValue) { contentView?.badgeColor = newValue }
    }
    
    open override var tag: Int // default is 0
        {
        didSet { self.contentView?.tag = tag }
    }
    
    /* The unselected image is autogenerated from the image argument. The selected image
     is autogenerated from the selectedImage if provided and the image argument otherwise.
     To prevent system coloring, provide images with UIImageRenderingModeAlwaysOriginal (see UIImage.h)
     */
    public init(_ contentView: ESTabBarItemContentView = ESTabBarItemContentView(), title: String? = nil, image: UIImage? = nil, selectedImage: UIImage? = nil, tag: Int = 0) {
        super.init()
        self.contentView = contentView
        self.setTitle(title, image: image, selectedImage: selectedImage, tag: tag)
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.contentView = ExampleHighlightableContentView()
        self.setTitle(nil, image: image, selectedImage: selectedImage, tag: tag)
    }
    
    open func setTitle(_ title: String? = nil, image: UIImage? = nil, selectedImage: UIImage? = nil, tag: Int = 0) {
        self.title = title
        self.image = image
        self.selectedImage = selectedImage
        self.tag = tag
    }
}

class ExampleBasicContentView: ESTabBarItemContentView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = UIColor.init(white: 175.0 / 255.0, alpha: 1.0)
        highlightTextColor = UIColor.init(red: 254/255.0, green: 73/255.0, blue: 42/255.0, alpha: 1.0)
        iconColor = UIColor.init(white: 175.0 / 255.0, alpha: 1.0)
        highlightIconColor = UIColor.init(red: 254/255.0, green: 73/255.0, blue: 42/255.0, alpha: 1.0)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

class ExampleBouncesContentView: ExampleBasicContentView {
    
    public var duration = 0.3
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textColor = UIColor.white
        highlightTextColor = UIColor.white
        iconColor = UIColor.white
        highlightIconColor = UIColor.white
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func selectAnimation(animated: Bool, completion: (() -> ())?) {
        self.bounceAnimation()
        completion?()
    }
    
    override func reselectAnimation(animated: Bool, completion: (() -> ())?) {
        self.bounceAnimation()
        completion?()
    }
    
    func bounceAnimation() {
        let impliesAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        impliesAnimation.values = [1.0 ,1.2, 1.0, 1.15, 0.95, 1.02, 1.0]
        impliesAnimation.duration = duration * 2
        impliesAnimation.calculationMode = kCAAnimationCubic
        imageView.layer.add(impliesAnimation, forKey: nil)
    }
}

class ExampleHighlightableContentView: ExampleBasicContentView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let transform = CGAffineTransform.identity
        imageView.transform = transform.scaledBy(x: 1, y: 1)
        
        textColor = UIColor.white
        highlightTextColor = UIColor.white
        iconColor = UIColor.white
        highlightIconColor = UIColor.white
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func highlightAnimation(animated: Bool, completion: (() -> ())?) {
        UIView.beginAnimations("small", context: nil)
        UIView.setAnimationDuration(0.2)
        let transform = imageView.transform.scaledBy(x: 0.7, y: 0.7)
        imageView.transform = transform
        UIView.commitAnimations()
        completion?()
    }
    
    override func dehighlightAnimation(animated: Bool, completion: (() -> ())?) {
        UIView.beginAnimations("big", context: nil)
        UIView.setAnimationDuration(0.2)
        let transform = CGAffineTransform.identity
        imageView.transform = transform.scaledBy(x: 1, y: 1)
        UIView.commitAnimations()
        completion?()
    }
    
}


class ExampleAnimateTipsContentView: ExampleBouncesContentView {
    
    override func badgeChangedAnimation(animated: Bool, completion: (() -> ())?) {
        super.badgeChangedAnimation(animated: animated, completion: nil)
        notificationAnimation()
    }
    
    func notificationAnimation() {
        let impliesAnimation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        impliesAnimation.values = [0.0 ,-8.0, 4.0, -4.0, 3.0, -2.0, 0.0]
        impliesAnimation.duration = duration * 2
        impliesAnimation.calculationMode = kCAAnimationCubic
        
        imageView.layer.add(impliesAnimation, forKey: nil)
    }
}

class ExampleAnimateTipsContentView2: ExampleAnimateTipsContentView {
    
    override func notificationAnimation() {
        let impliesAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        impliesAnimation.values = [1.0 ,1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
        impliesAnimation.duration = duration * 2
        impliesAnimation.calculationMode = kCAAnimationCubic
        self.badgeView.layer.add(impliesAnimation, forKey: nil)
    }
}
