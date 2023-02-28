//  ContentView.swift
//  MusicPlayer

import SwiftUI
import AVKit
import AVFoundation

let bundleAudio = [
    "Paradise-Island.mp3",
    "Deep-Trailer.mp3",
    "Electronic-Music.mp3",
    "Jazz-Music.mp3",
    "HipHop.mp3",
    "Rock-Music.mp3"
];

//

func loadBundleAudio(_ fileName:String) -> AVAudioPlayer? {
    let path = Bundle.main.path(forResource: fileName, ofType:nil)!
    let theurl = URL(fileURLWithPath: path)
    do {
        return try AVAudioPlayer(contentsOf: theurl)
    } catch {
        print("loadBundleAudio error", error)
    }
    return nil
}


struct Item : Identifiable {
    var id = UUID()
    var urlStr:String
    var name:String
    var music: String
}

// Array of image url strings
let imageArray = [
    "https://cdn.epidemicsound.com/player/20230221.22-deacc8ab30e1c6ed5ea79ea5566154d9efdb69b6/d70f6dc1c97191b06d091d11f2eb7444-384.jpg",
    "https://cdn.epidemicsound.com/player/20230221.22-deacc8ab30e1c6ed5ea79ea5566154d9efdb69b6/1c22ce280d7299918461d041a454bea6-384.jpg",
    "https://cdn.epidemicsound.com/player/20230221.22-deacc8ab30e1c6ed5ea79ea5566154d9efdb69b6/c4e6162ea5f06778552179b53edb4cca-384.jpg",
    "https://cdn.epidemicsound.com/player/20230221.22-deacc8ab30e1c6ed5ea79ea5566154d9efdb69b6/25f33c6f4a66b3fe05514744af10785e-384.jpg",
    "https://cdn.epidemicsound.com/player/20230221.22-deacc8ab30e1c6ed5ea79ea5566154d9efdb69b6/5e801a7f24fd69dbed80491a6e641696-384.jpeg",
    "https://cdn.epidemicsound.com/player/20230221.22-deacc8ab30e1c6ed5ea79ea5566154d9efdb69b6/bcfe69b24690535b14280dcd0ae26f1d-384.jpg",
]


// Read in an image from the array of url strings
func imageFor( index: Int) -> UIImage {
    let urlStr = imageArray[index % imageArray.count]
    return imageFor(string: urlStr)
}

// Read in an image from a url string
func imageFor(string str: String) -> UIImage {
    let url = URL(string: str)
    let imgData = try? Data(contentsOf: url!)
    let uiImage = UIImage(data:imgData!)
    return uiImage!
}

// Array of image url strings
let imageItems:[Item] = [
    Item(urlStr: imageArray[0], name:"Pop", music:"Paradise-Island.mp3"),
    Item(urlStr: imageArray[1], name:"Film", music:"Deep-Trailer.mp3"),
    Item(urlStr: imageArray[2], name:"Electronic Music", music:"Electronic-Music.mp3"),
    Item(urlStr: imageArray[3], name:"Jazz", music:"Jazz-Music.mp3"),
    Item(urlStr: imageArray[4], name:"Hip Hop", music:"HipHop.mp3"),
    Item(urlStr: imageArray[5], name:"Rock", music:"Rock-Music.mp3"),
]



struct ContentView: View {
    var body: some View {
        TabView {
            
            NavigationView {
                List {
                    ForEach(imageItems) { item in
                        NavigationLink( destination: ItemDetail(item: item)) {
                            ItemRow(item: item)
                        }
                    }
                }
                .navigationTitle("Genres")
            }
            .tabItem {
                Image(systemName: "music.note.house.fill")
                Text("Home")
            }
            
//            Text("Search Screen")
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            
            Text("Profile Screen")
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
        //        NavigationView {
        //          List {
        //            ForEach(imageItems) { item in
        //              NavigationLink( destination: ItemDetail(item: item)) {
        //                ItemRow(item: item)
        //              }
        //            }
        //          }
        //          .navigationTitle("Genres")
        //        }
    }
}


struct ItemDetail: View {
    @State var audioPlayer: AVAudioPlayer!
    @State var soundIndex = 0
    @State var soundFile = bundleAudio[0]
    @State var player: AVAudioPlayer? = nil
    @State var sliderValue : Float = 0.0

// audio slider
//    let audioAsset = AVURLAsset.init(item.music)
//
//    audioAsset.loadValuesAsynchronously(forKeys: ["duration"]) {
//        var error: NSError? = nil
//        let status = audioAsset.statusOfValue(forKey: "duration", error: &error)
//        switch status {
//        case .loaded: // Sucessfully loaded. Continue processing.
//            let duration = audioAsset.duration
//            let durationInSeconds = CMTimeGetSeconds(duration)
//            print(Int(durationInSeconds))
//            break
//        case .failed: break // Handle error
//        case .cancelled: break // Terminate processing
//        default: break // Handle all other cases
//        }
//    }
    
    
    
    var item:Item
    var body: some View { 
        VStack {
            Image(uiImage: imageFor(string: item.urlStr))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:320, height: 320)
                .cornerRadius(7)
                .padding(.bottom, 100)
            //      Spacer(minLength: 1)
            Text(item.name)
                .font(.title)
                .fontWeight(.semibold)
                .padding(.bottom, 30)
            Slider(value: $sliderValue, in: 0...10)
                .padding(.horizontal, 25.0)
                .padding(.bottom, 10)
            //play & pause buttons
            HStack {
                Spacer()
                Button(action: {
                    player = loadBundleAudio(item.music)
                    player?.play()
                }) {
                    Image(systemName: "play.circle.fill").resizable()
                        .frame(width: 50, height: 50)
                        .aspectRatio(contentMode: .fit)
                }
                Spacer()
                Button(action: {
                    player = loadBundleAudio(item.music)
                    player?.pause()
                }) {
                    Image(systemName: "pause.circle.fill").resizable()
                        .frame(width: 50, height: 50)
                        .aspectRatio(contentMode: .fit)
                }
                Spacer()
            }
            .padding(.bottom, 60.0)
            
        }
    }
}


struct ItemRow: View {
    var item:Item
    var body: some View {
        HStack {
            Image(uiImage: imageFor(string: item.urlStr))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:100, height: 100)
                .cornerRadius(7)
            Text(item.name)
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

