--
-- Base de Datos: 'libreria_db'
-- Este script crea una base de datos completa para gestionar una librería,
-- incluyendo tablas para libros, autores, editoriales, clientes, pedidos,
-- y detalles de los pedidos.
--

-- --------------------------------------------------------
-- 
-- Eliminación de la base de datos si ya existe.
-- Esto es útil para limpiar y recrear la base de datos desde cero en entornos de desarrollo.
--
DROP DATABASE IF EXISTS libreria_db;

--
-- Creación de la base de datos 'libreria_db'.
-- Se usa la codificación UTF8MB4 para soportar una amplia gama de caracteres,
-- incluyendo emojis y caracteres especiales.
--
CREATE DATABASE libreria_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

--
-- Seleccionar la base de datos para todas las operaciones subsiguientes.
--
USE libreria_db;

-- --------------------------------------------------------

--
-- Estructura de la tabla `autores`
-- Almacena información sobre los autores de los libros.
--
CREATE TABLE autores (
    id_autor INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Identificador único del autor',
    nombre VARCHAR(100) NOT NULL COMMENT 'Nombre del autor',
    apellido VARCHAR(100) NOT NULL COMMENT 'Apellido del autor',
    nacionalidad VARCHAR(50) COMMENT 'Nacionalidad del autor',
    fecha_nacimiento DATE COMMENT 'Fecha de nacimiento del autor'
) COMMENT 'Tabla para almacenar información de los autores de los libros.';

--
-- Inserción de datos en la tabla `autores`
--
INSERT INTO autores (nombre, apellido, nacionalidad, fecha_nacimiento) VALUES
('Gabriel', 'García Márquez', 'Colombiana', '1927-03-06'),
('Jane', 'Austen', 'Británica', '1775-12-16'),
('George', 'Orwell', 'Británica', '1903-06-25'),
('Isabel', 'Allende', 'Chilena', '1942-08-02'),
('Haruki', 'Murakami', 'Japonesa', '1949-01-12'),
('Mario', 'Vargas Llosa', 'Peruana', '1936-03-28'),
('Stephen', 'King', 'Estadounidense', '1947-09-21'),
('J.K.', 'Rowling', 'Británica', '1965-07-31'),
('Pablo', 'Neruda', 'Chilena', '1904-07-12'),
('Julio', 'Cortázar', 'Argentina', '1914-08-26'),
('Laura', 'Esquivel', 'Mexicana', '1950-09-30'),
('Miguel', 'de Cervantes', 'Española', '1547-09-29'),
('William', 'Shakespeare', 'Británica', '1564-04-23'),
('Franz', 'Kafka', 'Checa', '1883-07-03'),
('Virginia', 'Woolf', 'Británica', '1882-01-25');

-- --------------------------------------------------------

--
-- Estructura de la tabla `editoriales`
-- Almacena información sobre las editoriales de los libros.
--
CREATE TABLE editoriales (
    id_editorial INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Identificador único de la editorial',
    nombre VARCHAR(100) NOT NULL UNIQUE COMMENT 'Nombre de la editorial (debe ser único)',
    pais VARCHAR(50) COMMENT 'País de origen de la editorial',
    fundacion_año YEAR COMMENT 'Año de fundación de la editorial'
) COMMENT 'Tabla para almacenar información de las editoriales.';

--
-- Inserción de datos en la tabla `editoriales`
--
INSERT INTO editoriales (nombre, pais, fundacion_año) VALUES
('Editorial Sudamericana', 'Argentina', 1939),
('Penguin Random House', 'Estados Unidos', 2013),
('Seix Barral', 'España', 1911),
('Anagrama', 'España', 1969),
('Planeta', 'España', 1949),
('Fondo de Cultura Económica', 'México', 1934),
('HarperCollins Publishers', 'Estados Unidos', 1817),
('RBA Libros', 'España', 1991),
('Scribner', 'Estados Unidos', 1846),
('Bloomsbury Publishing', 'Reino Unido', 1986);

