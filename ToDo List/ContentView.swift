//
//  ContentView.swift
//  ToDo List
//
//  Created by Ryan Henderson on 11/10/22.
//

import SwiftUI

struct ContentView: View {
    @State private var currentTodo = ""
    @State private var todos: [Item] = []
    
    private func save() {
        UserDefaults.standard.set(
            try? PropertyListEncoder().encode(self.todos), forKey: "myTodosKey")
    }
    private func load() {
        if let todosData = UserDefaults.standard.value(forKey: "myTodosKey") as? Data {
            if let todosList = try? PropertyListDecoder().decode(Array<Item>.self, from: todosData) {
                self.todos = todosList
            }
        }
    }
    private func delete(at offset: IndexSet) {
        self.todos.remove(atOffsets: offset)
        save()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("New Todo ..", text: $currentTodo)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        guard !self.currentTodo.isEmpty else { return }
                        self.todos.append(Item(todo: self.currentTodo))
                        self.currentTodo = ""
                        save()
                    }) {
                        Image(systemName: "text.badge.plus")
                    }
                    .padding(.leading, 5)
                }.padding()
                List {
                    ForEach(todos) { todoEntry in
                        Text(todoEntry.todo)
                    }.onDelete(perform: delete)
                }
            }.navigationBarTitle("Todo List")
        }.onAppear(perform: load)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
