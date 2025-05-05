importScripts(
  "https://www.gstatic.com/firebasejs/11.6.1/firebase-app-compat.js"
);
importScripts(
  "https://www.gstatic.com/firebasejs/11.6.1/firebase-messaging-compat.js"
);

firebase.initializeApp({
  apiKey: "AIzaSyA7tGsrMXF6I0eSpDkTxVhgHIb-xlQpn_8",
  authDomain: "grabby-babby.firebaseapp.com",
  projectId: "grabby-babby",
  storageBucket: "grabby-babby.firebasestorage.app",
  messagingSenderId: "769541462349",
  appId: "1:769541462349:web:fb5435881e88119db17f04",
  measurementId: "G-0648XTZZBN",
});

const messaging = firebase.messaging();

messaging.onBackgroundMessage(function (payload) {
  console.log("Received background message ", payload);
  const notificationTitle = payload.notification.title;
  const notificationOptions = {
    body: payload.notification.body,
  };
  self.registration.showNotification(notificationTitle, notificationOptions);
});
