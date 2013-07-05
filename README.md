#AKSegmentedControl

AKSegmentedControl is a fully customizable Segmented Control for iOS

##Preview
![preview](https://github.com/alikaragoz/AKSegmentedControl/raw/master/screenshots/aksegmentedcontrol-screenshot.png)

##Usage

###Installation
Add the dependency to your `Podfile`:

```ruby
platform :ios

pod 'AKSegmentedControl'
```
Run `pod install` to install the dependencies.

or copy the two files that are in the AKSegmentedControl folder ([`AKSegmentedControl.h`](https://github.com/alikaragoz/AKSegmentedControl/blob/master/ASegmentedControl/AKSegmentedControl.h) and [`AKSegmentedControl.m`](https://github.com/alikaragoz/AKSegmentedControl/blob/master/ASegmentedControl/AKSegmentedControl.m)).

Next, import the header file wherever you want to use the tab bar controller:

```objc
#import "AKSegmentedControl.h"
```

### Usage
```objc

// Initialization of the segmented control
AKSegmentedControl *segmentedControl = [[AKSegmentedControl alloc] initWithFrame:aRect]
[segmentedControl addTarget:self action:@selector(segmentedControlValueChanged:) forControlEvents:UIControlEventValueChanged];

// Setting the resizable background image
UIImage *backgroundImage = [[UIImage imageNamed:@"segmented-bg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0)];
[segmentedControl setBackgroundImage:backgroundImage];

// Setting the content edge insets to adapte to you design
[segmentedControl setContentEdgeInsets:UIEdgeInsetsMake(2.0, 2.0, 3.0, 2.0)];

// Setting the behavior mode of the control
[segmentedControl setSegmentedControlMode:AKSegmentedControlModeSticky];

// Setting the separator image
[segmentedControl setSeparatorImage:[UIImage imageNamed:@"segmented-separator.png"]];

UIImage *buttonBackgroundImagePressedLeft = [[UIImage imageNamed:@"segmented-bg-pressed-left.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 4.0, 0.0, 1.0)];
UIImage *buttonBackgroundImagePressedCenter = [[UIImage imageNamed:@"segmented-bg-pressed-center.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 4.0, 0.0, 1.0)];
UIImage *buttonBackgroundImagePressedRight = [[UIImage imageNamed:@"segmented-bg-pressed-right.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 1.0, 0.0, 4.0)];

// Button 1
UIButton *buttonSocial = [[UIButton alloc] init];
UIImage *buttonSocialImageNormal = [UIImage imageNamed:@"social-icon.png"];

[buttonSocial setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 5.0)];
[buttonSocial setBackgroundImage:buttonBackgroundImagePressedLeft forState:UIControlStateHighlighted];
[buttonSocial setBackgroundImage:buttonBackgroundImagePressedLeft forState:UIControlStateSelected];
[buttonSocial setBackgroundImage:buttonBackgroundImagePressedLeft forState:(UIControlStateHighlighted|UIControlStateSelected)];
[buttonSocial setImage:buttonSocialImageNormal forState:UIControlStateNormal];
[buttonSocial setImage:buttonSocialImageNormal forState:UIControlStateSelected];
[buttonSocial setImage:buttonSocialImageNormal forState:UIControlStateHighlighted];
[buttonSocial setImage:buttonSocialImageNormal forState:(UIControlStateHighlighted|UIControlStateSelected)];
    
// Button 2
UIButton *buttonStar = [[UIButton alloc] init];
UIImage *buttonStarImageNormal = [UIImage imageNamed:@"star-icon.png"];
    
[buttonStar setBackgroundImage:buttonBackgroundImagePressedCenter forState:UIControlStateHighlighted];
[buttonStar setBackgroundImage:buttonBackgroundImagePressedCenter forState:UIControlStateSelected];
[buttonStar setBackgroundImage:buttonBackgroundImagePressedCenter forState:(UIControlStateHighlighted|UIControlStateSelected)];
[buttonStar setImage:buttonStarImageNormal forState:UIControlStateNormal];
[buttonStar setImage:buttonStarImageNormal forState:UIControlStateSelected];
[buttonStar setImage:buttonStarImageNormal forState:UIControlStateHighlighted];
[buttonStar setImage:buttonStarImageNormal forState:(UIControlStateHighlighted|UIControlStateSelected)];
    
// Button 3
UIButton *buttonSettings = [[UIButton alloc] init];
UIImage *buttonSettingsImageNormal = [UIImage imageNamed:@"settings-icon.png"];
    
[buttonSettings setBackgroundImage:buttonBackgroundImagePressedRight forState:UIControlStateHighlighted];
[buttonSettings setBackgroundImage:buttonBackgroundImagePressedRight forState:UIControlStateSelected];
[buttonSettings setBackgroundImage:buttonBackgroundImagePressedRight forState:(UIControlStateHighlighted|UIControlStateSelected)];
[buttonSettings setImage:buttonSettingsImageNormal forState:UIControlStateNormal];
[buttonSettings setImage:buttonSettingsImageNormal forState:UIControlStateSelected];
[buttonSettings setImage:buttonSettingsImageNormal forState:UIControlStateHighlighted];
[buttonSettings setImage:buttonSettingsImageNormal forState:(UIControlStateHighlighted|UIControlStateSelected)];
    
// Setting the UIButtons used in the segmented control
[segmentedControl setButtonsArray:@[buttonSocial, buttonStar, buttonSettings]];

// Adding your control to the view
[viewController.view addSubview:segmentedControl];
```
This segmented control is a subclass of UIControl and you just need to add a target if you want to trigger a method:
```objc
// Adding a target
[segmentedControl addTarget:self action:@selector(segmentedControlTouched:) forControlEvents:UIControlEventValueChanged];
```

Check the example project for further details.

##Requirements
- iOS >= 4.3
- ARC

## Contact

Ali Karagoz

- http://github.com/alikaragoz
- http://twitter.com/alikaragoz

## License

AKSegmentedControl is available under the MIT license. See the LICENSE file for more info.
