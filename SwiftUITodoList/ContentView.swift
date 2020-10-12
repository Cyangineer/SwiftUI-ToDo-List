//
//  ContentView.swift
//  SwiftUITodoList
//
//  Created by Nigell Dennis on 10/11/20.
//  Copyright © 2020 Nigell Dennis. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject var todoStore = TodoStore()
    @State var newItem = ""
    @State var isFocused = false
    
    func addItem(){
        if newItem != "" {
            todoStore.todoItems.insert(TodoItem(itemText: newItem), at: 0)
            newItem = ""
            self.isFocused = false
            self.hideKeyboard()
        }
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9529411765, alpha: 1)).edgesIgnoringSafeArea(.all)
            
            ZStack {
                VStack {
                    Text("What to do?...")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundColor(Color(#colorLiteral(red: 0.3764705882, green: 0.3215686275, blue: 0.9176470588, alpha: 1)))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 30)
                        .padding(.top, 30)
                    
                    Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9529411765, alpha: 1)),Color(#colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9529411765, alpha: 0))]), startPoint: .top, endPoint: .bottom))
                    .frame(maxWidth: .infinity)
                    .frame(height: 10)
                    .offset(y: 18)
                    .zIndex(10)

                    ZStack {
                        Text("Nothing?\nGreat!")
                            .font(.system(size: 28, weight: .bold, design: .rounded))
                            .foregroundColor(Color(#colorLiteral(red: 0.3764705882, green: 0.3215686275, blue: 0.9176470588, alpha: 0.5)))
                            .multilineTextAlignment(.center)
                            .opacity(todoStore.todoItems.isEmpty ? 1 : 0)
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(spacing: 35) {
                                ForEach(todoStore.todoItems.indices, id: \.self) { item in
                                    TodoItemView(isChecked: self.$todoStore.todoItems[item].isChecked, itemText: self.$todoStore.todoItems[item].itemText, list: self.$todoStore.todoItems,item: self.todoStore.todoItems[item])
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.top)
                            .padding(.bottom)
                        }
                    }
                    
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: 135)
                }
                
                VStack {
                    
                    Spacer()
                    
                    VStack {
                        Rectangle()
                            .fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9529411765, alpha: 0)), Color(#colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9529411765, alpha: 1))]), startPoint: .top, endPoint: .bottom))
                            .frame(maxWidth: .infinity)
                            .frame(height: 10)
                            .offset(y: -3)
                        
                        ZStack {
                            Rectangle()
                                .fill(Color(#colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9529411765, alpha: 1)))
                                .frame(height: 22)
                                .padding()
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .stroke(Color.clear, lineWidth: 10)
                                        .shadow(color: Color(#colorLiteral(red: 0.6823529412, green: 0.6823529412, blue: 0.7529411765, alpha: 0.4)), radius: 5, x: 3, y: 3)
                                        .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .stroke(Color.clear, lineWidth: 10)
                                        .shadow(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 5, x: -3, y:  -3)
                                        .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                )
                            
                            TextField("Add new item", text: $newItem)
                                .padding()
                                .font(.system(size: 16, weight: .bold, design: .rounded))
                                .foregroundColor(Color(#colorLiteral(red: 0.3764705882, green: 0.3215686275, blue: 0.9176470588, alpha: 1)))
                                .keyboardType(.default)
                                .onTapGesture {
                                    self.isFocused = true
                            }
                        }
                        .frame(width: 320)
                        
                        Spacer()
                        
                        Button(action: addItem) {
                            Image(systemName: "plus")
                                .foregroundColor(Color(#colorLiteral(red: 0.3764705882, green: 0.3215686275, blue: 0.9176470588, alpha: 1)))
                        }
                        .frame(width: 88, height: 44)
                        .background(Color(#colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9529411765, alpha: 1)))
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .shadow(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 5, x: -3, y: -3)
                        .shadow(color: Color(#colorLiteral(red: 0.6823529412, green: 0.6823529412, blue: 0.7529411765, alpha: 0.3951080117)), radius: 5, x: 3, y: 3)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 150)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .offset(y: isFocused ? -320 : 0)
            .animation(.easeInOut)
            .onTapGesture {
                self.isFocused = false
                self.hideKeyboard()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

