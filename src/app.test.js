const supertest = require("supertest");
const app = require("./app");

describe("POST /create_registry", () => {
    describe("adding a movie",  () => {
        test("should respond with a 200 status code", async () => {
            const response = await supertest(app).post("/create_registry").send({
                title: "The Godfather",
                director: "Francis Ford Coppola",
                language: "English",
                releaseDate: "1972-03-24",
                genre: "Drama",
                runningTime: 175,
                mpaAge: 18,
            });
            expect(response.status).toBe(200);
        })
    })
});

describe("POST /filter_registry", () => {
    describe("searching a movie", () => {
        test("should respond with a 200 status code", async () => {
            const response = await supertest(app).post("/filter_registry").send({
                title: "The GodFather",
                language: "",
                releaseDate:"1901-01-01",
                genre:"",
                director:""
            });
            expect(response.status).toBe(200);
        })
    })
});

describe("POST /delete_registry", () => {
    describe("deleting a movie by id", () => {
        test("should respond with a 200 status code", async () => {
            const response = await supertest(app).post("/delete_registry").send({
                movieID: 1
            })
            expect(response.status).toBe(200);
        })
    })
})