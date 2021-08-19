importScripts("https://www.gstatic.com/firebasejs/8.6.1/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.6.1/firebase-messaging.js");

firebase.initializeApp({
 apiKey: "AIzaSyABZw2mrjqSEFoVvmxGMQr6hUqoC3rpVeo",
 authDomain: "flutter-example-3e6b8.firebaseapp.com",
 projectId: "flutter-example-3e6b8",
 storageBucket: "flutter-example-3e6b8.appspot.com",
 messagingSenderId: "777486055736",
 appId: "1:777486055736:web:8983a1e0f840c0882769cd",
 measurementId: "G-LN01BQRMM8"
});
// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
  console.log("onBackgroundMessage", m);
});