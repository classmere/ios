# Classmere for iOS 
Finding classes that interest you, help you graduate and fit your schedule
can be a pain. Classmere's iPhone app helps Oregon State students search for
cool classes and manage their courseload.

![app screenshots](https://raw.githubusercontent.com/classmere/ios/master/Classmere.png)

### Meta
- **State:** pre-production
- **Point People:** [@rutgerfarry](https://github.com/rutgerfarry), [@brandonlee503](https://github.com/brandonlee503)
- **CI:** [![Build Status](https://travis-ci.org/classmere/ios.svg?branch=master)](https://travis-ci.org/classmere/ios)

## Installation
First, ensure you have Xcode installed from the App Store, then run the
following two commands to install the Xcode command line tools and `bundler`
if you haven't dont so already.

```bash
gem install bundler
xcode-select --install
```

The following commands will set up and launch Classmere, assuming `bundler`
and Xcode are installed. You will be prompted for a Google Maps API key. If
you don't have one, just type something in and the app will run, but the maps
won't show any features.

```bash
git clone https://github.com/classmere/ios.git
cd ios
bundle install
bundle exec fastlane keys
open Classmere.xcworkspace
```
