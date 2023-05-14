# Tech News Aggregator


## Description

An app that aggregates tech news from different sites and displays them all in one unified news feed. The app should have a list of possible news sites to which the user can subscribe as well as support for multiple users (locally). Each user will be displayed only news from his subscription list. These preferences should be stored using SharedPreferences. The app should also have a welcome screen. (EX. https://feeder.co/knowledge-base/rss-content/rss-lists-popular-and-useful-rss-feeds/)

## Architecture

### Screens
- [ ] WelcomeScreen -  a screen with the logo of the app and some text 
- [ ] SelectUserScreen - a screen where you can create or choose an existing user profile
- [ ] UserSettingsScreen - a screen used for both creating and updating user settings
- [ ] NewsScreen - where all the news will be fetched and parsed and displayed


### User Bloc

#### Events based on flows
- NormalUserFlow: UserSelection, UserFeedDisplay
- FirstEntryFlow: UserSelection, UserCreation, UserSelection, UserFeedDisplay
- UpdateListFlow: UserSelection, UserFeedDisplay, UserUpdateList, UserFeedDisplay


Unique events: 
```json
["UserSelection", "UserFeedDisplay", "UserCreation", "UserUpdateList"]
```

#### States based on events
- SelectUserState - ready to select users from the list
- FetchUserFeedState - actively fetching the RSS feed
- CreateUserState - adding a new user to the list and set of preferences
- UpdateUserState - update the list of user feed sites

### Implementation

#### Shared Preferences
```json
{
    "users": [ "BZV", "Test1", "Test2", "Test3", "Test4" ],
    "BZV": ["Aramco", "F1", "Motorsport", "Hello"],
    "Test1": ["Love","Netflix"]
}
```

#### Restrictions
The application can have up to 5 users

#### Logic

##### First screen display
- If it's first time you enter the application (meaning `users` is empty --> you will be shown a welcome screen)
- If it's not your first time, you will be shown WelcomeScreen and moved after 0.5s to the SelectUserScreen

##### Create User
- If we have less then 5 users, we can add a new one, being a `CreateUser` event dispatched
