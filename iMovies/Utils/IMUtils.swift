//
//  IMUtils.swift
//  iMovies
//
//  Created by Ricardo Casanova on 06/09/2018.
//  Copyright © 2018 Careem. All rights reserved.
//

import Foundation

public enum IMDeviceType {
    case iPhoneSE
    case iPhone8
    case iPhone8Plus
    case iPhoneX
}

class IMUtils {
    
    /**
     * Internal struct for device height
     */
    private struct DeviceHeight {
        
        static let iPhoneSE: CGFloat = 568.0
        static let iPhone8: CGFloat = 667.0
        static let iPhone8Plus: CGFloat = 736.0
        static let iPhoneX: CGFloat = 812.0
        
    }
    
    /**
     * Get the screen width
     */
    public static func screenWidth() -> CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    /**
     * Get the screen height
     */
    public static func screenHeight() -> CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    /**
     * Get the device type
     */
    public static func getDeviceType() -> IMDeviceType {
        let screenHeight = self.screenHeight()
        var deviceType = IMDeviceType.iPhoneSE
        switch screenHeight {
        case DeviceHeight.iPhoneSE:
            deviceType = IMDeviceType.iPhoneSE
            break
        case DeviceHeight.iPhone8:
            deviceType = IMDeviceType.iPhone8
            break
        case DeviceHeight.iPhone8Plus:
            deviceType = IMDeviceType.iPhone8Plus
            break
        case DeviceHeight.iPhoneX:
            deviceType = IMDeviceType.iPhoneX
            break
        default:
            deviceType = IMDeviceType.iPhoneSE
        }
        
        return deviceType
    }
    
}
