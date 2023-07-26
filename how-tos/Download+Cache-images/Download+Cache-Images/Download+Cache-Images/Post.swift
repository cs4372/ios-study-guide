//
//  Post.swift
//  Download+Cache-Images
//
//  Created by Catherine Shing on 7/25/23.
//

import Foundation

struct PostUserProfileImage: Codable {
    let medium: String?
}

struct PostUser: Codable {
    let profile_image: PostUserProfileImage
}

struct PostUrls: Codable {
    let regular: String?
}

struct Post: Codable {
    let id: String
    let description: String?
    let user: PostUser
    let urls: PostUrls
}
