const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

const database = admin.firestore();
 
exports.checkForBookTransition = functions.pubsub.schedule('every 1 minute').onRun(async (context) => {

    // write our function logic here.

    const query = await database.collection("groups").where("currentBookDue", '<=', admin.firestore.Timestamp.now())
    .get();

    query.forEach(async group => {
        
        await database.doc('groups/'+ group.id).update({
            "currentBookDue": group.data()["nextBookDue"],
            "currentBookId": group.data()["nextBookId"],
            "nextBookId": "waiting"
        });
    })
})
