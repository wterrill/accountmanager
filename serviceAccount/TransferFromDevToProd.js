// https://medium.com/@devesu/how-to-upload-data-to-firebase-firestore-cloud-database-63543d7b34c5

const admin = require('firebase-admin');
// const admin_dev = require('firebase-admin');

const serviceAccount_prod = require("./serviceAccountKey_prod.json");
const serviceAccount_dev = require("./serviceAccountKey_dev.json");

const data = require("./data2.json");

const collectionKey_prod = "delete_prod";
const collectionKey_dev = "delete_dev"; //name of the collection ***********************

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount_prod),
  databaseURL: "https://mxotechaccountmanager.firebaseio.com",
});

var dev = admin.initializeApp({
  credential: admin.credential.cert(serviceAccount_dev),
  databaseURL: "https://devmxotechaccountmanager.firebaseio.com"
}, 'dev');

const firestore_prod = admin.firestore();
const firestore_dev = dev.firestore();


const settings = {
  timestampsInSnapshots: true
};


var all = ['businessReasons'];
//'userInfo', 'assignedTbr', 'businessReasons', 'companies', 'completedTBRs', 'mail', 'questionnaire', 
// assignedTbr, businessReasons, companies, completedTBRs, mail, questionnaire, questionnarieTypes, userInfo   

// this cycles through all of the names of the base collections
all.forEach(collectionName => {
  // outer loop grabs them from production and gets the document array
  firestore_dev.collection(collectionName).get().then((res) => {
    // this cycles through the docuement array 
    res.docs.forEach(element => {
      // this takes the data from the _dev  and uploads it to the _prod using the collection name and the id of the document
      firestore_prod.collection(collectionName).doc(element.id).set(element.data()).then((res) => {
        console.log("Document " + collectionName + " " + element.id + " successfully written.");
      }).catch((error) => {
        console.error("Error writing document: ", error);
      });

    });
  }).catch((error) => {
    console.error("Error writing document: ", error);
  });

});