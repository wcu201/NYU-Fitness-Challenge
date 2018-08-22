//
//  DictionaryRep.swift
//  NYU Fitness Challenge
//
//  Created by William  Uchegbu on 6/20/18.
//  Copyright © 2018 William Uchegbu. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

public protocol DictionaryRep
{
    func dictionaryRepresentation() -> Any
}

public extension DictionaryRep
{
    public func dictionaryRepresentation() -> Any
    {
        var dict: [String : Any] = [String : Any]()
        let mirror: Mirror = Mirror(reflecting: self)
        
        for child in mirror.children
        {
            let value = child.value
            if value is DictionaryRep
            {
                dict[child.label!] = (value as! DictionaryRep).dictionaryRepresentation()
            }
                
            else if (Mirror(reflecting: value).displayStyle == Mirror.DisplayStyle.enum)
            {
                dict[child.label!] = (value as! AnyHashable).hashValue
            }
                
            else if (value is Set<String>)
            {
                dict[child.label!] = (value as! Set<String>).array
                //let dictionary: [String : Any] = (value as! Set<String>).array
            }
                
            else if (value is Gender)
            {
                dict[child.label!] = (value as! Gender).rawValue
            }

                
            else if !(value is UIImage)
            {
                dict[child.label!] = value
            }
        }
        
        return dict
    }
}

extension Array
{
    public init(count: Int, elementCreator: @autoclosure () -> Element)
    {
        self = (0 ..< count).map { _ in elementCreator() }
    }
}

extension Array
{
    public func toDictionary<Key: Hashable>(with selectKey: (Element) -> Key) -> [Key:Element]
    {
        var dict = [Key:Element]()
        for element in self
        {
            dict[selectKey(element)] = element
        }
        return dict
    }
}

extension Set
{
    func toArray() -> [Element]
    {
        return Array(self)
    }
    
    var array: [Element]
    {
        get
        {
            return self.toArray()
        }
    }
}

extension Set
{
    public func toDictionary<Key: Hashable>(with selectKey: (Element) -> Key) -> [Key:Element]
    {
        var dict = [Key:Element]()
        for element in self
        {
            dict[selectKey(element)] = element
        }
        return dict
    }
}

extension UIView
{
    @discardableResult func showActivityIndicator() -> (UIActivityIndicatorView, UIView)
    {
        let container: UIView = UIView()
        container.frame = self.frame
        container.center = self.center
        container.backgroundColor = UIColor(white: 0xffffff, alpha: 0.3)
        container.tag = 10001
        
        let loadingView: UIView = UIView()
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = self.center
        loadingView.backgroundColor = UIColor(white: 0x444444, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        actInd.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0);
        actInd.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.whiteLarge
        
        actInd.center = CGPoint(x: loadingView.frame.size.width / 2, y:
            loadingView.frame.size.height / 2);
        
        loadingView.addSubview(actInd)
        container.addSubview(loadingView)
        self.addSubview(container)
        actInd.startAnimating()
        
        return (actInd, container)
    }
    
    func removeActivityIndicator()
    {
        self.viewWithTag(10001)?.removeFromSuperview()
    }
}
