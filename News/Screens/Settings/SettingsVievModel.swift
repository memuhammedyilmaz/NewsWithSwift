//
//  SettingsVievModel.swift
//  News
//
//  Created by Muhammed Yılmaz on 24.06.2025.
//

import Foundation
import UserNotifications

class SettingsViewModel {
    
    //MARK: - Properties
    var sections = SettingsSection.sections
    
    private let themeKey = "selectedTheme"
    
    init() {
    }
}

//MARK: - Methods

extension SettingsViewModel {
    func fetchThemeMode() -> Int {
        UserDefaults.standard.integer(forKey: themeKey)
    }
    
    func updateNotificationStatus(isOn: Bool) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
            print("Notification status updates: \(granted)")
            
        }
    }
    func fetchNotificationStatus(_ complition: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                complition(settings.authorizationStatus == .authorized)
            }
        }
    }
    
}



