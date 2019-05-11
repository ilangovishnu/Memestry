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
- [x] User can login
- [x] User can logout
- [x] User can create account
- [x] User can navigate
- [x] User can set profile picture
- [x] User data stored in Firebase
- [x] User can post a meme
- [x] User can add a caption to a meme
- [x] User can comment a meme
- [x] User can like a meme
- [x] User can view latest 25 from meme feed
- [x] User can view global meme feed


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
### Models
#### Post

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the user post (default field) |
   | author        | Pointer to User| image author |
   | image         | File     | image that user posts |
   | caption       | String   | image caption by author |

### Networking
#### List of network requests by screen
   - Profile Screen
      - (Read/GET) Query all memes where user is author
      - (Create/POST) Create a new like on a meme
      - (Delete) Delete existing like
      - (Create/POST) Create a new comment on a meme
   - Camera Screen
      - (Create/POST) Create a new meme object
      - (Create/POST) Create a caption for a meme
   - Global Feed Screen
      - (Read/GET) Query all memes by various users
      - (Create/POST) Create a new like on a meme
      - (Delete) Delete existing like
      - (Create/POST) Create a new comment on a meme


