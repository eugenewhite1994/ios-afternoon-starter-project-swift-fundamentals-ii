import UIKit


//: ## 1. Create custom types to represent an Airport Departures display
//: ![Airport Departures](matthew-smith-5934-unsplash.jpg)
//: Look at data from [Departures at JFK Airport in NYC](https://www.airport-jfk.com/departures.php) for reference.
//:
//: a. Use an `enum` type for the FlightStatus (En Route, Scheduled, Canceled, Delayed, etc.)
//:
//: b. Use a struct to represent an `Airport` (Destination or Arrival)
//:
//: c. Use a struct to represent a `Flight`.
//:
//: d. Use a `Date?` for the departure time since it may be canceled.
//:
//: e. Use a `String?` for the Terminal, since it may not be set yet (i.e.: waiting to arrive on time)
//:
//: f. Use a class to represent a `DepartureBoard` with a list of departure flights, and the current airport
enum flightStatus : String {
    case canceled = "canceled"
    case delayed = "delayed"
    case inRoute = "in route"
    case departingSoon = "departing soon"
    case boarding = "boarding"
}
let flightCanceled = flightStatus.canceled
let flightDelayed = flightStatus.delayed
let flightRoute = flightStatus.inRoute
let departing = flightStatus.departingSoon
let boarding = flightStatus.boarding

struct Airport {
    let city: String
    let code: String
    
}
struct Flight {
    let date: Date?
    let terminal: String?
    let airline: String
    let depatureTime: Date?
    let destination: Airport
    let flightNumber: String
    let status: flightStatus

}

class DeperatureBoard{
    var depatureFlights: [Flight] = []
    let currentAirPort: Airport
    init(city: String, code: String) {
        currentAirPort = Airport(city: city, code: code )
}
    func addFlights(_ flights: [Flight]) {
        depatureFlights.append(contentsOf: flights)
    
    }
    func alertPassenger() {
        for passenger in depatureFlights {
            if passenger.status == .boarding {
                print("Your flight is boarding, please head to terminal")
            }
            else if passenger.status == .departingSoon {
                print("Your flight to \(passenger.destination) is scheduled to depart at \(Date()) from terminal: \(passenger.terminal ?? "")")
        }
            else if passenger.status == .canceled {
                print("We are sorry your flight to \(passenger.destination) was canceled, here is a 500 vouher")
            }
}
}
}


let jfkDepartureBoard = DeperatureBoard(city: "New York" , code: "JFK")
let laxDepartureBoard = DeperatureBoard(city: "LA", code: "LAX")


//: ## 2. Create 3 flights and add them to a departure board
//: a. For the departure time, use `Date()` for the current time
//:
//: b. Use the Array `append()` method to add `Flight`'s
//:
//: c. Make one of the flights `.canceled` with a `nil` departure time
//:
//: d. Make one of the flights have a `nil` terminal because it has not been decided yet.
//:
//: e. Stretch: Look at the API for [`DateComponents`](https://developer.apple.com/documentation/foundation/datecomponents?language=objc) for creating a specific time
let chicago = Airport(city: "Rockford", code: "RFD")
let losAngeles = Airport(city: "Los Angeles", code: "LAX")
let reykjavik = Airport(city: "Reykjavik", code: "KEF")
var cities = [chicago, losAngeles, reykjavik]

//append
cities.append(Airport(city: "Louisville" , code: "SDF"))


let flight1 = Flight(date: Date(), terminal: "Number 15", airline: "Rockford", depatureTime: Date(), destination: reykjavik, flightNumber: "5X1125", status: .canceled)
let flight2 = Flight(date: Date(), terminal: nil, airline: "Los Angeles", depatureTime: Date(), destination: losAngeles, flightNumber: "AA302", status: .boarding)
let flight3 = Flight(date: Date(), terminal: "Currently not available", airline: "Louisville", depatureTime: Date(), destination: chicago, flightNumber: "SDF", status: .departingSoon)

