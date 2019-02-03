# BitLeague

A QHacks 2019 project!

Built by:

- Ricky Zhang ([@RickyZhangCA](https://github.com/RickyZhangCA)): Design
- Mat Schmid ([@schmidyy](https://github.com/schmidyy)): iOS
- Ozzie Kirkby ([@kirkbyo](https://github.com/kirkbyo)): iOS

----

| Login | Snap Auth | Home Feed | Image Capture |
| ---- | ---- | ---- | ---- |
| ![img_7734](https://user-images.githubusercontent.com/22358682/52177478-50263a80-278f-11e9-926f-73c3e94fc5a7.PNG) | ![img_7735](https://user-images.githubusercontent.com/22358682/52177481-5ddbc000-278f-11e9-9587-8a72b1730f9c.PNG) | ![img_7736](https://user-images.githubusercontent.com/22358682/52177486-76e47100-278f-11e9-8d2c-ffa54b831d59.PNG) | ![img_7737](https://user-images.githubusercontent.com/22358682/52177519-e8242400-278f-11e9-9427-5eecb01fbac0.PNG) |

## Inspiration

Everybody likes Bitmojis - so we wanted to game-ify recreating them!

## What it does

BitLeague lets you **create, browse, and vote** on community recreations of Bitmojis 

## How we built it

We kicked off by rapidly brainstorming and sketching out the user interface together. The rough draft is validated and tuned into prototype in Adobe XD. 

We then starting to design a high fidelity interface and building the prototype natively in iOS. We used SnapKit to authenticate the Snapchat login and fetch the Bitmojis. Through the SnapKit API, we used GraphQL to fetch user data from Snapchat and SnapKit-provided SDKs for presenting the Bitmoji picker. 

<a href="https://imgur.com/aDFvX61"><img src="https://i.imgur.com/aDFvX61.png" title="source: imgur.com" /></a>

We also used Firebase Storage and Firestore as our serverless cloud service. This is used to catalogue all of the posts and store the images taken. 

## Challenges we ran into

- **Task Management**: We noticed that building an app from scratch requires dividing our time onto all areas including design, front end, and back end. So we soon decided to execute tasks in parallel to maximize our output. For example, UI deisgn was done while the database was being built. With the help of efficient communication, we managed to wrap BitLeague up on time. 

- **Development**:  With two iOS developers working on the same project, merge conflicts were inevitable. Xcode merge conflicts are notoriously tricky to debug, so a lot time went towards resolving those. This app also used technologies neither of us were familiar with before today, like the SnapKit API and capturing images using the device's camera. 

## What's next for BitLeague 
Snap. Acquisition.
