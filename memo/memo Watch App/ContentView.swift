//
//  ContentView.swift
//  memo Watch App
//
//  Created by Tri Pham on 2/18/23.
//

import SwiftUI

struct ContentView: View {
    
    // Property
    @State private var notes: [Note] = [Note]()
    @State private var text: String = ""
    
    @AppStorage("lineCount") var lineCount: Int = 1
    
    // Functions
    
    func getDocumentDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    func save() {
        
        do {
            // Convert the note array to the data using JSON encoder
            let data = try JSONEncoder().encode(notes)
            
            // Create new URL to save the file
            let url = getDocumentDirectory().appendingPathComponent("notes")
            
            // Write the data to given location
            try data.write(to: url)
        } catch {
            print("saving data failed")
        }
//        dump(notes)
    }
    
    func load() {
        DispatchQueue.main.async {
            do {
                // get note path
                let url = getDocumentDirectory().appendingPathComponent("notes")
                
                // create new property
                let data = try Data(contentsOf: url)
                
                // decode
                notes = try JSONDecoder().decode([Note].self, from: data)
                
            } catch {
                // Do nothing
            }
        }
    }
    
    func delete(offsets: IndexSet) {
        withAnimation {
            notes.remove(atOffsets: offsets)
            save()
        }
    }
    
    // Body
    var body: some View {
        NavigationStack {
            VStack {
                HStack(alignment: .center, spacing: 6) {
                    TextField("Add new notes", text: $text)
                    
                    Button {
                        // Only run the button if the text field is not empty
                        guard text.isEmpty == false else {
                            return
                        }
                        
                        // Create new note
                        let note = Note(id: UUID(), text: text)
                        notes.append(note)
                        
                        // Make text blank again
                        text = ""
                        
                        // save the note
                        save()
                        
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 42, weight: .semibold))
                    }
                    .fixedSize()
                    .buttonStyle(PlainButtonStyle())
                    .foregroundColor(.accentColor)
    //                .buttonStyle(BorderedButtonStyle(tint: .accentColor))
                } // HStack
                
                Spacer()
                
                if notes.count > 1 {
                    List {
                        ForEach(0..<notes.count, id: \.self) { i in
                            NavigationLink(destination: DetailView(note: notes[i], count: notes.count, index: i)) {
                                HStack {
                                    Capsule()
                                        .frame(width: 4)
                                        .foregroundColor(.accentColor)
                                    
                                    Text(notes[i].text)
                                        .lineLimit(lineCount)
                                        .padding(.leading, 5)
                                }
                            } // HStack
                        } // ForEach
                        .onDelete(perform: delete)
                    } // List
                } else {
                    
                    Spacer()
                    
                    Image(systemName: "note.text")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                        .opacity(0.25)
                        .padding(25)
                    
                    Spacer()
                }
                
            } // VStack
            .navigationTitle("Notes")
            .onAppear {
                load()
            }
            
        } // Navigation stack
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