var flights : [Flight] = [flight1, flight2, flight3]
jfkDepartureBoard.addFlights(flights)
let departures = jfkDepartureBoard.depatureFlights
for flight in departures {
    print(flight.destination.city, flight.destination.code, flight.airline)
}
//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function
func printDepatures(departureBoard: DeperatureBoard) {
    let departures = jfkDepartureBoard.depatureFlights
    for depature in departures {
        print("Destination : \(depature.destination), Airline: \(depature.airline) Flight: \(depature.flightNumber), Departure Time: \(depature.date ?? Date()), Terminal: \(depature.terminal ?? ""), Status: \(depature.status) ")
    }
        
}



//: ## 4. Make a second function to print print an empty string if the `departureTime` is nil
//: a. Createa new `printDepartures2(departureBoard:)` or modify the previous function
//:
//: b. Use optional binding to unwrap any optional values, use string interpolation to turn a non-optional date into a String
//:
//: c. Call the new or udpated function. It should not print `Optional(2019-05-30 17:09:20 +0000)` for departureTime or for the Terminal.
//:
//: d. Stretch: Format the time string so it displays only the time using a [`DateFormatter`](https://developer.apple.com/documentation/foundation/dateformatter) look at the `dateStyle` (none), `timeStyle` (short) and the `string(from:)` method
//:
//: e. Your output should look like:
//:
//:     Destination: Los Angeles Airline: Delta Air Lines Flight: KL 6966 Departure Time:  Terminal: 4 Status: Canceled
//:     Destination: Rochester Airline: Jet Blue Airways Flight: B6 586 Departure Time: 1:26 PM Terminal:  Status: Scheduled
//:     Destination: Boston Airline: KLM Flight: KL 6966 Departure Time: 1:26 PM Terminal: 4 Status: Scheduled
printDepatures(departureBoard: jfkDepartureBoard)
        

//: ## 5. Add an instance method to your `DepatureBoard` class (above) that can send an alert message to all passengers about their upcoming flight. Loop through the flights and use a `switch` on the flight status variable.
//: a. If the flight is canceled print out: "We're sorry your flight to \(city) was canceled, here is a $500 voucher"
//:
//: b. If the flight is scheduled print out: "Your flight to \(city) is scheduled to depart at \(time) from terminal: \(terminal)"
//:
//: c. If their flight is boarding print out: "Your flight is boarding, please head to terminal: \(terminal) immediately. The doors are closing soon."
//:
//: d. If the `departureTime` or `terminal` are optional, use "TBD" instead of a blank String
//:
//: e. If you have any other cases to handle please print out appropriate messages
//:
//: d. Call the `alertPassengers()` function on your `DepartureBoard` object below
//:
//: f. Stretch: Display a custom message if the `terminal` is `nil`, tell the traveler to see the nearest information desk for more details.

jfkDepartureBoard.alertPassenger()

//: ## 6. Create a free-standing function to calculate your total airfair for checked bags and destination
//: Use the method signature, and return the airfare as a `Double`
//:
//:     func calculateAirfare(checkedBags: Int, distance: Int, travelers: Int) -> Double {
//:     }
//:
//: a. Each bag costs $25
//:
//: b. Each mile costs $0.10
//:
//: c. Multiply the ticket cost by the number of travelers
//:
//: d. Call the function with a variety of inputs (2 bags, 2000 miles, 3 travelers = $750)
//:
//: e. Make sure to cast the numbers to the appropriate types so you calculate the correct airfare
//:
//: f. Stretch: Use a [`NumberFormatter`](https://developer.apple.com/documentation/foundation/numberformatter) with the `currencyStyle` to format the amount in US dollars.
func calculateAirfare(checkedBags: Int, distance: Int, travelers: Int) -> Double {
    var totalTicketPrice = 0.00
    totalTicketPrice += Double(checkedBags) * 25.00
    totalTicketPrice += Double(distance) * 0.10
    
    return totalTicketPrice * Double(travelers)
}
print(calculateAirfare(checkedBags: 2, distance: 2000, travelers: 3))
print(calculateAirfare(checkedBags: 3, distance: 3000, travelers: 4))
print(calculateAirfare(checkedBags: 4, distance: 4000, travelers: 10))
