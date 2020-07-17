const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.myFunction = functions.firestore
    .document('chat/{message}')
    .onCreate((snapshot, context) => {
        const newValue = snapshot.data();
        return admin.messaging().sendToTopic('chat', { notification: { title: newValue.userName, data: newValue, text,clickAction: 'FLUTTER_NOTIFICATION_CLICK' } });
    });