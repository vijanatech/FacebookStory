// create a facebook storyview

import SwiftUI
import AVKit


struct FacebookStoryView: View {
    @ObservedObject var viewModel = FacebookStoryViewModel()
    var body: some View {
        NavigationView{
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(viewModel.facebookStory) { story in
                        StoryView(story: story)
                    }
                }
            }
        }
        // hide the navigation bar
        .navigationBarHidden(true)
    }
}

struct StoryView: View {
    var story: FacebookStory
    var body: some View {
        // create a rectangle to hold each story which on click will navigate to the story view
        NavigationLink(destination: StoryDetailView(story: story)) {
            Rectangle()
                .frame(width: 100, height: 100)
                .foregroundColor(.gray)
                .cornerRadius(10)
                .overlay(
                    VStack {
                        Image(systemName: story.owner.profileImage)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                            .shadow(radius: 10)
                        Text(story.owner.name)
                            .font(.system(size: 10))
                    }
                )
        }
    }
    
}

// story detail view should cover the whole screen and show story by story
struct StoryDetailView: View {
    var story: FacebookStory
    @State var currentStoryIndex = 0
    var body: some View {
        ZStack {
            StoryBody()
            StoryHeader()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .gesture(DragGesture(minimumDistance: 20)
            .onEnded({ value in
                if value.translation.width < 0 {
                    if currentStoryIndex < story.stories.count - 1 {
                        currentStoryIndex += 1
                    }
                } else {
                    if currentStoryIndex > 0 {
                        currentStoryIndex -= 1
                    }
                }
            })
        )
    }
    @ViewBuilder
    func StoryBody() -> some View {
         if story.stories[currentStoryIndex].StoryText != nil {
                // show the story text in full Rectangle with background color and text center
                Rectangle()
                    .foregroundColor(story.stories[currentStoryIndex].StoryText!.backgroundColor)
                    .overlay(
                        Text(story.stories[currentStoryIndex].StoryText!.text)
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                    )
                
                
            } else if story.stories[currentStoryIndex].StoryImage != nil {
                // show the story image
                Image(systemName: story.stories[currentStoryIndex].StoryImage!.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else if story.stories[currentStoryIndex].StoryVideo != nil {
                // show the story video
                VideoPlayer(player: AVPlayer(url: story.stories[currentStoryIndex].StoryVideo!.video.videoURL))
                
            }
    }
    @ViewBuilder
    func StoryHeader() -> some View {
        VStack(alignment: .leading) {
                HStack {
                    Image(systemName: story.owner.profileImage)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        .shadow(radius: 10)
                    Text(story.owner.name)
                        .font(.system(size: 20))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                Spacer()
                // show ProgressView to show the progress of each story
                // HStack{
                    
                // }
                // .padding
            }
            .padding()
    }
}






