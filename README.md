# Drug Information App

The **Drug Information App** is a comprehensive application that provides detailed and up-to-date information on various drugs. Users can search for drug names, view detailed data (including indications, dosage, side effects, and interactions), and access secure features through Firebase Authentication. All drug data is stored in Firestore, ensuring real-time updates and efficient data management.
<img src="https://github.com/user-attachments/assets/69b2394c-c734-42c4-8eaf-ac647a3a2fb4" alt="Image" width="190" />
<img src="https://github.com/user-attachments/assets/05230d21-edb3-46b9-9715-7f2f405c3b41" alt="Image" width="190" />
<img src="https://github.com/user-attachments/assets/cede36cd-8cd0-484f-a434-e5cf87f9dd33" alt="Image" width="190" />
<img src="https://github.com/user-attachments/assets/fa0b7d48-a704-408a-961a-91fb0cdc5c31" alt="Image" width="190" />
<img src="https://github.com/user-attachments/assets/1dbfa527-e2bf-489b-97f8-422b766ae3da" alt="Image" width="190" />
<img src="https://github.com/user-attachments/assets/b1bd84b2-64f3-4a82-8272-3e6b7e0572d9" alt="Image" width="190" />
<img src="https://github.com/user-attachments/assets/92e76dee-3c27-492a-b9fb-c02f2e2a3f52" alt="Image" width="190" />
<img src="https://github.com/user-attachments/assets/686ba2f8-1cf4-4e06-974a-74cf27bedc04" alt="Image" width="190" />
<img src="https://github.com/user-attachments/assets/454085cb-ceed-4d32-864a-8a1a35777c44" alt="Image" width="190" />
<img src="https://github.com/user-attachments/assets/9cc5bcbc-5cf6-40a9-94ed-524a73498899" alt="Image" width="190" />

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
