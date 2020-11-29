//
//  Global.swift
//  widgetdemo
//
//  Created by Artesia Ko on 11/28/20.
//

import Foundation
import WidgetKit

let appGroup = "group.com.yanlamko.WidgetDemo"
let snowmanKey = "snowman"

struct Global {
    static func getSnowman() -> Int {
        return UserDefaults(suiteName: appGroup)?.object(forKey: snowmanKey) as? Int ?? 1
    }
    
    static func setSnowman(i: Int) {
        UserDefaults(suiteName: appGroup)?.set(i, forKey: snowmanKey)
        WidgetCenter.shared.reloadAllTimelines()
    }
}
