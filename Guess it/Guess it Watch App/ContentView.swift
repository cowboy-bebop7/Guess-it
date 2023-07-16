import SwiftUI

struct ContentView: View {
    @State private var targetNumber = Int.random(in: 1...100)
    @State private var userGuess = ""
    @State private var feedbackText = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Siri says...")
                .font(.title)
            
            TextField("Enter your guess", text: Binding(
                get: { self.userGuess },
                set: {
                    if let newValue = Int($0) {
                        self.userGuess = String(newValue)
                    }
                }
            ), onCommit: checkGuess)
            .font(.title3)
            .textFieldStyle(PlainTextFieldStyle())
            .padding()
            .modifier(HideKeyboardOnTap())
            .textContentType(.oneTimeCode)
            
            Button(action: checkGuess) {
                Text("Check Guess")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            Text(feedbackText)
                .font(.headline)
                .foregroundColor(.blue)
        }
        .padding()
    }
    
    func checkGuess() {
        guard let guess = Int(userGuess) else {
            feedbackText = "Invalid guess!"
            return
        }
        
        if guess < targetNumber {
            feedbackText = "Didn't see that coming,low"
        } else if guess > targetNumber {
            feedbackText = "Too much"
        } else {
            feedbackText = "How is that possible"
        }
        
        targetNumber = Int.random(in: 1...100)
        userGuess = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct HideKeyboardOnTap: ViewModifier {
    @Environment(\.presentationMode) var presentationMode
    
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                hideKeyboard()
            }
    }
    
    private func hideKeyboard() {
        presentationMode.wrappedValue.dismiss()
    }
}

