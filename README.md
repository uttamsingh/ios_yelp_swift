
# CodePath Course Week 2 Project: Yelp

**Yelp Client** is a Yelp search app using the [Yelp API](http://www.yelp.com/developers/documentation/v2/search_api).

Time spent: **20** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] Search results page
- [x] Table rows should be dynamic height according to the content height.
- [x] Custom cells should have the proper Auto Layout constraints.
- [x] Search bar should be in the navigation bar (doesn't have to expand to show location like the real Yelp app does).
- [x] Filter page. Unfortunately, not all the filters are supported in the Yelp API.
- [x] The filters you should actually have are: category, sort (best match, distance, highest rated), distance, deals (on/off).
- [x] The filters table should be organized into sections as in the mock. This story is not fully completed as I am yet to change code for collapsable view
- [x] You can use the default UISwitch for on/off states.
- [x] Clicking on the "Search" button should dismiss the filters page and trigger the search w/ the new filter settings. APart from distance all other three selection should provide the result
- [x] Display some of the available Yelp categories (choose any 3-4 that you want).

The following **optional** features are implemented:

- [x] Search results page
- [x] Filter page

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Refactoring of code is required as I have not used enums effectively 
2. Missed implementing almost all of the optional feature, I spend lot of time designing custom switch which didn't work'

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='https://github.com/uttamsingh/ios_yelp_swift/blob/master/yelp.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## License

Copyright [2017] [Uttam SIngh]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
