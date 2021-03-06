//
//  Constants.swift
//  iMMiConnect
//
//  Created by Pandiyaraj on 09/12/17.
//  Copyright © 2017 Pandiyaraj. All rights reserved.
//

import UIKit
struct Constants {

enum UIUserInterfaceIdiom : Int
{
    case Unspecified
    case Phone
    case Pad
}


struct ScreenSize
{
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType
{
    static let IS_IPHONE            = UIDevice.current.userInterfaceIdiom == .phone
    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
    static var IS_SIMULATOR: Bool {
        return TARGET_OS_SIMULATOR != 0 // Use this line in Xcode 7 or newer
    }
}

struct defaults {
    static let isLoggedIn = "isLoggedIn"
}

struct ViewControllerNames {
    static let PatientListVc = "PatientListVc"
    static let RegisterPatientVc = "RegisterVc"
    static let DashboardVc = "DashboardVc"
    static let LoginNavVC = "LoginVc"
    static let SymptomsVc = "SymptomsVc"
}

struct CommonValues {
    static let jsonApplication: String = "application/json"
    static let urlencoded: String = "application/x-www-form-urlencoded"
  
    static let networkMessage = "No network available. Please enable Wifi/Mobiledata to use the app"
    
    static let accessDeniedMsg = "Access Denied. Key Invalid."
    static let dataUnavalibaleMsg = "Data unavailable."

}
    
    struct NibNames {
        static let Popuptableviewcell = "PopUpTableViewCell"
        static let ExpandbleTableViewCell = "ExpandbleTableViewCell"
        static let RemarksViewCell = "RemarksViewCell"

    }
    
    struct CellIdentifier {
        static let Popuptableviewcell = "popupcell"
        static let Expandablecell = "cell"
        static let Remarkcell = "RemarksCell"
    
    }

}
struct AppFont {
    
    // if regularOrBold  == false Bold font
    static func pixelToPoint(_ pixels : CGFloat) -> CGFloat{
        let pointsPerInch : CGFloat = 72.0
        let scale : CGFloat = 1.0
        var pixelPerInch : CGFloat = 0.0
        if Constants.DeviceType.IS_IPAD {
            pixelPerInch = 132 * scale
        }else if Constants.DeviceType.IS_IPHONE{
            pixelPerInch = 163 * scale
        }
        let fontSize = pixels * pointsPerInch / pixelPerInch
        return fontSize
    }
    
    struct FontName {
        static let bold = "Roboto-Bold"
        static let regular = "Roboto-Regular"
        static let medium = "Roboto-Medium"
        static let light = "Roboto-Light"

    }
    
    static func getBold(pixels:CGFloat) -> UIFont {
        return UIFont.init(name: FontName.bold, size: pixelToPoint(pixels))!
    }
    
    static func getMedium(pixels:CGFloat) -> UIFont {
        return UIFont.init(name: FontName.medium, size: pixelToPoint(pixels))!
    }
    static func getRegular(pixels:CGFloat) -> UIFont {
        return UIFont.init(name: FontName.regular, size: pixelToPoint(pixels))!
    }
    
    static func getLight(pixels:CGFloat) -> UIFont {
        return UIFont.init(name: FontName.light, size: pixelToPoint(pixels))!
    }
}

// HTTP METHODS
struct HttpMethod{
    static let GET : String = "GET"
    static let POST : String = "POST"
    static let DELETE : String = "DELETE"
    static let PUT : String = "PUT"
    static let PATCH:String = "PATCH"
    
}

/// Common values
struct CommonValues {
    static let jsonApplication: String = "application/json"
    static let urlencoded: String = "application/x-www-form-urlencoded"
    static let regionCode:String = ((Locale.current as NSLocale).object(forKey: .countryCode) as? String)!
    static var phoneCode:String = ""
}


struct DataPointTrailigPoint {
    
    static func tralingPoint(_ value : Double) -> Int{
        return Int(value - (value * 0.25))
    }
}


