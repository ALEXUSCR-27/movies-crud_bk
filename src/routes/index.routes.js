const express = require('express');
const router = express.Router();
const controller = require('../controller/index.controller');

router.post("/create_registry", controller.addMovie);
router.post("/filter_registry", controller.searchMovie);
router.post("/delete_registry", controller.deleteMovie);
router.post("/modify_registry", controller.modifyMovie);
router.post("/get_registry", controller.getMovies);

module.exports = router;