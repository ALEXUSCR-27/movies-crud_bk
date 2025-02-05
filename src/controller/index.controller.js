const { response } = require('express');
const model = require('../model/index.model');
const controller = {}

controller. addMovie = (req, res) => {
    console.log(req)
    model.addMovieModel(req)
    .then(response => {
    res.status(200).send(JSON.stringify(response));
    }).catch(error => {
        console.error(error);
        res.status(500).send("Error while trying to add the movie");
    });
}

controller.searchMovie = (req, res) => {
    model.searchMovieModel(req)
    .then(response => {
    res.status(200).send(JSON.stringify(response));
    }).catch(error => {
        console.error(error);
        res.status(500).send("Error while trying to search the movie");
    });
}

controller.deleteMovie = (req, res) => {
    model.deleteMovieModel(req)
    .then(response => {
    res.status(200).send(JSON.stringify(response));
    }).catch(error => {
        console.error(error);
        res.status(500).send("Error while trying to delete the movie");
    });
}

controller.modifyMovie = (req, res) => {
    model.modifyMovieModel(req)
    .then (response => {
        res.send(JSON.stringify(response));
    }).catch(error => {
        console.error(error);
        res.status(500).send("Error while trying to modify the movie");
    });
}

controller.getMovies = (req, res) => {
    model.getMoviesModel(req)
    .then (response => {
        res.send(JSON.stringify(response));
    })
    .catch(error => {
        console.error(error)
        res.status(500).send("Error while trying to get all the movies");
    })
}

module.exports = controller;