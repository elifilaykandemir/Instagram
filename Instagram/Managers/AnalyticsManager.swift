//
//  AnalyticsManager.swift
//  Instagram
//
//  Created by Elif İlay Eser
//

import Foundation
import FirebaseAnalytics

final class AnalyticsManager{
    
    static let shared = AnalyticsManager()
    
    private init(){}
    
    func logevent(){
        Analytics.logEvent("MyEvent", parameters: [
            "parameter" : "parameter body"
        ])
    }
}