-- --------------------------------------------------------

--
-- Estructura de la tabla `libros`
-- Almacena información detallada sobre los libros.
-- Incluye claves foráneas para `autores` y `editoriales`.
--
CREATE TABLE libros (
    isbn VARCHAR(13) PRIMARY KEY COMMENT 'Código ISBN del libro (identificador único)',
    titulo VARCHAR(255) NOT NULL COMMENT 'Título del libro',
    id_autor INT NOT NULL COMMENT 'Clave foránea que referencia al autor del libro',
    id_editorial INT NOT NULL COMMENT 'Clave foránea que referencia a la editorial del libro',
    año_publicacion YEAR COMMENT 'Año de publicación del libro',
    genero VARCHAR(50) COMMENT 'Género literario del libro',
    precio DECIMAL(10, 2) NOT NULL COMMENT 'Precio de venta del libro',
    stock INT NOT NULL DEFAULT 0 COMMENT 'Cantidad de unidades en stock',
    FOREIGN KEY (id_autor) REFERENCES autores(id_autor) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_editorial) REFERENCES editoriales(id_editorial) ON DELETE CASCADE ON UPDATE CASCADE
) COMMENT 'Tabla para almacenar información detallada de los libros.';

--
-- Inserción de datos en la tabla `libros`
-- Se insertan aproximadamente 20 libros variados.
--
INSERT INTO libros (isbn, titulo, id_autor, id_editorial, año_publicacion, genero, precio, stock) VALUES
('978-0-345-33968-3', 'Cien Años de Soledad', 1, 1, 1967, 'Realismo Mágico', 25.50, 50),
('978-0-141-43951-8', 'Orgullo y Prejuicio', 2, 2, 1813, 'Novela Romántica', 12.99, 30),
('978-0-451-52493-5', '1984', 3, 2, 1949, 'Distopía', 15.75, 45),
('978-84-9793-128-4', 'La Casa de los Espíritus', 4, 3, 1982, 'Realismo Mágico', 22.00, 40),
('978-84-8310-096-7', 'Kafka en la Orilla', 5, 4, 2002, 'Ficción', 18.50, 35),
('978-84-322-1896-1', 'La Ciudad y los Perros', 6, 5, 1963, 'Novela', 20.00, 25),
('978-0-307-74365-7', 'It', 7, 7, 1986, 'Horror', 28.99, 20),
('978-0-7475-3274-3', 'Harry Potter y la Piedra Filosofal', 8, 10, 1997, 'Fantasía', 19.95, 60),
('978-84-322-1726-2', 'Veinte Poemas de Amor y una Canción Desesperada', 9, 5, 1924, 'Poesía', 10.50, 55),
('978-84-204-7183-4', 'Rayuela', 10, 5, 1963, 'Novela Experimental', 23.00, 30),
('978-968-16-1698-4', 'Como Agua para Chocolate', 11, 6, 1989, 'Realismo Mágico', 16.50, 40),
('978-84-670-4665-2', 'El Quijote de la Mancha', 12, 5, 1605, 'Clásico', 30.00, 15),
('978-0-7432-7356-5', 'Romeo y Julieta', 13, 9, 1597, 'Tragedia', 11.00, 28),
('978-0-8052-1049-1', 'La Metamorfosis', 14, 8, 1915, 'Ficción', 9.99, 38),
('978-0-15-697070-5', 'Al Faro', 15, 7, 1927, 'Modernismo', 14.25, 22),
('978-0-345-34068-1', 'Crónica de una Muerte Anunciada', 1, 1, 1981, 'Novela', 18.00, 30),
('978-0-141-43958-7', 'Sentido y Sensibilidad', 2, 2, 1811, 'Novela Romántica', 13.50, 25),
('978-0-451-52634-1', 'Rebelión en la Granja', 3, 2, 1945, 'Sátira Política', 10.99, 40),
('978-84-9793-140-6', 'De Amor y de Sombra', 4, 3, 1984, 'Novela', 21.00, 33),
('978-84-8310-097-4', 'Tokio Blues (Norwegian Wood)', 5, 4, 1987, 'Ficción', 17.50, 27);


