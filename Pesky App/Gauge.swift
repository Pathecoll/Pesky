//
//  Gauge.swift
//  Pesky App
//
//  Created by Hector Fabian Plata Santos on 14/01/21.
//

import SwiftUI

struct Gauge: View {
    @State var progress = 0.0
    var total = 10
    var realProgress: Double{
        let steps = 1.0/Double(total)
        let numberSteps = (progress * Double(total)).rounded()
        return (steps * numberSteps)
        
    }
    

    var body: some View {
        VStack{
        ZStack{
            // background Arc with visual effects
            Arc(progress: 1)
                .fill(Color(hue: 0, saturation: 0, brightness: 0.95))
                .overlay(
                    ZStack{
                        
                        Arc(progress: 1)
                            .stroke(Color(red: 1, green: 1, blue: 1, opacity: 0), lineWidth: 4 )
                            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.08), radius: 4, x: -4, y: 4)
                            .clipShape(Arc(progress: 1))
                        Arc(progress: 1)
                            .stroke(Color(red: 1, green: 1, blue: 1, opacity: 0), lineWidth: 4 )
                            .shadow(color: Color(red: 1, green: 1, blue: 1, opacity: 1), radius: 8, x: 2, y: -2)
                            .clipShape(Arc(progress: 1))
                    }
                )
            // Progress Arc with visual effects
            Arc(progress: realProgress)
                .fill(foregroundGradient)
                .shadow(color: Color(Color.RGBColorSpace.sRGB, red: 0.0, green: 0.0, blue: 0.0, opacity: 0.18), radius: 6, x: -4, y: 4)
                .overlay(
                    ZStack{
                        
                        Arc(progress: realProgress)
                            .stroke(Color(red: 236/255, green: 234/255, blue: 235/255, opacity: 0), lineWidth: 4 )
                            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.05), radius: 4, x: 4, y: -4)
                            .clipShape(Arc(progress: realProgress))
                        Arc(progress: realProgress)
                            .stroke(Color(red: 236/255, green: 234/255, blue: 235/255, opacity: 0), lineWidth: 4 )
                            .shadow(color: Color(red: 1, green: 1, blue: 1, opacity: 0.5), radius: 6, x: -4, y: 4)
                            .clipShape(Arc(progress: realProgress))
                    }
                )
            // Text that reflects the achieve progress to the total
            HStack(alignment: .firstTextBaseline){
                Text("\(Int(realProgress * Double(total)))")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .font(.system(size: 67, weight: .bold, design: .monospaced))
                Text("/\(total)")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .font(.system(size: 27, weight: .bold, design: .monospaced))
                    .foregroundColor(Color(.systemGray))
                
                    
        }
        
        }.padding()
            // Temp slider to test the Gaguge worked
            Slider(value: $progress, in: 0...1.0).padding()
            Spacer()

        }
        
    }
    
    //Variables
    var hue: Double {return realProgress.converting(from: 0.0...1.0 , to: 0.0...112) }
    var stops: [Gradient.Stop] {[ Gradient.Stop(
                color :Color(hue: hue/360, saturation: 90/100, brightness: 90/100, opacity: 1),
                location: 0.42 ),
              Gradient.Stop(
                color:  Color(hue: (hue+10)/360, saturation: 95/100, brightness: 95/100, opacity: 1),
                location: 0.9)

    ] }

    
    var foregroundGradient: AngularGradient {
        AngularGradient(gradient: Gradient(stops: stops), center: .center, angle: .degrees(20))
    }
}


struct Gauge_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Gauge(progress: 1, total: 20)
        }
    }
}
