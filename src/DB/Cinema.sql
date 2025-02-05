CREATE  DATABASE  CinePelicula ;
USE CinePelicula;

-- tabla de películas -- 
CREATE TABLE peliculas(
	peliculaID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	titulo VARCHAR(255) NOT NULL,
	director VARCHAR(80) NOT NULL,
	idioma VARCHAR(255) NOT NULL,
	edadRequerida SMALLINT,
	fechaEstreno DATE,
    genero VARCHAR(255) NOT NULL,
    duracionMin smallint);
    
    
    -- Agregar --
delimiter $$
CREATE PROCEDURE proceInsertarPelicula (titulo VARCHAR(255), director VARCHAR(80), idioma VARCHAR(255), 
				edadRequerida SMALLINT, fechaEstreno DATE, genero VARCHAR(255), duracionMin smallint)
begin 
	INSERT INTO `cinePelicula`.`peliculas`
		(`titulo`,`director`,`idioma`,`edadRequerida`,`fechaEstreno`,`genero`,`duracionMin`)
		VALUES
		(titulo,director,idioma,edadRequerida,fechaEstreno,genero,duracionMin);
end $$ 
delimiter ;

-- Eliminar --
delimiter $$
CREATE PROCEDURE proceEliminarPelicula (pIdPelicula INT)
begin 
	DELETE FROM peliculas WHERE peliculas.peliculaID = pIdPelicula;
    
end $$ 
delimiter ;

-- Modificar --
delimiter $$
CREATE PROCEDURE proceModificarPelicula (pPeliculaID INT, pTitulo VARCHAR(255), pIdioma VARCHAR(255), pFecha DATE)
BEGIN
    IF NOT pTitulo = "" THEN
        UPDATE Peliculas SET titulo = pTitulo WHERE peliculaID = pPeliculaID;
    END IF;
    IF NOT pIdioma = "" THEN
        UPDATE Peliculas SET idioma = pIdioma WHERE peliculaID = pPeliculaID;
    END IF;
    IF NOT pFecha = '1901-01-01' THEN
        UPDATE Peliculas SET fechaEstreno = pFecha WHERE peliculaID = pPeliculaID;
    END IF;
END $$
delimiter ;

-- Buscar --
delimiter $$
CREATE PROCEDURE proceBuscarPelicula (pTitulo VARCHAR(255), IDGenero VARCHAR(80), pIdioma VARCHAR(255), pFecha DATE)
BEGIN
    SET @consulta = 'SELECT PELI.peliculaID, titulo, director, idioma, edadRequerida, fechaEstreno, duracionMin, genero FROM Peliculas PELI WHERE 1';   
    IF NOT pTitulo = "" THEN SET @consulta = CONCAT(@consulta, " AND titulo = '", pTitulo, "'"); END IF;
    IF NOT IDGenero = "" THEN SET @consulta = CONCAT(@consulta, " AND genero = '", IDGenero, "'"); END IF;
    IF NOT pIdioma = "" THEN SET @consulta = CONCAT(@consulta, " AND idioma = '", pIdioma, "'"); END IF;
    IF NOT pFecha = '1901-01-01' THEN SET @consulta = CONCAT(@consulta, " AND fechaEstreno = '", DATE_FORMAT(pFecha, '%Y-%m-%d'), "'"); END IF;
    PREPARE stmt FROM @consulta;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END $$
delimiter ;
