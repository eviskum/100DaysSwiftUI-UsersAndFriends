//
//  ContentView.swift
//  UsersAndFriends
//
//  Created by Esben Viskum on 07/05/2021.
//

import SwiftUI
import CoreData

extension ContentView {
    func loadData() {
        print("Antal users i Core Data: \(userCD.count)")
        if userCD.count == 0 {
            print("No data in Core Data")
            guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
                print("Invalid URL")
                return
            }
            
            let request = URLRequest(url: url)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    if let decodedUsers = try? JSONDecoder().decode([User].self, from: data) {
                        DispatchQueue.main.async {
                            self.userList.users = decodedUsers
                            saveData()
                        }
                        return
                    }
                }
                
                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            }.resume()
        } else {
            print("Load data from Core Data")
            for user in userCD {
                self.userList.users.append(User(id: user.id!, isActive: user.isActive, name: user.name ?? "Unknown", age: Int(user.age), company: user.company ?? "", email: user.email ?? "", address: user.address ?? "", about: user.about ?? "", registered: user.registered ?? "", tags: user.tagsArray, friends: user.friendsArray))
            }
        }
    }
    
    func saveData() {
        print("Save data in Core Data")
        for user in self.userList.users {
            let userCD = UserCD(context: viewContext)
            userCD.id = user.id
            userCD.isActive = user.isActive
            userCD.name = user.name
            userCD.age = Int16(user.age)
            userCD.company = user.company
            userCD.email = user.email
            userCD.address = user.address
            userCD.about = user.about
            userCD.registered = user.registered

            for tag in user.tags {
                let tagCD = TagCD(context: viewContext)
                tagCD.tagName = tag
                userCD.addToTags(tagCD)
            }
            
            for friend in user.friends {
                let friendCD = FriendCD(context: viewContext)
                friendCD.id = friend.id
                friendCD.name = friend.name
                userCD.addToFriends(friendCD)
            }
        }

        print("Ready to save")
        try? self.viewContext.save()
        print("Data saved in Core Data")
    }
}


struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @FetchRequest(entity: UserCD.entity(), sortDescriptors: []) var userCD: FetchedResults<UserCD>

    @ObservedObject var userList = Users()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(userList.users, id: \.id) { user in
                    NavigationLink(destination: UserDetails(user: user, userList: userList)) {
                        VStack(alignment: .leading) {
                            Text(user.name)
                                .font(.headline)
                            Text(user.email)
                                .font(.footnote)
                        }
                        .foregroundColor(user.isActive ? .primary : .gray)
                    }
                }
            }
            .navigationBarTitle("Users & Friends")
        }
        .onAppear(perform: loadData)
        
/*        List {
            ForEach(items) { item in
                Text("Item at \(item.timestamp!, formatter: itemFormatter)")
            }
            .onDelete(perform: deleteItems)
        }
        .toolbar {
            #if os(iOS)
            EditButton()
            #endif

            Button(action: addItem) {
                Label("Add Item", systemImage: "plus")
            }
        } */
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

/*
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
*/

