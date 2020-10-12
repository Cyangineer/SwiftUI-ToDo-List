//
//  TodoItem.swift
//  Neu Todo
//
//  Created by Nigell Dennis on 8/23/20.
//  Copyright © 2020 Nigell Dennis. All rights reserved.
//

import SwiftUI
import Combine

struct TodoItem: Identifiable, Equatable {
    let id = UUID()
    var itemText: String
    var isChecked = false
}

class TodoStore: ObservableObject {
    @Published var todoItems: [TodoItem] = []
}

struct TodoItemView: View {
    @Binding var isChecked: Bool
    @Binding var itemText: String
    @Binding var list: [TodoItem]
    var item: TodoItem
    
    var body: some View {
        HStack {
            Image(systemName: "checkmark")
                .frame(width: 35, height: 35)
                .foregroundColor(Color(#colorLiteral(red: 0.2039215686, green: 0.8, blue: 0.2431372549, alpha: 1)))
                .background(Color("Primary"))
                .clipShape(Circle())
                .shadow(color: isChecked ? Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)) : Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)), radius: 5, x: -3, y: -3)
                .shadow(color: isChecked ? Color(#colorLiteral(red: 0.6823529412, green: 0.6823529412, blue: 0.7529411765, alpha: 0.3951080117)) : Color(#colorLiteral(red: 0.6823529412, green: 0.6823529412, blue: 0.7529411765, alpha: 0)), radius: 5, x: 3, y: 3)
                .opacity(isChecked ? 1 : 0)
            Text(itemText)
                .font(.system(size: 16, weight: .semibold, design: .rounded))
                .foregroundColor(Color(#colorLiteral(red: 0.3764705882, green: 0.3215686275, blue: 0.9176470588, alpha: 1)))
                .offset(x: isChecked ? 0 : -30)
            Spacer()
            VStack {
                Image(systemName: "clear")
                    .frame(width: 42, height: 42)
                    .foregroundColor(.gray)
                    .onTapGesture {
                        self.delete(self.item)
                    }
                Spacer()
            }
            
        }
        .frame(width: 320, height: 100, alignment: .leading)
        .padding(.leading)
        .background(Color(#colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9529411765, alpha: 1)))
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .shadow(color: isChecked ? Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)) : Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 5, x: -3, y: -3)
        .shadow(color: isChecked ? Color(#colorLiteral(red: 0.6823529412, green: 0.6823529412, blue: 0.7529411765, alpha: 0)) : Color(#colorLiteral(red: 0.6823529412, green: 0.6823529412, blue: 0.7529411765, alpha: 0.3951080117)), radius: 5, x: 3, y: 3)
        .overlay(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(Color.clear, lineWidth: 10)
                .shadow(color: isChecked ? Color(#colorLiteral(red: 0.6823529412, green: 0.6823529412, blue: 0.7529411765, alpha: 0.4)) : Color(#colorLiteral(red: 0.6823529412, green: 0.6823529412, blue: 0.7529411765, alpha: 0)), radius: 5, x: 3, y: 3)
                .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(Color.clear, lineWidth: 10)
                .shadow(color: isChecked ? Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)) : Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)), radius: 5, x: -3, y:  -3)
                .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
        )
        //.animation(.easeIn)
        .onTapGesture {
            self.isChecked.toggle()
        }
    }
    
    func delete(_ item: TodoItem){
        self.list.removeAll(where: {$0 == item})
    }
}

struct TodoItemView_Previews: PreviewProvider {
    static var previews: some View {
        TodoItemView(isChecked: .constant(false), itemText: .constant("Hello World"), list: .constant([TodoItem(itemText: "test", isChecked: false)]), item: TodoItem(itemText: "test", isChecked: false))
    }
}
