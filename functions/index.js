const { onRequest } = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");

const functions = require("firebase-functions");
const admin = require("firebase-admin");
const { GoogleAuth } = require("google-auth-library");
const { google } = require("googleapis");
const { createObjectCsvWriter } = require("csv-writer");

admin.initializeApp();

// Set up Google Drive API authentication
const auth = new GoogleAuth({
  scopes: ["https://www.googleapis.com/auth/drive.file"],
});
const drive = google.drive({ version: "v3", auth });

// Scheduled function to fetch Firestore data, convert to CSV, and upload to Google Drive
exports.exportFirestoreToCSV = functions.pubsub.schedule("0 0 1 * *").onRun(async (context) => {
  const firestore = admin.firestore();
  const snapshot = await firestore.collection("harvestData").get();

  // Convert Firestore documents to an array of objects
  const data = [];
  snapshot.forEach((doc) => {
    const record = doc.data();
    data.push({
      id: doc.id,
      ...record,
    });
  });

  // Define CSV file path and headers
  const csvWriter = createObjectCsvWriter({
    path: "/tmp/harvest_data.csv",
    header: [
      { id: "id", title: "Document ID" },
      { id: "area", title: "Area" },
      { id: "date", title: "Date" },
      { id: "disease", title: "Disease" },
      { id: "harvest", title: "Harvest" },
      { id: "numberOfDiseases", title: "Number of Diseases" },
      { id: "pesticides", title: "Pesticides" },
    ],
  });

  await csvWriter.writeRecords(data);

  console.log("CSV file created successfully!");

  // Upload the CSV file to Google Drive
  const fileMetadata = {
    name: "harvest_data.csv",
    parents: ["https://drive.google.com/drive/folders/16JOgWx-MI0noHtyxmcKR-UDbztzcbs8T?usp=sharing"], // Replace with your folder ID
  };
  const media = {
    mimeType: "text/csv",
    body: require("fs").createReadStream("/tmp/harvest_data.csv"),
  };

  const res = await drive.files.create({
    resource: fileMetadata,
    media: media,
    fields: "id",
  });

  console.log(`CSV file uploaded to Google Drive with ID: ${res.data.id}`);
  return null;
});
