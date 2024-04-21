//
//  ContentView.swift
//  what-2-eat
//
//  Created by 江承恩 on 2024/2/23.
//

import SwiftUI

struct ContentView: View {
    let food = ["五九", "JJ Poke", "海南雞", "四面八方", "好好吃麵", "小圓村", "親來食堂", "唯雞館", "酉心麥麵", "Barkers", "I'm Pasta", "燒臘", "李記", "大李", "樂和", "活大", "麥當勞", "福勝亭", "阿孟", "巷仔口", "馬祖", "滇味", "老哥", "誠信鵝肉"]
    @State private var selectedFood : String?
    
    var body: some View {
        VStack(spacing: 30) {
            Image("eat")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            Text("今天吃啥？")
                .font(.largeTitle)
                .bold()
                .padding()
            if (selectedFood != .none){
                Text(selectedFood ?? "")
                    .font(.largeTitle)
                    .foregroundColor(.green)
                    .id(selectedFood)
            }
            Button(role: .none) {
                selectedFood = food.shuffled().filter { $0 != selectedFood}.first
            } label: {
                Text(selectedFood == .none ? "來一個" : "換一個").frame(width: 200)
                    .animation(.none, value:selectedFood)
                    .transformEffect(.identity)
            }
            .font(.title)
            .controlSize(.large)
            .buttonStyle(.borderedProminent)
            .tint(.cyan)
            Button(role: .none) {
                selectedFood = .none
            } label: {
                Text("重置").frame(width: 200)
            }
            .buttonStyle(.bordered)
            .font(.title)
            .padding()
            .controlSize(.large)
            .buttonStyle(.borderedProminent)
            .tint(.cyan)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.secondarySystemBackground))
        .animation(.easeInOut(duration: 0.3), value: selectedFood)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
