// https://medium.com/@devesu/how-to-upload-data-to-firebase-firestore-cloud-database-63543d7b34c5

const admin = require('./node_modules/firebase-admin');
const serviceAccount = require("./serviceAccountKey.json");
const data = require("./BusinessReasons.json");
const collectionKey = "businessReasons"; //name of the collection ***********************
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://mxotechaccountmanager.firebaseio.com"
});
const firestore = admin.firestore();
const settings = {
  timestampsInSnapshots: true
};
firestore.settings(settings);
if (data && (typeof data === "object")) {
  Object.keys(data).forEach(docKey => {
    stringDocKey = docKey.toString();
    console.log('docKey=' + stringDocKey.toString())
    if (stringDocKey.length == 1) {
      stringDocKey = "000" + stringDocKey
    }
    if (stringDocKey.length == 2) {
      stringDocKey = "00" + stringDocKey
    }
    if (docKey.length == 3) {
      stringDocKey = "0" + stringDocKey
    }
    data[docKey]['id'] = stringDocKey;


    // firestore.collection(collectionKey).doc(stringDocKey).set(data[docKey]).then((res) => {
    //   console.log("Document " + docKey + " successfully written.");
    // }).catch((error) => {
    //   console.error("Error writing document: ", error);
    // });


    // This part is for the businessReason
    temp = {}
    for (var i = 0; i < data[docKey].length; i++) {
      temp[i.toString()] = data[docKey][i];

    }
    stringDocKey = stringDocKey.replace("\/", "_");
    stringDocKey = stringDocKey.replace("\/", "_");
    console.log(stringDocKey);
    stringDocKey = stringDocKey.toLowerCase()

    firestore.collection(collectionKey).doc(stringDocKey).set(temp).then((res) => {
      console.log("Document " + docKey + " successfully written.");
    }).catch((error) => {
      console.error("Error writing document: ", error);
    });
    // End businessReason///
  });
}