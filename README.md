# ViewStyles
![build status](https://www.bitrise.io/app/0504e0926436be28.svg?token=yeBWSS4w3xaq7MVpJBFOeA) [![codecov](https://codecov.io/gh/swarmnyc/ViewStyles/branch/master/graph/badge.svg)](https://codecov.io/gh/swarmnyc/ViewStyles)  



An exploration in better management of view styles when creating views programmatically in iOS, with the goal of simplicity and reusability. And a larger goal of being able to export styles directly from Sketch. Because of this larger goal the view properties that are focused on are those that have a matching option in Sketch.
 



Generally when writing view code our files will fill up with blocks like this:  
```swift
lazy var nextButton: UILabel = {
        var label = UILabel()
        label.text = "Next"
        label.textAlignment = .center
        label.font = Configuration.fonts.title
        label.textColor = .white
        label.layer.borderColor = UIColor.white.cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 10
        label.isUserInteractionEnabled = true
        return label
    }()
```
As the app grows duplicate view style code pops up doing the same thing in different views. It clutters your views, is pretty verbose, and hard to change. It is easy to forget to update a view here or there when designs change. Here is the same label using ViewStyles:

```swift
struct ButtonStyle: TextStyle {
    public var font: UIFont = Configuration.fonts.title
    var border: ViewBorder? = ViewBorder(width: 1, color: .white)
    var color: UIColor = .white
    var cornerRadius: CGFloat = 10
    var alignment: NSTextAlignment = .left
}


lazy var nextButton = ButtonStyle.getLabelWithStyle(withText: "Next",
scaleForScreenSize: false)
.actAsButton()

```
Doing it this way allows you to resuse view styles without subclassing and allows you to write view styling code once per style.

- `scaleForScreenSize` allows you to define styles for a particular screen size (using the `designScreenSize` property in TextStyle) and then will automatically scale the font to fit on the current size.

- `actAsButton` is defined in a UILabel extension and just sets `isUserInteractionEnabled` to true and returns the label


Say we want to add a previous button that looks the same as the next button. It is easy to do now.

```swift
lazy var previousButton = ButtonStyle.getLabelWithStyle(withText: "Previous",
scaleForScreenSize: false)
.actAsButton()
```

Sometimes you will want to set up styling/set properties on the view that aren't supported directly by TextStyle, if that is the case you case you can use `overrideStyles` on the view or define set up blocks in the TextStyle definition (`labelSetUpBlock`, `textViewSetUpBlock`, or `textFieldSetUpBlock`):

```swift
lazy var previousButton = ButtonStyle.getLabelWithStyle(withText: "Previous",
scaleForScreenSize: false)
.actAsButton()
.overrideStyles({ view in 
	let tap = UITapGestureRecognizer(target: self, action: #selector(View.tapped))
	view.addGestureRecognizer(tap)
})

/////// OR ///////

struct ButtonStyle: TextStyle {
    public var font: UIFont = Configuration.fonts.title
    var border: ViewBorder? = ViewBorder(width: 1, color: .white)
    var color: UIColor = .white
    var cornerRadius: CGFloat = 10
    var alignment: NSTextAlignment = .left
    var labelSetUpBlock: ((inout UILabel) -> Void)? = { label in 
    		label.lineBreakMode = .byWordWrapping
    }
}

lazy var previousButton = ButtonStyle.getLabelWithStyle(withText: "Previous",
scaleForScreenSize: false)
.actAsButton()

```

Othertimes you will want to override styles defined in the TextStyle. You can do that by using the `overrideStyles` parameter in the init

```swift
lazy var previousButton = ButtonStyle.getLabelWithStyle(withText: "Previous",
scaleForScreenSize: false,
overrideStyles: { styles in 
	style.isUppercased = true
})
```

- `isUppercased` will transform the text passed in and make it all uppercase.



For every TextStyle you define you are able to create a UILabel, a UITextView, and a UITextField from it

```swift
ButtonStyle.getLabelWithStyle(withText: "Previous",
scaleForScreenSize: false)
//returns a UILabel

ButtonStyle.getTextViewWithStyle(withText: "Previous",
scaleForScreenSize: false)
//returns a UITextView

ButtonStyle.getTextFieldWithStyle(withText: "Previous",
scaleForScreenSize: false)
//returns a UITextField
```


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- Swift 3
- iOS 8.2 and up

## Installation

```ruby
pod "ViewStyles", :git => 'https://github.com/swarmnyc/ViewStyles'
```

## Author

ahartwel, hartwellalex@gmail.com

## License

SWRMViews is available under the MIT license. See the LICENSE file for more info.
