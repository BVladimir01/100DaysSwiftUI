//
//  CheckView.swift
//  CupcakeCorner
//
//  Created by Vladimir on 18.12.2024.
//

import SwiftUI

struct CheckView: View {
    
    var order: Order
    @State private var responseMessage = "response message"
    @State private var showAlert = false
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { phase in
                    switch phase {
                    case .empty:
                        ProgressView("loading image")
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .padding()
                            .containerRelativeFrame(.horizontal) { width, _ in
                                width
                            }
                    case .failure(let error):
                        Text(error.localizedDescription)
                    @unknown default:
                        fatalError()
                    }
                }
                Text("Your total is \(order.cost.formatted(.currency(code: "USD")))")
                    .font(.headline)
                Button {
                    Task {
                        await placeOrder()
                    }
                } label: {
                    Text("Place order")
                        .font(.title)
                }
                .padding()
                .alert("Thank you", isPresented: $showAlert) {
                    Button("Ok") { }
                } message: {
                    Text(responseMessage)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .scrollBounceBehavior(.basedOnSize)
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func placeOrder() async {
        guard let data = try? JSONEncoder().encode(order) else { return }
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: data)
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            responseMessage = "You ordered \(decodedOrder.quantity) \(decodedOrder.type.rawValue.lowercased()) cupcakes"
            showAlert = true
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    CheckView(order: Order())
}
