//
//  ContentView.swift
//  hellomoon2
//
//  Created by aries on 3/10/21.
//

import SwiftUI

var screenHeight = UIScreen.main.bounds.height
var screenWidth = UIScreen.main.bounds.width

struct ContentView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var fetch = GetData()
    
    // arrays for moon info
    var moonPhases: [String]  = ["New Moon", "Waxing Crescent", "First Quarter", "Waxing Gibbous", "Full Moon", "Waning Gbbous", "Last Quarter", "Waning Crescent"]
    
    var moonPics: [String] = ["newMoon", "waxingCres", "firstQuart", "waxingGib", "fullMoon", "waningGib", "lastQuart", "waningCres"]
    
    var moonInfo: [String] = ["A new moon is when the Moon cannot be seen because we are looking at the unlit half of the Moon. The new moon phase occurs when the Moon is directly between the Earth and Sun. A solar eclipse can only happen at new moon.", "A waxing crescent moon is when the Moon looks like a crescent and the crescent increases (\"waxes\") in size from one day to the next. This phase is usually only seen in the west.", "The first quarter moon (or a half moon) is when half of the lit portion of the Moon is visible after the waxing crescent phase. It comes a week after new moon.", "A waxing gibbous moon occurs when more than half of the lit portion of the Moon can be seen and the shape increases (\"waxes\") in size from one day to the next. The waxing gibbous phase occurs between the first quarter and full moon phases.", "A Full Moon is when we can see the entire lit portion of the Moon. The full moon phase occurs when the Moon is on the opposite side of the Earth from the Sun, called opposition. A lunar eclipse can only happen at full moon.", "A waning gibbous moon occurs when more than half of the lit portion of the Moon can be seen and the shape decreases (\"wanes\") in size from one day to the next. The waning gibbous phase occurs between the full moon and third quarter phases.", "The last quarter moon (or a half moon) is when half of the lit portion of the Moon is visible after the waning gibbous phase.", "A waning crescent moon is when the Moon looks like a crescent and the crescent decreases (\"wanes\") in size from one day to the next."]
    
    var sunPos: [String] = ["Sunrise", "Sunrise", "Midday", "Midday", "Midday", "Midday", "Sunset", "Sunset", "Sunset", "Sunset", "Sunset", "Sunrise", "Sunrise", "Sunrise", "Sunrise", "Midday"]
    
    
