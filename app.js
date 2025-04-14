const express = require('express');// used for routing
const bodyParser = require("body-parser");
var mysql = require('mysql');
const app = express();// instance of server is created
const port = 8080;//run on this port
const path = require('path');

app.use(bodyParser.urlencoded({extended:true}));
var connection = mysql.createConnection({  
    host: "localhost",          
    user: "root",
    password: "huzaifarehman2110389",
    database: "farewellpartydb"            
});

connection.connect(function(err) {  // connecting to DBMS
    if (err) throw err;  
    console.log("Farewell Party Database Connected!");  
});

app.get('/', function(_req, res) {
    res.sendFile(path.join(__dirname, 'HOME PAGE.html'));
});
app.get('/login', function(_req, res) {
    res.sendFile(path.join(__dirname, 'login page.html'));
});
app.get('/invitation', function(_req, res) {
    res.sendFile(path.join(__dirname, 'invitations.html'));
});
app.get('/menuSuggestion', function(_req, res) {
    res.sendFile(path.join(__dirname, 'menu suggestion.html'));
});
app.get('/registration', function(_req, res) {
    res.sendFile(path.join(__dirname, 'registration.html'));
});
app.get('/performance', function(_req, res) {
    res.sendFile(path.join(__dirname, 'performance.html'));
});
app.get('/taskAssignment', function(_req, res) {
    res.sendFile(path.join(__dirname, 'task_assignmnent.html'));
});
app.get('/teacherRegistration', function(_req, res) {
    res.sendFile(path.join(__dirname, 'teachers_registration.html'));
});
app.get('/loading', function(_req, res) {
    res.sendFile(path.join(__dirname, 'loading.html'));
});
app.get('/budgetTracking', function(_req, res) {
    res.sendFile(path.join(__dirname, 'budget_tracking.html'));
});
app.get('/attendenceTracking', function(_req, res) {
    res.sendFile(path.join(__dirname, 'attendence_tracking.html'));
});
app.get('/announcements', function(_req, res) {
    res.sendFile(path.join(__dirname, 'announcments.html'));
});

app.post("/contactForm",function(req,res){
    const name = String(req.body.name);
    const email = String(req.body.email);
    const subject = String(req.body.subject);
    const message = String(req.body.message);
   
    console.log(name);
    console.log(email);
    console.log(subject);
    console.log(message);

      const sql = "INSERT INTO contacts(name, email, subject, message) VALUES (?,?,?,?)";
      connection.query(sql, [name, email, subject, message], function(err, results) {
      if (err) throw err;  
    });
});

app.post("/loginForm",function(req,res){
    const name = String(req.body.username);
    const password = Number(req.body.password);
   
    console.log(name);
    console.log(password);

      const sql = "INSERT INTO login_credentials(username, password) VALUES (?,?)";
      connection.query(sql, [name, password], function(err, results) {
      if (err) throw err;  
    });
});

app.post("/registerForm",function(req,res){
    const name = String(req.body.fullname);
    const email = String(req.body.email);
    const batch = String(req.body.batch);
    const rollno = String(req.body.rollNo);
    const diet = String(req.body.dietaryPreferences);
    const members = Number(req.body.familyMembers);
   
    console.log(name);
    console.log(email);
    console.log(batch);
    console.log(rollno);
    console.log(diet);
    console.log(members);

      const sql = "INSERT INTO students(fullname, email, batch, roll_no, dietary_preferences, family_members) VALUES (?,?,?,?,?,?)";
      connection.query(sql, [name, email, batch, rollno, diet, members], function(err, results) {
      if (err) throw err;  
    });
});

app.post("/teacherRegisterForm",function(req,res){
    const name = String(req.body.teachername);
    const email = String(req.body.teacheremail);
    const members = Number(req.body.familymembers);
   
    console.log(name);
    console.log(email);
    console.log(members);

      const sql = "INSERT INTO teachers_registration(teacher_name, email, family_members) VALUES (?,?,?)";
      connection.query(sql, [name, email, members], function(err, results) {
      if (err) throw err;  
    });
});

app.post("/menuSuggestionForm",function(req,res){
    const type = String(req.body.menuType);
    const items = String(req.body.items);
    const price = Number(req.body.price);
   
    console.log(type);
    console.log(items);
    console.log(price);

      const sql = "INSERT INTO menu_suggestions(item_name, suggested_by) VALUES (?,?)";
      connection.query(sql, [items, price], function(err, results) {
      if (err) throw err;  
    });
});

app.post("/announcementForm",function(req,res){
    const name = String(req.body.fullname);
    const email = String(req.body.email);
    const batch = String(req.body.batch);
    const rollno = Number(req.body.rollNo);
    const diet = String(req.body.dietaryPreferences);
    const members = String(req.body.familyMembers);
   
    console.log(name);
    console.log(email);
    console.log(batch);
    console.log(rollno);
    console.log(diet);
    console.log(members);

      const sql = "INSERT INTO students(fullname, email, batch, roll_no, dietary_preferences, family_members) VALUES (?,?,?,?,?,?)";
      connection.query(sql, [name, email, batch, rollno, diet, members], function(err, results) {
      if (err) throw err;  
    });
});

app.post("/performanceForm",function(req,res){
    const name = String(req.body.fullname);
    const email = String(req.body.email);
    const batch = String(req.body.batch);
    const rollno = Number(req.body.rollNo);
    const diet = String(req.body.dietaryPreferences);
    const members = String(req.body.familyMembers);
   
    console.log(name);
    console.log(email);
    console.log(batch);
    console.log(rollno);
    console.log(diet);
    console.log(members);

      const sql = "INSERT INTO students(fullname, email, batch, roll_no, dietary_preferences, family_members) VALUES (?,?,?,?,?,?)";
      connection.query(sql, [name, email, batch, rollno, diet, members], function(err, results) {
      if (err) throw err;  
    });
});

app.post("/invitationForm",function(req,res){
    const recipient = String(req.body.recipient);
    const batch = Number(req.body.batch);
    const venue = String(req.body.venue);
    const timing = String(req.body.timing);
    const dress = String(req.body.dresscode);
   
    console.log(recipient);
    console.log(batch);
    console.log(venue);
    console.log(timing);
    console.log(dress);

      const sql = "INSERT INTO invitations(recipient_type, batch_year, venue, timing, dress_code_theme) VALUES (?,?,?,?,?)";
      connection.query(sql, [recipient, batch, venue, timing, dress], function(err, results) {
      if (err) throw err;  
    });
});

app.post("/attendanceForm",function(req,res){
    const name = String(req.body.name);
    const type = String(req.body.type);
    const email = String(req.body.email);
    const roll = String(req.body.roll);
    //const members = Number(req.body.nummembers);
    const notes = Number(req.body.notes);

    console.log(name);
    console.log(type);
    console.log(email);
    console.log(roll);
    //console.log(members);
    console.log(notes);

      const sql = "INSERT INTO attendance(name, type, email, roll_no, notes) VALUES (?,?,?,?,?)";
      connection.query(sql, [name, type, email, roll, notes], function(err, results) {
      if (err) throw err;  
    });
});

app.listen(port, function(){                
    // connecting to a server
console.log(`Listening on port ${port}...`);  
});