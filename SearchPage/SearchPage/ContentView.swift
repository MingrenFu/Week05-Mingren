
import SwiftUI

struct ContentView: View {
    let names = ["Pop", "Film", "Electronic Music", "Jazz", "Hip Hop", "Rock"]
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            List {
                ForEach(searchResults, id: \.self) { name in
                    NavigationLink {
                        Text(name)
                    } label: {
                        Text(name)
                    }
                }
            }
            .navigationTitle("Search")
        }
        .searchable(text: $searchText)
    }

    var searchResults: [String] {
        if searchText.isEmpty {
            return names
        } else {
            return names.filter { $0.contains(searchText) }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
