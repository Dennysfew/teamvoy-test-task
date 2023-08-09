# News Explorer iOS App


News Explorer is an iOS client app that allows users to explore and read news articles from various sources. This README provides an overview of the app's features, requirements, and how to get started.

## Table of Contents
- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [APIs](#apis)

## Features

1. **View List of Articles**
   - Display a list of articles, each showing the title and description.
   - Users can sort articles based on available parameters.
   - Endpoint: `GET /everything`

2. **View Detailed Article Information**
   - Users can select an article from the list to view detailed information.
   - Detailed information includes all the article.

3. **Search Articles**
   - Users can search for articles using keywords.
   - Users can filter articles for a specific time period.

## Requirements

- iOS 15.0+
- Swift 5.7+
- iPhone only
- Portrait device orientation
- SwiftUI

## Installation

1. Clone this repository to your local machine using:
https://github.com/Dennysfew/teamvoy-test-task.git

2. Open the project in Xcode.

3. Generate your API key by following the steps in the [NewsAPI documentation](https://newsapi.org/docs).
- Insert your API key in the appropriate place in the app code.

## Usage

1. Launch the app on your iOS device.
2. Browse through the list of articles on the main screen.
3. Tap on an article to view detailed information.
4. Use the search feature to find articles based on keywords or time period.

## APIs

The app utilizes the [NewsAPI](https://newsapi.org/) to fetch news articles.
- Base URL: `https://newsapi.org/v2`
- Documentation: [NewsAPI Documentation](https://newsapi.org/docs)