-- --------------------------------------------------------

--
-- Estructura de la tabla `clientes`
-- Almacena información sobre los clientes de la librería.
--
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Identificador único del cliente',
    nombre VARCHAR(100) NOT NULL COMMENT 'Nombre del cliente',
    apellido VARCHAR(100) NOT NULL COMMENT 'Apellido del cliente',
    email VARCHAR(255) NOT NULL UNIQUE COMMENT 'Correo electrónico del cliente (debe ser único)',
    telefono VARCHAR(20) COMMENT 'Número de teléfono del cliente',
    direccion VARCHAR(255) COMMENT 'Dirección de residencia del cliente',
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha y hora de registro del cliente'
) COMMENT 'Tabla para almacenar información de los clientes.';

--
-- Inserción de datos en la tabla `clientes`
-- Se insertan 10 clientes de ejemplo.
--
INSERT INTO clientes (nombre, apellido, email, telefono, direccion) VALUES
('Juan', 'Pérez', 'juan.perez@example.com', '123-456-7890', 'Calle Falsa 123, Ciudad del Sol'),
('María', 'González', 'maria.gonzalez@example.com', '987-654-3210', 'Avenida Siempre Viva 742, Springfield'),
('Carlos', 'Rodríguez', 'carlos.rodriguez@example.com', '555-123-4567', 'Bulevar de los Sueños 45, Narnia'),
('Ana', 'Martínez', 'ana.martinez@example.com', '111-222-3333', 'Plaza Mayor 1, Madrid'),
('Luis', 'Hernández', 'luis.hernandez@example.com', '444-555-6666', 'Ruta 66, Barquisimeto'),
('Sofía', 'López', 'sofia.lopez@example.com', '777-888-9999', 'Calle del Árbol 10, Buenos Aires'),
('Diego', 'Gómez', 'diego.gomez@example.com', '000-111-2222', 'Carrera 7, Bogotá'),
('Laura', 'Díaz', 'laura.diaz@example.com', '333-444-5555', 'Av. Libertador, Caracas'),
('Pedro', 'Sánchez', 'pedro.sanchez@example.com', '666-777-8888', 'Calle Larga 25, Barcelona'),
('Elena', 'Torres', 'elena.torres@example.com', '999-000-1111', 'Pasaje Secreto 5, Ciudad de México');

-- --------------------------------------------------------

--
-- Estructura de la tabla `pedidos`
-- Almacena información sobre los pedidos realizados por los clientes.
-- Incluye una clave foránea para `clientes`.
--
CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Identificador único del pedido',
    id_cliente INT NOT NULL COMMENT 'Clave foránea que referencia al cliente que realizó el pedido',
    fecha_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha y hora en que se realizó el pedido',
    estado VARCHAR(50) DEFAULT 'Pendiente' COMMENT 'Estado actual del pedido (e.g., Pendiente, Procesado, Enviado, Entregado, Cancelado)',
    total DECIMAL(10, 2) NOT NULL COMMENT 'Costo total del pedido',
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente) ON DELETE RESTRICT ON UPDATE CASCADE
) COMMENT 'Tabla para almacenar los pedidos realizados por los clientes.';

--
-- Inserción de datos en la tabla `pedidos`
-- Se insertan algunos pedidos de ejemplo.
--
INSERT INTO pedidos (id_cliente, estado, total) VALUES
(1, 'Entregado', 38.49), -- Juan Pérez compró Orgullo y Prejuicio + Rayuela
(2, 'Procesado', 40.50), -- María González compró Cien Años de Soledad + Como Agua para Chocolate
(3, 'Pendiente', 25.50), -- Carlos Rodríguez compró Cien Años de Soledad
(4, 'Enviado', 15.75), -- Ana Martínez compró 1984
(5, 'Entregado', 28.99), -- Luis Hernández compró It
(1, 'Pendiente', 19.95), -- Juan Pérez compró Harry Potter y la Piedra Filosofal
(6, 'Procesado', 22.00), -- Sofía López compró La Casa de los Espíritus
(7, 'Enviado', 10.50), -- Diego Gómez compró Veinte Poemas de Amor...
(8, 'Entregado', 30.00), -- Laura Díaz compró El Quijote
(9, 'Pendiente', 9.99), -- Pedro Sánchez compró La Metamorfosis
(10, 'Procesado', 17.50), -- Elena Torres compró Tokio Blues
(2, 'Enviado', 12.99), -- María González compró Orgullo y Prejuicio
(3, 'Entregado', 11.00); -- Carlos Rodríguez compró Romeo y Julieta

