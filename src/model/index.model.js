const mysql = require('mysql');
const model = {}
const express = require('express');
const db = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "Smand.com2772",
    database: "moviescrud",
    port: 3306
})

model.addMovieModel = (values) => {
    return new Promise((resolve, reject) => {
        const title = values.body.title;
        const language = values.body.language;
        const director = values.body.director;
        const release_date = values.body.releaseDate;
        const genre = values.body.genre;
        const running_time = values.body.runningTime;
        const mpa_age = values.body.mpaAge;
        const res = "call insertMovie ('"+title+"','"+director+"','"+language+"',"+mpa_age+",'"+release_date+"','"+genre+"',"+running_time+");";
        console.log(res);
        db.query(res, (err, data) => {
            if (err) {
                console.log("[ERROR] => "+err);
                reject(err);
            }
            else {
                resolve(data);
            }
        });
    });

}

model.searchMovieModel = (values) => {
    return new Promise((resolve, reject) => {
        const title = values.body.title;
        const language = values.body.language;
        const release_date = values.body.releaseDate;
        const genre = values.body.genre;
        const director = values.body.director;
        const res = "call searchMovie('"+title+"','"+genre+"','"+director+"','"+language+"','"+release_date+"');";
        console.log(res);
        db.query(res, (err, data) => {
            if (err) {
                console.log("[ERROR] => "+err);
                reject(err);
            }
            else {
                const formattedData = data[0].map(movie => {
                    if (movie.releaseDate) {
                        movie.releaseDate = new Date(movie.releaseDate).toISOString().split('T')[0];
                    }
                    return movie;
                });
                console.log(formattedData);
                resolve(formattedData);
            }
        });
    });
}

model.deleteMovieModel = (values) => {
    return new Promise((resolve, reject) => {
        console.log(values.body);
        const id = values.body.movieID;
        const res = "call deleteMovie("+id+");";
        console.log(res);
        db.query(res, (err, data) => {
            if (err) {
                console.log("[ERROR] => "+err);
                reject(err);
            }
            else {
                resolve(data);
            }
        });
    })
}


model.modifyMovieModel = (values) => {
    return new Promise((resolve, reject) => {
        const id = values.body.id;
        const title = values.body.title;
        const language = values.body.language;
        const release_date = values.body.releaseDate;
        const res = "call updateMovie ("+id+",'"+title+"','"+language+"','"+release_date+"');";
        console.log(res);
        db.query(res, (err, data) => {
            if (err) {
                console.log("[ERROR] => "+err);
                reject(err);
            }
            else {
                resolve(data);
            }
        });
    });

}

model.getMoviesModel = () => {
    return new Promise((resolve, reject) => {
        const res = "select * from movies;";
        console.log (res)
        db.query(res, (err, data) => {
            if (err) {
                console.log("ERROR [get_registry_sql operation] => "+err);
                reject(err);
            }
            else {
                console.log(data);
                const formattedData = data.map(movie => {
                    if (movie.releaseDate) {
                        movie.releaseDate = new Date(movie.releaseDate).toISOString().split('T')[0];
                    }
                    return movie;
                });
                console.log(formattedData);
                resolve(formattedData);
            }
        });
    })
}



module.exports = model;