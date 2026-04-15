//
//  ContentView.swift
//  HomeScreen
//
//  Created by Gaurang Pant on 15/04/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house.fill") {
                HomeView()
            }
            
            Tab("Contacts", systemImage: "person.2.fill") {
                ContactsView()
            }

            Tab("QR Code", systemImage: "qrcode") {
                QRCodeView()
            }

            Tab("Profile", systemImage: "person.fill") {
                UserProfileView()
            }
        }
    }
}

#Preview {
    ContentView()
}