//    private func sunriseEST() -> String {
//        let timeString = self.fetch.results?.results.sunrise ?? ""
//        let utcFormatter = DateFormatter()
//        utcFormatter.dateFormat = "hh:mm:ss z"
//        utcFormatter.timeZone = TimeZone(secondsFromGMT: 0)
//
//        let time = utcFormatter.date(from: timeString)
//
//        let userTimeFormatter = DateFormatter()
//        userTimeFormatter.timeStyle = .medium
//        let output = userTimeFormatter.string(from: time!)
//
//        return output
//    }
    
    
    // colors and gradients
    let backgroundColor = Color(red: 4/255, green: 34/255, blue: 51/255)
    //colorScheme == .dark ? "In dark mode" : "In light mode";
    var darkGradient = LinearGradient(gradient: Gradient(colors: [Color(red: 3/255, green: 24/255, blue: 33/255), Color(red: 21/255, green: 125/255, blue: 113/255)]), startPoint: .top, endPoint: .bottom)
    var lightGradient = LinearGradient(gradient: Gradient(colors: [Color(red: 255/255, green: 255/255, blue: 0/255), Color(red: 63/255, green: 169/255, blue: 245/255)]), startPoint: .bottom, endPoint: .top)
    let backgroundGradient = LinearGradient(gradient: Gradient(colors: [Color(red: 3/255, green: 24/255, blue: 33/255), Color(red: 4/255, green: 34/255, blue: 51/255)]), startPoint: .top, endPoint: .bottom)
    

    @State private var moonSlider = 0.0
    @State private var sunSlider = 1.0
    
    var body: some View {
        //var sunriseString = sunriseEST
        let riseTime = self.fetch.results?.results.sunrise ?? ""
        let setTime = self.fetch.results?.results.sunset ?? ""
        let noonTime = self.fetch.results?.results.solar_noon ?? ""
        
        var sunTime: [String] = ["Sun rises @ \(riseTime) UTC", "Sun rises @ \(riseTime) UTC", "Solar noon @ \(noonTime) UTC", "Solar noon @ \(noonTime) UTC", "Solar noon @ \(noonTime) UTC", "Solar noon @ \(noonTime) UTC", "Sun sets @ \(setTime) UTC", "Sun sets @ \(setTime) UTC", "Sun sets @ \(setTime) UTC", "Sun sets @ \(setTime) UTC", "Sun sets @ \(setTime) UTC", "Sun rises @ \(riseTime) UTC", "Sun rises @ \(riseTime) UTC", "Sun rises @ \(riseTime) UTC", "Sun rises @ \(riseTime) UTC", "Solar noon @ \(noonTime) UTC"]
        
        
        ScrollView {
            VStack(spacing: 0) {

                ZStack { // ================= top image =====================
                    Rectangle()
                        .fill(colorScheme == .dark ? darkGradient : lightGradient)
                        .ignoresSafeArea()
                    Image(colorScheme == .dark ? moonPics[Int(moonSlider)] : "sun")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .position(x: colorScheme == .dark ? 350 :
                                500 + -cos(CGFloat(sunSlider/2))*220,
                                  y: colorScheme == .dark ? 150 :
                                300 + -sin(CGFloat(sunSlider/2))*220)
                    Image("AthensGA")
                        .resizable()
                            //.aspectRatio(contentMode: .fill)
                        .scaledToFill()

                }.frame(width: 850, height: 550, alignment: .center)

                ZStack { // ==================== body =====================
                    Rectangle()
                        .fill(Color(red: 4/255, green: 34/255, blue: 51/255))
                        .ignoresSafeArea()
                    ZStack { // ===== body ======= date field ================
                        Rectangle()
                            .fill(Color.white).opacity(0.8)
                            .cornerRadius(15)
                            .frame(width: 350, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15).stroke(Color.white, lineWidth: 1)
                            )
                            
                        // ======================= button bar
                        VStack {
                            Slider(value: colorScheme == .dark ? $moonSlider : $sunSlider, in: colorScheme == .dark ? 0...7 : 0...15, step: 0.5)
                                .padding()
                                .accentColor(.green)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                            .stroke(lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                                        .foregroundColor(.white))
                                
                        }.frame(width: 350, height: 55, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                    }.position(x: screenWidth/2, y: 50)


                    ZStack { // ===== body ======= paragraph and header ================
                        Rectangle()
                            .fill(Color.white).opacity(0.3)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20).stroke(Color.white, lineWidth: 1)
                            )
                            .frame(width: screenWidth - 50, height: screenHeight/2.5, alignment: .center ).position(x: screenWidth/2, y: screenHeight/3)
                        VStack(spacing: 0) {
                            Text(colorScheme == .dark ? " Hello, Moon! " : " Hello, Sun! ")
                                .font(.largeTitle).fontWeight(.black)
                                .foregroundColor(.white)
                                .background(Color.black)
                                .position(x: screenWidth/2 - 20, y: 1)
                            Text(colorScheme == .dark ? moonPhases[Int(moonSlider)] : sunPos[Int(sunSlider)])
                                .font(.largeTitle).fontWeight(.black)
                                .foregroundColor(.white)
                                .position(x: screenWidth/2 - 20, y: -screenHeight/11)
                            Text(colorScheme == .dark ? moonInfo[Int(moonSlider)] : sunTime[Int(sunSlider)])
                                .font(.title2).lineLimit(8)
                                .padding(.horizontal)
                                .foregroundColor(.white)
                                .position(x: screenWidth/2 - 20, y: -screenHeight/8.3)
                        }.frame(width: screenWidth - 50, height: screenHeight/2, alignment: .center ).position(x: screenWidth/2, y: screenHeight/2.60)
                        
                    }

                }.frame(width: screenWidth, height: screenHeight/2 + 30, alignment: .center)
                // ^^ end of body

                
            }
            // ^^ end of Vstack
        }.background(backgroundGradient.edgesIgnoringSafeArea(.all))
        // ^^ end of scrollview
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct DataLayout: Codable {
    let results: Results
    let status: String
}

struct Results: Codable {
    let sunrise, sunset, solar_noon, day_length,
        civil_twilight_begin, civil_twilight_end,
        nautical_twilight_begin, nautical_twilight_end,
        astronomical_twilight_begin, astronomical_twilight_end: String
}

public class GetData: ObservableObject {
    @Published var results:  DataLayout?
    
    init() {
        load()
    }
    
    func load() {
        let dataUrl = URL(string: "https://api.sunrise-sunset.org/json?lat=33.9519&lng=-83.3576&date=today")!
        
        let decoder = JSONDecoder()
        
    
        URLSession.shared.dataTask(with: dataUrl) { (data,response,error) in do {
            if let d = data {
                let dLayout = try decoder.decode(DataLayout.self, from: d)
                DispatchQueue.main.async {
                    self.results = dLayout
                }
            } else {
                print("No data")
            }
        } catch {
            print("Error")
        }

        } .resume()
        
    }
} // end of class Get Data
