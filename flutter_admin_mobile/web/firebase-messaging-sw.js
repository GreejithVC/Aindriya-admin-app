importScripts('https://www.gstatic.com/firebasejs/8.2.0/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.2.0/firebase-messaging.js');

// Initialize the Firebase app in the service worker by passing the generated config
var firebaseConfig = {
      apiKey: "AIzaSyDDl61GmqvT3Y6NPeZwcNqBKGrQl7XYTkU",
      authDomain: "multisuperstore-bbdc6.firebaseapp.com",
      projectId: "multisuperstore-bbdc6",
      storageBucket: "multisuperstore-bbdc6.appspot.com",
      messagingSenderId: "257084503058",
      appId: "1:257084503058:web:b54bf681634a903eb294cb",
      measurementId: "G-BS8NB43103"
};

firebase.initializeApp(firebaseConfig);

// Retrieve firebase messaging
const messaging = firebase.messaging();

messaging.onBackgroundMessage(function(payload) {
  console.log('Received background message ', payload);

  const notificationTitle = payload.notification.title;
  const notificationOptions = {
    body: payload.notification.body,
  };

  self.registration.showNotification(notificationTitle,
    notificationOptions);
});