# Project 2 - Twitter

Twitter is a basic twitter app to read and compose tweets the [Twitter API](https://apps.twitter.com/).

Time spent: 20 hours spent in total

## User Stories

The following **core** features are completed:

**A user should**

- [x] See an app icon in the home screen and a styled launch screen
- [x] Be able to log in using their Twitter account
- [x] See at latest the latest 20 tweets for a Twitter account in a Table View
- [x] Be able to refresh data by pulling down on the Table View
- [x] Be able to like and retweet from their Timeline view
- [x] Only be able to access content if logged in
- [x] Each tweet should display user profile picture, username, screen name, tweet text, timestamp, as well as buttons and labels for favorite, reply, and retweet counts.
- [x] Compose and post a tweet from a Compose Tweet view, launched from a Compose button on the Nav bar.
- [x] See Tweet details in a Details view
- [x] App should render consistently all views and subviews in recent iPhone models and all orientations

The following **stretch** features are implemented:

**A user could**

- [x] Be able to **unlike** or **un-retweet** by tapping a liked or retweeted Tweet button, respectively. (Doing so will decrement the count for each)
- [ ] Click on links that appear in Tweets
- [ ] See embedded media in Tweets that contain images or videos
- [x] Reply to any Tweet (**2 points**)
  - Replies should be prefixed with the username
  - The `reply_id` should be set when posting the tweet
- [x] See a character count when composing a Tweet (as well as a warning) (280 characters) (**1 point**)
- [ ] Load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client
- [x] Click on a Profile image to reveal another user's profile page, including:
  - Header view: picture and tagline
  - Basic stats: #tweets, #following, #followers
- [ ] Switch between **timeline**, **mentions**, or **profile view** through a tab bar (**3 points**)
- [ ] Profile Page: pulling down the profile page should blur and resize the header image. (**4 points**)

The following **additional** features are implemented:

- [x] Compose/reply to tweets view displays user profile picture

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. I'd be interested in learning how to implement the infinite scroll, discussing details such as how that data is stored and, if there exist multiple ways,
 perhaps which is most optimal or what advantages different methods have compared to each other.
2. I would also like to learn about better ways to use classes and their methods. For example, perhaps we can implement a super class for composing tweets 
 and replying to tweets to reduce the among of repeated code.

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='https://submissions.us-east-1.linodeobjects.com/metau_ios/eV69EPNx.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
<img src='https://submissions.us-east-1.linodeobjects.com/metau_ios/C4efRrc6.gif' title='Video Walkthrough2' width='' alt='Video Walkthrough' />

Part 1: https://submissions.us-east-1.linodeobjects.com/metau_ios/eV69EPNx.gif
Part 2: https://submissions.us-east-1.linodeobjects.com/metau_ios/C4efRrc6.gif

GIF created with [Kap](https://getkap.co/).

## Notes

Describe any challenges encountered while building the app.

There were many small details that were difficult to implement. For example, when a user likes a post in the details view, that like should display as well
in the timeline. It took a while working with delegates and the table view to determine how best to update and then display that information. It was also
a bit difficult understanding the concepts and syntax of the APIManager and delegates, but after applying them in various places in this project, I believe 
that I have a better understanding of them now.

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library
- [DateTools](https://github.com/MatthewYork/DateTools) - date and time handling
- [UITextView+Placeholder](https://github.com/devxoul/UITextView-Placeholder) - A missing placeholder for UITextView

## License

    Copyright 2022 Kathy Zhong

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
