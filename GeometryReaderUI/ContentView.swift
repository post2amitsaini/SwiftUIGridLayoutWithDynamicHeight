//
//  ContentView.swift
//  GeometryReaderUI
//
//  Created by Amit Saini on 09/11/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { geometry in
                    ScrollView(.vertical) {
                        VStack(alignment: .leading) {
                            geometryLayout(geometry: geometry)
                        }
                    }
                }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct geometryLayout: View {
    @State var buttonArray = ["Aero & Defense ✔️", "Automotive ➕", "Consumers product & Retail ➕", "Energey & Utilities ➕", "High Tech ✔️", "Life Sciences ➕", "Public Services", "Property & Casual Insurance ➕"]
    let geometry: GeometryProxy

    var body: some View {
        self.generateContent(in: geometry)
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(self.buttonArray, id: \.self) { platform in
                self.getButtonText(for: platform)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width)
                        {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if platform == self.buttonArray.last! {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if platform == self.buttonArray.last! {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }
    }

    func getButtonText(for text: String) -> some View {
        Text(text)
            .padding(.all, 5)
            .font(.body)
            .background(Color.black)
            .foregroundColor(Color.white)
            .cornerRadius(10)
    }
}

