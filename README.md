# Memestry
Unit 8 - Group Milestone - README
===

# Memestry

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
A curated ios app for posting & commenting on memes. Users can view others memes and comment on it. 


### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Social Media
- **Mobile:** Uses data from phone camera or gallery.
- **Story:** This app is for anyone who loves to post funny content online. 
- **Market:** Everyone enjoys creativity. People enjoy taking weird pics. This exclusive app enables them to post their pics in a creative way.
- **Habit:** Any social media user would definitely get habituated to this app. New memes makes them laugh, cry or think.
- **Scope:** We have dedicated pages in Instagram, Twitter & Facebook for memes.This app tries to narrow down or given an exclusive platform for people who enjoy memes or funny content on daily basis.


## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**
* User can post a meme
* User can add a caption to a meme
* User can comment a meme
* User can like a meme
* User can view latest 25 from meme feed
* User can view global meme feed


**Optional Nice-to-have Stories**

* User can pull down to refresh
* User can perform infinite scroll
* User can share the meme to Facebook or Twitter (Third-party integration)
* User can use camera to click a photo and use as a meme
* User can generate a meme from a picture
* User can delete the meme post


### 2. Screen Archetypes

* Login screen
   * User can login
* SignUp screen
   * User can create an account
* Forgot Password screen
    * User can give his email to get a temporary password
* Profile screen
    * User can view memes that was previously posted
* Global Feed Screen
    * User can see global feed
* Home Screen
    * User can view a meme 
    * User can view comments
    * User can delete meme
    * User can like a meme
    * User can share a meme (Optional)
    * User can scroll to refresh(Optional)
* Camera Screen
    * User can upload a meme
    * User can add a caption
    * User can post
### 3. Navigation

**Tab Navigation** (Tab to Screen)
* Profile screen
* Global screen
* Home Screen
* Camera Screen


**Flow Navigation** (Screen to Screen)
* Login screen -> Home screen
* SignUp screen -> Home screen
* Global screen -> Feed screen
* Global screen -> Upload screen

### 4. Wireframes
<img src="http://g.recordit.co/o0OKsWGwjx.gif" width=250><br>
#### LOGIN SCREEN
<img src="https://i.imgur.com/cnPToVh.png" width=250><br>
#### SIGNUP SCREEN
<img src="https://i.imgur.com/mVYhyeD.png" width=250><br>
#### GLOBAL FEED SCREEN (COLLECTION VIEW)
<img src="https://i.imgur.com/n34rOBp.png" width=250><br>
#### HOME SCREEN
<img src="https://i.imgur.com/7wtbcV9.png" width=250><br>
#### INTERACTIVE SCREEN
<img src="http://g.recordit.co/zEDvUCynUv.gif" width=250><br>



## Schema 
[This section will be completed in Unit 9]
### Models
#### Reminder

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | Time Zone     | String   | the time zone of the author |
   | Time        | DateTime| time at which the reminder must pop up |
   | Test Reminder         | String    | the reminder message |
   
#### Friends

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | Name    | String   | the name of the friend |
   | Nickname        | String | nickname of the friend |
   | Birthday         | DateTime    | the birthday of the friend |
   | Anniversary         | DateTime    | the anniversary of the friend |
   
### Networking
- [Add list of network requests by screen ]
   - History Screen
      - (Read/GET) Get a list of all reminders
      - (Read/GET) Get a list of all greetings
   - Home Feed Screen
      - (Create/POST) Create a new greeting
      - (Create/POST) Create a new reminder
      - (Read/GET) Get a list of all friends
      - (Read/GET) Get a list of all reminders already set
      - (Read/GET) Get a list of all greetings already set
   - Friends List Screen
      - (Read/GET) Display a list of all friends 
      - (Create/POST) Add a new friend
   - New Friend Screen
      - (Update/PUT) Provide the name
      - (Update/PUT) Provide the nickname
      - (Update/PUT) Provide the date for birthday/anniversary or any other important day
   - Custom design Screen
      - (Create/POST) Create a new custom greeting specifying the name of the receiver, message, and a background image
   - Creation Screen
      - (Create/POST) Create a new birthday greeting
      - (Create/POST) Create a new anniversary greeting
      - (Create/POST) Create a custom greeting
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
