const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

const database = admin.firestore();
 
exports.checkForBookTransition = functions.pubsub.schedule('every 60 minutes').onRun(async (context) => {

    const query = await database.collection("groups")
    .where("currentBookDue",'<=', admin.firestore.Timestamp.now())
    .get();

    query.forEach(async eachGroup => {     
        
        // find the next index
        var currentIndex = eachGroup.data()["indexPickingBook"];
        var totalMembers = eachGroup.data()["members"].length;
        var nextIndex;
        
        if (currentIndex >= (totalMembers - 1)) {
            nextIndex = 0;
        } else {
            nextIndex = currentIndex + 1;
        }

         await database.doc('groups/'+ eachGroup.id).update({
            "currentBookDue": eachGroup.data()["nextBookDue"],
            "currentBookId": eachGroup.data()["nextBookId"],
            "nextBookId": "waiting",
            "indexPickingBook": nextIndex,
        })
    })
})

exports.onCreateNotification = functions.firestore.document("/notifications/{notificationDoc}").onCreate(async (notifSnapshot, context) => {
    var tokens = notifSnapshot.data()['tokens'];
    var bookName = notifSnapshot.data()['bookName'];
    var author = notifSnapshot.data()['author'];

    var title = `Next Book Announced!`;
    var body = `Next book is ${bookName} by ${author}`;

    tokens.forEach(async eachToken => {
        const message = {
            notification: { title: title, body: body },
            token: eachToken,
            data: { click_action: 'FLUTTER_NOTIFICATION_CLICK' },
        }

        admin.messaging().send(message).then(response => {
            return console.log("Notification Succesful");
        }).catch(error => {
            return console.log("Error: " + error);
        });
    });
})
