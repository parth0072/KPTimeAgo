# KPTimeAgo

<img src="https://img.shields.io/badge/platform-iOS-blue.svg?style=flat" alt="Platform iOS 11" />
<img src="https://img.shields.io/badge/swift4-compatible-green.svg?style=flat" alt="Swift 4 compatible" />
<img src="https://img.shields.io/badge/license-MIT-blue.svg?style=flat" alt="License MIT" />
<a href="https://cocoapods.org/pods/KPTimeAgo"><img src="https://img.shields.io/badge/pod-0.0.3-blue.svg" alt="CocoaPods compatible" /></a>

## CocoaPods Install

Add this to your Podfile.

```
pod 'KPTimeAgo'
```

## Manual Install
Just Drag and drop KPTimeAgo to your project.


## Usage

First Step  - `import KPTimeAgo ` to your project

```
let timeAgo = (Date().formatDateAsTimeAgo()) 
print(timeAgo)
//Just now

Other Example
//August 25 at 10:30 AM
//July 25
//September 25
//July 25, 2022
//October 25
//July 25, 2023


Custom date format 
let timeAgo = KPTimeAgo.init(date: self.dateForComponents { $0.year = +6 }!, yesterdayFormat: nil, lastWeekFormat: nil, lastMonthFormat: nil, otherFormat: "LLLL d, yyyy")
print(timeAgo.formatDateAsTimeAgo())  //August 9, 2026 


```


## Collaboration
Feel free to collaborate with ideas, issues and/or pull requests.


## Contact

* Parth (https://github.com/parth0072)
* Twitter: [@kshatriya_parth](https://twitter.com/kshatriya_parth)
* Email : [Parth](mailto:parth0072@live.com)

## License

KPTimeAgo is released under the [MIT License](http://www.opensource.org/licenses/MIT).

