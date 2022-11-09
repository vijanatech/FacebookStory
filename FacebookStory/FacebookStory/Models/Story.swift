// mimic facebook story model

import Foundation
import SwiftUI


struct FacebookStory: Identifiable {
    var id = UUID()
    var owner: User
    var stories: [Story]
}

struct Story: Identifiable {
    var id = UUID() 
    var StoryText: StoryText?
    var StoryImage: StoryImage?
    var StoryVideo: StoryVideo?
    var StoryViewers: [User]
}

struct StoryText: Identifiable {
    var id = UUID()
    var text: String
    var backgroundColor: Color
}

struct StoryImage: Identifiable {
    var id = UUID()
    var image: String
}

struct StoryVideo: Identifiable {
    var id = UUID()
    var video: Video
}

struct Video: Identifiable {
    var id = UUID()
    var videoURL: URL
}

struct User: Identifiable {
    var id = UUID()
    var name: String
    var profileImage: String
}

