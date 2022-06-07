import UIKit

func searchActivityURL(participants: Int, type: String) -> URL {
    var url = URLComponents()
    url.host = "www.boredapi.com"
    url.scheme = "http"
    url.path = "/api/activity"
    url.queryItems = [
        URLQueryItem(name: "participants", value: String(participants)),
        URLQueryItem(name: "type", value: type)
    ]
    return URL(string: url.string!)!
}

let testURL = searchActivityURL(participants: 2, type: "education")
print(testURL)
