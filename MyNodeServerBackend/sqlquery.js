var massive = require("massive");
var app = require('./app');
var db = app.get('db');
var logresults = function(err,results){
    if(err){
        console.log("Error returned");
        console.log(err);
    }else{
        console.log("Successfully executed Statement");
        console.log(results);
    }
};

exports.massivequery = function(){
    db.querytest(function(err,results){
        logresults(err,results);
    });
};
exports.createDatabase = function(callback){
    callback = callback || function(){};
    console.log("Create Database");
    db.createdb(function(err,results){
        logresults(err,results);
        callback();
    });
};
exports.createStoredProcedures = function(callback){
    callback = callback || function(){};
    console.log("Create Stored Procedures");
    db.createStoredProcedures(function(err,results){
        logresults(err,results);
        callback();
    });
};

exports.populateDatabase = function(callback){
    callback = callback || function(){};
    console.log("Populate Database");
    db.populatedb(function(err,results){
        logresults(err,results);
        callback();

    });
};

exports.destroyDatabase = function(callback){
    callback = callback || function(){};
    console.log("Destroy Database");
    db.deletedb(function(err,results){
        //products is a results array
        logresults(err,results);
        callback();

    });
};
exports.queryDatabase = function(){

    db.querydb(function(err,results){
        console.log('Query Database');
        logresults(err,results);
    });
};
exports.getUsers = function(callback){
    db.querydb(function(err,results){
        console.log('Query Database');
        console.log(results);
        if(err){
            callback(err);
        }else{
            callback(results);
        };

    });
};
exports.findUserByUsername = function(username, callback){
    db.finduserbyid([username],function(err,results){
        console.log('Find user by username: '+ username);
        //console.log(results);
        if(err){
            callback(err);
        }else{
            callback(err,results);
        };

    });
};
exports.getCategories = function(callback){
    db.getcategories(function(err,results){
        console.log('Get all Categories');
        if(err){
            callback(err);
        }else{
            callback(err,results);
        }
    });
};

exports.getThreadsFromCategory = function(categorytitle, callback){
    db.getthreadsfromcategory([categorytitle],function(err,results){
        console.log('Get threads with category title');
        if(err){
            callback(err);
        }else{
            callback(err,results);
        }
    });
};
exports.createUser = function(parameters, callback){
    db.createuser(parameters,function(err,results){
        console.log('Create user ' + parameters[0]);
        if(err){
            console.log('Create user error');
            callback(err);
        }else{
            console.log('Create user results');
            callback(err,results);
        }
    });
};
exports.checkIfAuthenticated = function(username, password, callback){
    db.checkIfAuthenticated([username,password],function(err,results){
        console.log('Check if user: ' + username + ' is authenticated');
        if(err){
            callback(err);
        }else{
            var authenticationResponseMessage = results[0].loginuser;
            console.log('Results of authentication is ' + authenticationResponseMessage);
            if(authenticationResponseMessage === "Login Success: U"){
                console.log('Login Success: User status');
                callback(err,"user");
            }else if(authenticationResponseMessage === "Login Success: M"){
                console.log('Login Success: Mod status');
                callback(err,"mod");
            }else if(authenticationResponseMessage === "Login Success: A"){
                console.log('Login Success: Admin status');
                callback(err,"admin");
            }else if(authenticationResponseMessage === "Login Failure"){
                console.log('Login Failure');
                callback(err,false);
            }else{
                console.log('Login Not understood');
                callback(err,false);
            }
            //loginuser the name of the function the result is returned from



        }
    });
};
