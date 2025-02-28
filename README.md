# Drug Information App

The **Drug Information App** is a comprehensive application that provides detailed and up-to-date information on various drugs. Users can search for drug names, view detailed data (including indications, dosage, side effects, and interactions), and access secure features through Firebase Authentication. All drug data is stored in Firestore, ensuring real-time updates and efficient data management.

## Features

- **Drug Search:**  
  Quickly search for drugs by name and view detailed information.
- **Detailed Drug Information:**  
  Access comprehensive details such as uses, side effects, dosage, interactions, and warnings.
- **Firebase Authentication:**  
  Secure login and registration using Firebase Authentication to protect user data.
- **Firestore Integration:**  
  All drug information is stored in Firestore for real-time updates and offline access.
- **Real-time Data Updates:**  
  The app automatically fetches the latest drug data from Firestore.
- **Loading Animations:**  
  Uses shimmer effects and spinning animations to indicate data loading. 

## Dependencies

The app leverages several packages to enhance functionality:

- **firebase_auth:** For handling user authentication.
- **cloud_firestore:** For storing and managing drug data.
- **flutter_spinkit:** For loading animations.
- **pie_chart:** For visualizing data in pie chart format.
- **shimmer:** For creating a shimmer effect during data loading.
- **http:** For making API requests (if applicable).

## Installation

### Prerequisites

- **Flutter SDK** installed on your machine.
- A configured Firebase project with Authentication and Firestore enabled.

### Steps

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/RehmanSiddique/Drug-Information.git
   cd Drug-Information