-- --------------------------------------------------------

--
-- Estructura de la tabla `detalle_pedido`
-- Almacena los libros incluidos en cada pedido y sus cantidades.
-- Incluye claves foráneas para `pedidos` y `libros`.
--
CREATE TABLE detalle_pedido (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Identificador único del detalle del pedido',
    id_pedido INT NOT NULL COMMENT 'Clave foránea que referencia al pedido',
    isbn_libro VARCHAR(13) NOT NULL COMMENT 'Clave foránea que referencia al libro en el pedido',
    cantidad INT NOT NULL COMMENT 'Cantidad de este libro en el pedido',
    precio_unitario DECIMAL(10, 2) NOT NULL COMMENT 'Precio unitario del libro en el momento de la compra',
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (isbn_libro) REFERENCES libros(isbn) ON DELETE RESTRICT ON UPDATE CASCADE
) COMMENT 'Tabla para almacenar los detalles de cada pedido (qué libros y cuántos).';

--
-- Inserción de datos en la tabla `detalle_pedido`
-- Estos detalles corresponden a los pedidos insertados anteriormente.
--
INSERT INTO detalle_pedido (id_pedido, isbn_libro, cantidad, precio_unitario) VALUES
(1, '978-0-141-43951-8', 1, 12.99), -- Orgullo y Prejuicio
(1, '978-84-322-1896-1', 1, 23.00), -- Rayuela (Precio actualizado de la tabla libros)
(2, '978-0-345-33968-3', 1, 25.50), -- Cien Años de Soledad
(2, '978-968-16-1698-4', 1, 16.50), -- Como Agua para Chocolate (Precio actualizado de la tabla libros)
(3, '978-0-345-33968-3', 1, 25.50), -- Cien Años de Soledad
(4, '978-0-451-52493-5', 1, 15.75), -- 1984
(5, '978-0-307-74365-7', 1, 28.99), -- It
(6, '978-0-7475-3274-3', 1, 19.95), -- Harry Potter y la Piedra Filosofal
(7, '978-84-9793-128-4', 1, 22.00), -- La Casa de los Espíritus
(8, '978-84-322-1726-2', 1, 10.50), -- Veinte Poemas de Amor...
(9, '978-84-670-4665-2', 1, 30.00), -- El Quijote
(10, '978-0-8052-1049-1', 1, 9.99), -- La Metamorfosis
(11, '978-84-8310-097-4', 1, 17.50), -- Tokio Blues
(12, '978-0-141-43951-8', 1, 12.99), -- Orgullo y Prejuicio
(13, '978-0-7432-7356-5', 1, 11.00); -- Romeo y Julieta

-- --------------------------------------------------------

--
-- Índice para búsquedas rápidas en la tabla `libros`
-- Acelera las consultas por título o género.
--
CREATE INDEX idx_libros_titulo ON libros (titulo);
CREATE INDEX idx_libros_genero ON libros (genero);

--
-- Índice para búsquedas rápidas en la tabla `autores`
-- Acelera las consultas por nombre y apellido.
--
CREATE INDEX idx_autores_nombre_apellido ON autores (nombre, apellido);

--
-- Índice para búsquedas rápidas en la tabla `clientes`
-- Acelera las consultas por email.
--
CREATE INDEX idx_clientes_email ON clientes (email);