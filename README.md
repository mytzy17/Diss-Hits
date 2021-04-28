# Diss-Hits
Original App Design Project - README Template
===

# Diss-Hits 

### Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
An app where new/underground artists can upload their music without the algorithm getting in the way and people can discover their music. This space will allow users to browse a library of artists who are registered within the app. They can save music to playlist and "like" music. 

### App Evaluation
- **Category:** Music Streaming 
- **Mobile:** Yes 
- **Story:** An app where new/underground artists can upload their music without the algorithm getting in the way 
- **Market:** Listeners, artists, new/undergound artists 
- **Habit:** Daily use 
- **Scope:** 

## Product Specs

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

*  **Users** 
    * - [X] Login / Stay Logged In
    * - [X] Logout
    * - [X] Create an account
    * - [X] Build bio 
    * - [ ] Genre 
    * - [ ] Account info 
           * username 
           * email 
           * birthdate 
        
* **Playlist** 
    * - [ ] a place to upload songs 
        * file size concern?
    * - [ ] conditionals 
           * explicit 
           * lyrics 
           * cover / art 
           * instrument 
               * limit the instruments: 5 max 
               * check box - all that apply 

* **search bar**  
    * - [ ] search by genre 
    * - [X] search by title 
    * - [ ] search by artist name 
    * - [ ] search by lyrics 
    * - [ ] search by instrument

* **home page** 
    * - [ ] display existing playlist 
    * - [ ] categories by genre 
         * prompts the user to start listening and create new playlists 
     
* **current song playing** 
    * - [ ] user can add curent song to specific playlist 
    * - [ ] double tap to like
         * this adds the song to "liked" playlist 


---


**Optional Nice-to-have Stories**

* *counter for times song has been played*
* *explore mode vs. currated mode - toggle switch*
* *delete songs form playlists*


### 2. Screen Archetypes

* Login
   *  to home
   * navigation bar on every page 
* Profile
   * logout   
   * back to login screen
 * Playlist 
     * saved playlist 
     * liked songs

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* [Home]
* [Playlists]
* [Liked songs]
* [Search]
* [User Profile]
    * where they can logout 
    * change bio (if artist)

**Flow Navigation** (Screen to Screen)

* [Login]
   * Log in as User or Artist  
   * modal login type corresponds to user input
   * Login succesful
 
* [Home]
   * [Genres]
   * [Existing Playlist]
  
 
* [Search]
   * user can select what to search by in a dropdown:
        * genre 
        * title 
        * Artist name

* [Playlist]
   * list of existing playlist will display here
   * user can open playlist 
       * play it / shuffle it 

## Wireframes
[Miro Board: Wireframes](https://miro.com/app/board/o9J_lPfTTs8=/)

[Add picture of your hand sketched wireframes in this section]
<img src="https://i.ibb.co/Fx30GJk/Screen-Shot-2021-03-24-at-5-47-35-PM.png" width=600>

### [BONUS] Digital Wireframes & Mockups
<img src="https://i.ibb.co/0qqN2Vk/Screen-Shot-2021-03-23-at-6-49-51-PM.png" width=200>

### [GIF] Sprint Plan 1
<img src="http://g.recordit.co/KvncSVRtc5.gif" width=200>

### [GIF] Sprint Plan 2
<img src="http://g.recordit.co/ortX5a1AjM.gif" width=200>
<img src="http://g.recordit.co/BOjXTUjXj1.gif" width=200>

### [GIF] Sprint Plan 3
<img src="http://g.recordit.co/0j3dfA5ZAO.gif" width=200>
<img src="https://media0.giphy.com/media/nZ2J1ZWiTcCywhDJCT/giphy.gif" width=200>

# Schema 
## Models
### User
| Property      | Type   | Description                  |
| :------------ |:------ | :----------------------------|
| Name          | string | The artist's name.           |
| ID_user       | int    | Unique identifier for artist.|
| Password      | string | A password for the user.     |

### Song
| Property      | Type         | Description                  |
| :------------ |:------------ | :--------------------------- |
| Name          | string       | The song's name.             |
| ID_Song       | int          | Unique identifier for artist.|
| File          | file         | The sound file of the song.  |
| Lyrics        | string       | Lyrics for the song.         |


### Author 
| Property      | Type   | Description                        |
| :------------ |:------ | :--------------------------------- |
| Name          | string | The artist's name.                 |
| ID_author     | int    | Unique identifier for artist.      |
| Password      | string | A password for the user.           |
| Genre         | string | Author given identifier for music. |

# Networking
* Create Account*
   * (Read/GET) Query for name and password
   * (Create/POST) Create a new user 
   * (Create/POST) Create a new Author 
* Homescreen*
   * (Read/GET) Query for a song
* *Artist Upload
   * (Create/POST) Create a new song, add lyrics
   * (Update/PUT) Update song file or lyrics

### Contributions 
    
* **Listener** 
    * Gabriel Cano-Sandoval
    * Julio Aguirre 
    * Jose Morado
    * Diana Garcia Davalos
    * Anthony Herrera
* **Data input**
    * Jacob Fahy
    * Cassandra Cabrera
* **Artist**
    * Jesus Caballero
    * Jonathan Quintero
    * Jesus Gomez
    * Mytzy Escalante
    * Misael Guijarro
    * Kevin Piffero
    * Jennifer Lopez
    * Jose Alfaro
