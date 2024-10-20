//
//  Profile.swift
//  test
//
//  Created by CCNU-SK-35 on 2024/10/17.
//
import SwiftUI

struct Profile: Identifiable {
    var id = UUID().uuidString
    var userName: String
    var profilePicture: String
    var lastMsg: String
    var lastActive: String
}

var profiles = [
    Profile(userName: "iJustine", profilePicture: "Pic1", lastMsg: "Hi IM iJustine", lastActive: "10:25 PM"),
    Profile(userName: "Jenna Ezarik", profilePicture: "Pic2", lastMsg: "Nothing !", lastActive: "6:25 PM"),
    Profile(userName: "iJustine", profilePicture: "Pic3", lastMsg: "Binge watching...", lastActive: "10:25 PM"),
    Profile(userName: "iJustine", profilePicture: "Pic4", lastMsg: "404 Page Not Found !", lastActive: "10:25 PM"),
    Profile(userName: "iJustine", profilePicture: "Pic5", lastMsg: "Do not Disturb.", lastActive: "10:25 PM")
]
