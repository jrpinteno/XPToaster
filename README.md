# XPToaster
A simple and easy to use class to show toast notifications from anywhere in your application.

## Usage
```
[XPToaster toastMessage:@"I'm a toast"];

[XPToaster toastMessage:@"Another toast with completion"
               duration:1.5
                   type:XPToastTypeInfo
             completion:^(BOOL didTap) {

    if (didTap) {
        NSLog(@"Toast was tapped");
    } else {
        NSLog(@"Toast hide on its own");
    }
}];
```

## Styling
Currently style is global and applies for any next toast after it's set. For the time being, it's only possible
to set custom font, text color, and toast background color.

```
[[XPToast toastCenter] setFont:font];
[[XPToast toastCenter] setTextColor:textColor];
[[XPToast toastCenter] setBackgroundColor:backgroundColor];
```

By default, background color is `[[UIColor blackColor] colorWithAlphaComponent:0.4];`

## TODO
* Better support for styling
* More toast types
* Support image in toast
* Show more than one toast at once?
