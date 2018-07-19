//
//  Loading.swift
//  Naber
//
//  Created by 王淳彦 on 2018/7/18.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

//import Foundation
import NVActivityIndicatorView

public class Loading {
    
    static let data : ActivityData = ActivityData(
        size: CGSize(width: 80, height: 80),
        type: NVActivityIndicatorType.ballSpinFadeLoader,
        color: UIColor.white,
        backgroundColor: UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.3)
    )
    
    public static func show(){
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(self.data, nil)
    }
    
    public static func hide(){
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
    }
}


