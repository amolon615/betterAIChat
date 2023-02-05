//
//  ContentView.swift
//  betterAIChat
//
//  Created by Artem on 04/02/2023.
//

import SwiftUI
import ChatGPTSwift



struct ContentView: View {
    let api = ChatGPTAPI(apiKey: "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")
    
    
    @State var prompt: String = ""
    @State var response: [String] = []
    
    var body: some View {
        ScrollView {
            //Input field
            TextField(text: $prompt) {
                Text("Type your request")
                    .foregroundColor(.white)
            }
            .frame(width: 300, height: 50)
            .background(.gray)
            .cornerRadius(10)
            .foregroundColor(.white)
        
            
            //submit button
            Button{
                Task {
                    do {
                        let stream = try await api.sendMessageStream(text: prompt)
                        for try await line in stream {
                            response.append(line)
                            print(line)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            } label: {
                Text("Submit prompt")
            }
            .frame(width: 150, height: 50)
            .background(.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            //Clear button
            Button{
                response.removeAll()
                prompt = ""
            } label: {
                Text("Clear")
            }
            .frame(width: 150, height: 50)
            .background(.red)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            //output field
            Text(response.joined())
                .textSelection(.enabled)
        }
        .padding()
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
