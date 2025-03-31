//
//  Constants.swift
//  SmartTerrarium
//
//  Created by Than Hai Phong on 03/11/2024.
//

import Foundation
import UIKit


enum Constants {
    static let rowHeight: CGFloat = 50.0
    static let CameraButtonSize = CGSize(width: 50, height: 50)
    static let addIncomeButtonSize = CGSize(width: 50, height: 50)
    static let mobileButtonSize = CGSize(width: 70, height: 70)
    static let animationDuration: CGFloat = 0.1
    static let selectionIndicatorSize = CGSize(width: 20, height: 10)
    static let selectionIndicatorLineWidth: CGFloat = 5.0
    static let indicatorSize = CGSize(width: 40, height: 6)
    static let indicatorViewSize = CGSize(width: 20, height: 20)
    static let alphaChangeDuration: CGFloat = 0.3
    static let clearAnimationDuration: Double = 3.0
    
    //for news
    static let plus30: CGFloat = 30
    static let plus16: CGFloat = 16
    static let minus16: CGFloat = -16
    
    //for SettingsViewController
    static let kittenAnimationDuration: Double = 4.5
    static let kittenHidingDuration: Double = 0.3
    static let kittenSize: CGSize = CGSize(width: 190, height: 140)
    static let kittenLeftInsetValue: CGFloat = -70
    static let navBarHeight: CGFloat = 96
    
    static let tintColor = UIColor.init(red: 1.0, green: 78.0/255.0, blue: 32.0/255.0, alpha: 1.0)

}

enum Images {
    static let placeHolderImage      = UIImage(named: "placeholder-profile")
    static let aboutUS_appImg        = UIImage(named: "app_Background")
    static let usernameIcon          = UIImage(named: "username_icon")
    static let passwordIcon          = UIImage(named: "password_icon")
    static let login_Image           = UIImage(named: "Login_logo")
    static let singup_Image          = UIImage(named: "singUp")
    static let forgetpassword_Image  = UIImage(named: "Forgetpass")
    
    static let edityourProfile       = UIImage(systemName: "slider.horizontal.3")
    static let changePassword        = UIImage(systemName: "key.fill")
    static let changeUsername        = UIImage(systemName: "person.fill")
    static let userStatementIcon     = UIImage(systemName: "newspaper.fill")
    
    static let enableAuth            = UIImage(systemName: "faceid")
    
    static let aboutUs               = UIImage(systemName: "hand.point.up.braille.fill")
    static let logout                = UIImage(systemName: "rectangle.portrait.and.arrow.right.fill")
    
    static let spending_Money        = UIImage(named: "spending_money")
    static let login_pin_background  = UIImage(named: "login_withPin_img")
    
    static let mobileAcceptIcon      = UIImage(systemName: "checkmark.circle")
    static let mobileIgnoreIcon      = UIImage(systemName: "xmark.circle")

}

enum Sizes {
    enum Spacing {
        static let x1: CGFloat = 8.0
        
        static func multiply(_ coeff: Int) -> CGFloat {
            Sizes.Spacing.x1 * CGFloat(coeff)
        }
    }
}

enum DeviceTypes {
    enum ScreenSize {
        static let width                = UIScreen.main.bounds.size.width
        static let height               = UIScreen.main.bounds.size.height
        static let maxLength            = max(ScreenSize.width, ScreenSize.height)
        static let minLength            = min(ScreenSize.width, ScreenSize.height)
    }
    
    static let idiom                    = UIDevice.current.userInterfaceIdiom
    static let nativeScale              = UIScreen.main.nativeScale
    static let scale                    = UIScreen.main.scale
    
    static let isiPhoneSE               = idiom == .phone && ScreenSize.maxLength == 667.0
    static let isiPhone8Standard        = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
    static let isiPhone8Zoomed          = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale > scale
    static let isiPhone8PlusStandard    = idiom == .phone && ScreenSize.maxLength == 736.0
    static let isiPhone8PlusZoomed      = idiom == .phone && ScreenSize.maxLength == 736.0 && nativeScale > scale
    static let isiPhoneX                = idiom == .phone && ScreenSize.maxLength == 812.0
    static let isiPhonePro              = idiom == .phone && ScreenSize.maxLength == 812.0
    static let isiPhone14Pro            = idiom == .phone && ScreenSize.maxLength == 852.0
    static let isiPhoneMini             = idiom == .phone && ScreenSize.maxLength == 812.0
    static let isiPhoneXsMaxAndXr       = idiom == .phone && ScreenSize.maxLength == 896.0
    static let isiPhone11               = idiom == .phone && ScreenSize.maxLength == 896.0
    static let isiPad                   = idiom == .pad && ScreenSize.maxLength >= 1024.0
    
    static func isiPhoneXAspectRatio() -> Bool {
        return isiPhoneX || isiPhoneXsMaxAndXr
    }
}

enum RoundedCorners {
    case top
    case bottom
    case all
}



