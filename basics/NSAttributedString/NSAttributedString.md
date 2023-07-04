## NSAttributedString

- Used to format and style strings in a varity of ways

Examples:

#### Example 1: Changing Text Color and Font
```
let attributedString = NSAttributedString(string: "Hello, World!", attributes: [
    .foregroundColor: UIColor.red,                   // Set text color to red
    .font: UIFont.boldSystemFont(ofSize: 16)        // Set font to bold with size 16
])
```

#### Example 2: Adding Underline and Background Color
```
let attributedString = NSAttributedString(string: "OpenAI", attributes: [
    .underlineStyle: NSUnderlineStyle.single.rawValue,    // Add underline
    .backgroundColor: UIColor.yellow                     // Set background color to yellow
])
```

#### Example 3: Adjusting Kerning and Paragraph Spacing
```
let paragraphStyle = NSMutableParagraphStyle()
paragraphStyle.alignment = .center
paragraphStyle.lineSpacing = 8.0

let attributedString = NSAttributedString(string: "Welcome to ChatGPT!", attributes: [
    .kern: 1.5,                                        // Adjust letter spacing
    .paragraphStyle: paragraphStyle                     // Apply paragraph style
])
```

#### Example 4: Applying Multiple Attributes to Different Ranges

```
let attributedString = NSMutableAttributedString(string: "Hello, World!")
attributedString.addAttribute(.foregroundColor, value: UIColor.blue, range: NSRange(location: 0, length: 5))        // Set color for "Hello"
attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 16), range: NSRange(location: 7, length: 5))   // Set bold font for "World"
```

#### Example 5:
```
// First label
let quote = "Dusty loves food!"
let firstAttributes: [NSAttributedString.Key: Any] = [.backgroundColor: UIColor.green, NSAttributedString.Key.kern: 10]
let secondAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]

let firstString = NSMutableAttributedString(string: "Dusty", attributes: firstAttributes)
let secondString = NSAttributedString(string: "loves ", attributes: secondAttributes)
let thirdString = NSAttributedString(string: "food!")

firstString.append(secondString)
firstString.append(thirdString)

// Second label

let label = UILabel()
label.attributedText = firstString

let attributedString = NSMutableAttributedString(string: "Dusty is the cutest pup in the world. He is a mini goldendoodle and loves to eat!")
attributedString.addAttribute(.link, value: "https://www.apple.com", range: NSRange(location: 0, length:5))

let label2 = UILabel()
label2.attributedText = attributedString
```

<img src="https://github.com/cs4372/ios-study-guide/blob/master/basics/NSAttributedString/NSAttributedString.png" />

Resources:
- [Formatting strings with NSAttributedString](https://www.hackingwithswift.com/read/24/4/formatting-strings-with-nsattributedstring)
- [Attributed Strings with SwiftUI](https://swiftui-lab.com/attributed-strings-with-swiftui/)