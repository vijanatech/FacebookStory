// create a viewModel to manage one single story
//

import SwiftUI

class FacebookStoryViewModel: ObservableObject {
    @Published var facebookStory = [FacebookStory]()
    @Published var users = [User]()

    init(){
        // make a list of random 100 users with random name and systemImage of profile
        for _ in 0..<100 {
            let user = User(name: "User \(Int.random(in: 0...100))", profileImage: "person.fill")
            users.append(user)
        }
        // for each user create a story
        for user in users {
            let story = FacebookStory(owner: user, stories: createRandomStories())
            facebookStory.append(story)
        }
    }

    func createRandomStories() -> [Story] {
        var stories = [Story]()
        // create a random number of stories for each user
        for _ in 0..<Int.random(in: 1...10) {
            // create a random story type
            let storyType = Int.random(in: 0...2)
            switch storyType {
            case 0:
                // create a story with text
                let storyText = StoryText(text: "Hello World", backgroundColor: createRandomColor())
                let story = Story(StoryText: storyText, StoryImage: nil, StoryVideo: nil, StoryViewers: [User]())
                stories.append(story)
            case 1:
                // create a story with image
                let storyImage = StoryImage(image: "person.fill")
                let story = Story(StoryText: nil, StoryImage: storyImage, StoryVideo: nil, StoryViewers: [User]())
                stories.append(story)
            case 2:
                // create a story with video
                let video = Video(videoURL: URL(string: "https://www.youtube.com/watch?v=QH2-TGUlwu4")!)
                let storyVideo = StoryVideo(video: video)
                let story = Story(StoryText: nil, StoryImage: nil, StoryVideo: storyVideo, StoryViewers: [User]())
                stories.append(story)
            default:
                break
            }
        }
        return stories
    }

    func createRandomColor() -> Color {
        let colors: [Color] = [.red, .green, .blue, .yellow, .orange, .pink, .purple, .gray]
        return colors.randomElement()!
    }
}
