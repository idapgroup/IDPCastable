## IDPCastable

IDPCastable is a chainable casting type used to avoid excessive iflets and guards, whe you are working with multiple unrelated types expected under a single variable.

You can read more about casting and how it helps you simplify the code in blogposts: [Type Inference](http://blog.idapgroup.com/type-inference/), [Chainable Casting](http://blog.idapgroup.com/chainable-casting/)

A perfect example is a UITableView presenting different cells without common protocol.
Code, in the way it's usually written:
```swift
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let identifier = (indexPath.row % 2) == 0 ? "GrayCell" : "PinkCell"

    let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    if let pinkCell = cell as? PinkCell {
        pinkCell.fill(withModel: indexPath.row)
    }

    if let grayCell = cell as? GrayCell {
        grayCell.fill(withModel: "row = \(indexPath.row), column = \(indexPath.section)")
    }

    return cell
}
```

Code using IDPCastable:
```swift
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = (indexPath.row % 2) == 0 ? "GrayCell" : "PinkCell"

        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)

        return castable(cell) { (c: PinkCell) in
                c.fill(withModel: indexPath.row)
            }
            .match { (c: GrayCell) in
                c.fill(withModel: "row = \(indexPath.row), column = \(indexPath.section)")
            }
            .extract()
    }
```

## Example

To run the example project, clone the repo, and run `pod install` from the Tests/iOS directory first.

## Requirements

Swift 3.0

## Installation

IDPCastable is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "IDPCastable"
```

## Author

Oleksa 'trimm' Korin, oleksandr.korin@idapgroup.com

## License

IDPCastable is available under the New BSD license. See the LICENSE file for more info.
