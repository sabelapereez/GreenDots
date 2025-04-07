CREATE TABLE Usuarios (
    Nickname VARCHAR(50) PRIMARY KEY,
    NombreCompleto VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Password TEXT NOT NULL,
    FechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Admin BOOLEAN DEFAULT FALSE,
    FotoPerfil BYTEA  -- Se puede almacenar la imagen en formato binario
);

CREATE TABLE Locales (
    ID SERIAL PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Categoria VARCHAR(50) NOT NULL,
    FechaAdmision TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Ubicacion TEXT NOT NULL,
    DescripcionTextual TEXT,
    Ecosostenible INT CHECK (Ecosostenible BETWEEN 0 AND 5),
    InclusionSocial INT CHECK (InclusionSocial BETWEEN 0 AND 5),
    Accesibilidad INT CHECK (Accesibilidad BETWEEN 0 AND 5)
);

CREATE TABLE LocalesFotos (
    ID SERIAL PRIMARY KEY,
    LocalID INT REFERENCES Locales(ID) ON DELETE CASCADE,
    Foto BYTEA  -- Se almacena la imagen en formato binario
);

CREATE TABLE Favoritos (
    UsuarioNickname VARCHAR(50) REFERENCES Usuarios(Nickname) ON DELETE CASCADE,
    LocalID INT REFERENCES Locales(ID) ON DELETE CASCADE,
    PRIMARY KEY (UsuarioNickname, LocalID)
);

CREATE TABLE Opiniones (
    ID SERIAL PRIMARY KEY,
    UsuarioNickname VARCHAR(50) REFERENCES Usuarios(Nickname) ON DELETE CASCADE,
    LocalID INT REFERENCES Locales(ID) ON DELETE CASCADE,
    FechaPublicacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ResenaTexto TEXT,
    Ecosostenible INT CHECK (Ecosostenible BETWEEN 0 AND 5),
    InclusionSocial INT CHECK (InclusionSocial BETWEEN 0 AND 5),
    Accesibilidad INT CHECK (Accesibilidad BETWEEN 0 AND 5)
);

CREATE TABLE OpinionesFotos (
    ID SERIAL PRIMARY KEY,
    OpinionID INT REFERENCES Opiniones(ID) ON DELETE CASCADE,
    Foto BYTEA  -- Se almacena la imagen en formato binario
);


------- INSERTAMOS DATOS --------

-- Insertar Usuarios
INSERT INTO Usuarios (Nickname, NombreCompleto, Email, Password, Admin) VALUES
('asier', 'Asier Cabo', 'asier@example.com', 'e507f1a62080a184a06e719846ce6bb64542ad1789e70982a8ecc6cedf5ea20e', TRUE),
('juan23', 'Juan Pérez', 'juan@example.com', 'ed08c290d7e22f7bb324b15cbadce35b0b348564fd2d5f95752388d86d71bcca', TRUE),
('maria89', 'María López', 'maria@example.com', '94aec9fbed989ece189a7e172c9cf41669050495152bc4c1dbf2a38d7fd85627', FALSE),
('carlos_m', 'Carlos Martínez', 'carlos@example.com', '7b85175b455060e3237e925f023053ca9515e8682a83c8b09911c724a1f8b75f', FALSE);

INSERT INTO Usuarios (Nickname, NombreCompleto, Email, Password, Admin, FotoPerfil) VALUES
('martin', 'Martín González', 'martin@example.com', '1e14a4d0c2521e93e85da877dcda9b17d5d85f33af2c52cf60b3a6468d4c343d', FALSE, '/9j/4AAQSkZJRgABAgAAAQABAAD/2wBDAAgGBgcGBQgHBwcJCQgKDBQNDAsLDBkSEw8UHRofHh0a
HBwgJC4nICIsIxwcKDcpLDAxNDQ0Hyc5PTgyPC4zNDL/2wBDAQkJCQwLDBgNDRgyIRwhMjIyMjIy
MjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjL/wAARCAB4AHgDASIA
AhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQA
AAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3
ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWm
p6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEA
AwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSEx
BhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElK
U1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3
uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwCgKeBT
BT6wOhCinUgpM0hjxTs1japrcdhbORzLyFH071gS+OkjmMflFguBkd6LNhc7mlzXCt8QY95VbNgQ
eNzYz9akHjyISAtbShAPmGQcH29aOVhdHa5pM1kad4h07UwqwTjzCMmNuGFagbIzUlElLTAacDQA
6jFFLQA00UpooAqAYp1G2lxVkIKoaxO0Glzup+YKcVeqjqdtJdWrRIRz1DDg/wCFIZ5deahLdbXL
MZFG1qqxnB3Ny1bOr6A1gpmQkEHkZzWpZeCZ7q3jlkO12AyAKcqkYLUdOjOo/dOPLeazbhnuDTI5
ShI3cV3sXgGYM2Ig2ehaopfh/MjkupAA6A0liIMuWDqrU4iKeS2nWWJykinKsO1eleFPEZ1WBoLk
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');

-- Insertar Locales
INSERT INTO Locales (Nombre, Categoria, Ubicacion, DescripcionTextual, Ecosostenible, InclusionSocial, Accesibilidad) VALUES
('Reserva de la Biosfera - Los Ancares', 'Reserva natural', '42.78396673770446, -6.744427809139001', 'Espacio protegido con gran biodiversidad y paisajes espectaculares.', 5, 4, 3),
('Llera Cafetería Restaurante', 'Restaurante', '42.81999067014897, -6.491244547915142', 'Restaurante con cocina casera y ambiente acogedor.', 3, 2, 4),
('Cabaña Asociación Peña Rubia', 'Cabaña de montaña', '42.99468094357585, -6.3307931274437985', 'Cabaña en plena naturaleza ideal para senderismo y descanso.', 4, 3, 2),
('KYOMU Resort', 'Resort', '42.84975612200563, -4.835563526289468', 'Resort exclusivo con spa y vistas panorámicas.', 5, 3, 5),
('Casa Rural "La Ruina"', 'Casa rural', '42.5257235594019, -4.821143970372428', 'Casa rural con encanto en un entorno natural.', 4, 2, 3),
('Balsa de Riego Villalón-Herrín-Boadilla', 'Atracción turística', '42.14184828194946, -4.986569882287325', 'Punto de interés para observación de aves y turismo rural.', 3, 1, 2),
('La Aldea Colorada', 'Hotel rural', '41.61355230180207, -5.192246444417659', 'Hotel rural con arquitectura tradicional y tranquilidad asegurada.', 4, 3, 4),
('Hotel Bardo Recoletos Coco', 'Hotel', '40.98109981384691, -5.663628585182568', 'Hotel moderno con excelente servicio y comodidades.', 3, 2, 5),
('La Valmuza Golf Salamanca', 'Campo de golf', '40.90329901005034, -5.782761580800479', 'Campo de golf con amplias instalaciones y restaurante.', 2, 1, 4),
('Hotel Rural Solar das Arcadas', 'Hotel rural', '41.73331148001485, -8.652596480885286', 'Hotel rural con vistas al río Miño y ambiente acogedor.', 4, 3, 4),
('Mosteiro de São João de Arga', 'Monasterio', '41.83828265967085, -8.732306958092979', 'Monasterio histórico en un entorno natural impresionante.', 3, 2, 3),
('Bodegas Antonio Montero', 'Bodega', '42.28949279418554, -8.112255334902747', 'Bodega con degustaciones y visitas guiadas.', 3, 2, 2),
('Carrefour Express', 'Supermercado', '42.28441309833429, -8.1469027698565', 'Supermercado con variedad de productos y buena ubicación.', 2, 1, 5),
('Bar Benigno', 'Bar', '42.27833279887347, -8.15681621435559', 'Bar tradicional con tapas y ambiente local.', 2, 2, 3),
('Bodega Rural Tipo Loft', 'Casa rural', '42.287848612884005, -8.178489187925477', 'Casa rural en una bodega con diseño moderno.', 3, 3, 3),
('Rinoterra Minho', 'Hotel boutique', '41.882015091212274, -8.818735756884298', 'Hotel boutique con spa y vistas al océano.', 4, 3, 4),
('Restaurante Casa Chupa Ovos', 'Restaurante', '41.89857374523286, -8.874059021684346', 'Restaurante de mariscos con especialidad en platos locales.', 3, 2, 3),
('Aparcamiento Puerto de A Guarda', 'Aparcamiento', '41.89874144628789, -8.878162801472333', 'Aparcamiento con acceso al puerto y paseo marítimo.', 1, 1, 5),
('Porto da Guarda', 'Puerto deportivo', '41.89921260402321, -8.87719720623864', 'Puerto deportivo con embarcaciones y actividades náuticas.', 3, 2, 3),
('Contra Dique Porto de A Guarda', 'Emisora de radio', '41.900761061435155, -8.881718739878984', 'Emisora local con programación variada.', 1, 1, 1),
('V3NON - Tienda de Neoprenos', 'Tienda de deportes', '41.90400134594724, -8.879327550543447', 'Tienda especializada en equipos para deportes acuáticos.', 2, 1, 3),
('Escola Infantil Cativos', 'Escuela infantil', '41.90471550899023, -8.87883771212221', 'Centro educativo infantil con métodos innovadores.', 4, 4, 5),
('Alimentación Elena', 'Tienda de alimentación', '41.90566896159349, -8.87649178505605', 'Tienda local con productos frescos y de proximidad.', 3, 2, 3),
('Restaurante Área Grande', 'Restaurante', '41.91060118584327, -8.876389861133243', 'Restaurante con vistas al mar y especialidad en pescado.', 3, 2, 4),
('Refugio de Montaña de la Sierra del Sotillo', 'Refugio de montaña', '42.10224234778636, -6.759226514595225', 'Refugio para senderistas en plena naturaleza.', 4, 3, 2),
('Parroquia Católica San Pelayo', 'Iglesia', '42.4192549211843, -6.661556367946381', 'Iglesia histórica con elementos arquitectónicos únicos.', 2, 1, 2),
('Ermita de San Roque', 'Iglesia', '42.24744201129721, -6.4217394592487596', 'Pequeña ermita en un entorno rural con gran historia.', 2, 1, 2),
('Estación de Servicio Cepsa', 'Gasolinera', '42.254875286082196, -6.428949236993683', 'Gasolinera con tienda y servicios básicos.', 2, 1, 5),
('Hotel Rural Molino Del Arriero', 'Hotel rural', '42.37641504839204, -6.239134669437094', 'Hotel rural con restaurante y encanto rústico.', 4, 3, 4),
('BRIF de Tabuyo', 'Helipuerto', '42.295823982235625, -6.213565580222566', 'Base de helicópteros para emergencias y protección forestal.', 3, 2, 3),
('Palacio de Gaudí Astorga', 'Museo', '42.45780454767304, -6.055938919646427', 'Museo arquitectónico diseñado por Gaudí en Astorga.', 5, 4, 5),
('Hormigones Sindo Castro - Planta de Astorga', 'Fábrica', '42.45535135060266, -6.081594576424594', 'Fábrica de hormigón con producción a gran escala.', 1, 1, 2),
('Materiales de Construcción Posada', 'Tienda de construcción', '42.47129564630521, -6.087157477885397', 'Tienda con materiales para construcción y reformas.', 2, 1, 3),
('Parroquia Católica San Pelayo', 'Lugar de culto', '42.50099967110265, -6.058289900695738', 'Lugar de culto con gran relevancia histórica.', 2, 1, 2),
('Taller de Hierro Jesús', 'Carpintería metálica', '42.10002325511717, -5.0306952860198795', 'Taller especializado en trabajos de hierro y aluminio.', 2, 1, 2),
('Odeon Multicines', 'Cine', '42.613382545467296, -5.596970812589369', 'Multicines con salas modernas y cartelera variada.', 3, 2, 5),
('Decathlon Lugo', 'Tienda de deportes', '43.037136582840965, -7.553300442080469', 'Tienda de artículos deportivos con amplia variedad de productos.', 3, 2, 5),
('Hotel Auditorio Santiago & Spa', 'Hotel', '42.985735404842146, -7.589707375412563', 'Hotel moderno con spa y auditorio para eventos.', 4, 3, 5),
('Hotel Rural O Cruce do Burgo', 'Hotel rural', '42.953014589311074, -7.7766036995744345', 'Alojamiento rural con encanto y vistas a la naturaleza.', 4, 3, 4),
('Hostal Seijo', 'Hostal', '43.30099322421281, -7.678976411090915', 'Hostal acogedor con habitaciones cómodas y buen servicio.', 3, 2, 3),
('Albergue - Cafetería - Panadería Valín Lama', 'Albergue', '42.873027427694396, -7.876952818212669', 'Albergue con cafetería y panadería propia.', 3, 2, 4),
('Lalín Arena', 'Polideportivo', '42.65944840532714, -8.117756695257704', 'Instalaciones deportivas con múltiples actividades.', 3, 2, 4),
('Estadio Manuel Anxo Cortizo', 'Estadio', '42.65059922395509, -8.126371801003975', 'Estadio de fútbol con capacidad para eventos deportivos.', 3, 2, 3),
('Pazo de Tor', 'Museo', '42.56874288028961, -7.567330972812284', 'Museo en un pazo histórico con exposiciones culturales.', 4, 3, 4),
('Embarcadoiro da Maiorga - Bar', 'Bar', '42.537178580099294, -7.708658854587761', 'Bar con terraza y vistas al río.', 3, 2, 3),
('Restaurante Prieto', 'Restaurante', '42.30922431920983, -7.6442429023396254', 'Restaurante con cocina tradicional y especialidad en carnes.', 4, 3, 4),
('Braña SCL', 'Vivero', '42.327799549481085, -7.721623778554181', 'Vivero con plantas autóctonas y asesoramiento agrícola.', 3, 2, 3),
('Mercadona', 'Supermercado', '42.41659759263908, -6.997886488621709', 'Supermercado con productos frescos y secciones especializadas.', 2, 1, 5),
('Lidl', 'Supermercado', '42.423884185745706, -6.9947536685301825', 'Supermercado con variedad de productos a precios competitivos.', 2, 1, 5),
('Eroski Center', 'Supermercado', '42.393925818728825, -7.111735253288878', 'Supermercado con productos locales y ecológicos.', 2, 1, 5),
('Ortopedia Farmacia Progreso', 'Farmacia', '42.395555326975796, -7.111661211028739', 'Farmacia con servicio de ortopedia y asesoramiento.', 3, 2, 4),
('Adega Quinta da Peza', 'Bodega', '42.40046725604404, -7.118275633561566', 'Bodega con visitas guiadas y degustación de vinos.', 4, 3, 4),
('Casa de Fornas - Rodeiro - Ribeira Sacra', 'Apartamento turístico', '42.70547136993283, -7.912267968694288', 'Apartamento turístico en la Ribeira Sacra con vistas espectaculares.', 4, 3, 4),
('Iglesia de San Juan de Camba', 'Iglesia', '42.67024407263557, -7.911959176811586', 'Iglesia histórica con arquitectura románica.', 3, 2, 3),
('Hotel Restaurante Xaneiro', 'Hotel', '42.91485502539397, -8.011631422074835', 'Hotel con restaurante especializado en cocina gallega.', 4, 3, 4),
('Hotel Barreiro', 'Hotel', '43.11646807431419, -8.398473397147066', 'Hotel con habitaciones confortables y buena ubicación.', 3, 2, 3),
('Casa Molino', 'Casa rural', '43.21309728843508, -8.458960024678502', 'Casa rural con molino restaurado y entorno natural.', 4, 3, 4),
('Conde & Esparis Abogadas', 'Agencia', '42.87463563314225, -8.549456635605747', 'Despacho de abogadas especializado en derecho civil y mercantil.', 3, 4, 4),
('ABANCA', 'Banco', '42.87457482763009, -8.549691897013142', 'Sucursal bancaria que ofrece servicios financieros a particulares y empresas.', 4, 3, 5),
('Botana Abogados', 'Agencia', '42.874651640931106, -8.54957926880059', 'Bufete de abogados con amplia experiencia en diversas ramas del derecho.', 3, 4, 3),
('GBT Zapaterías Santiago', 'Tienda de calzado', '42.87477296120558, -8.54935702331804', 'Tienda especializada en calzado de moda para todas las edades.', 2, 3, 4),
('AudioVal', 'Centro de salud', '42.8748302268026, -8.549304341108595', 'Centro auditivo que ofrece servicios de evaluación y venta de audífonos.', 3, 5, 5),
('Óptica Val', 'Centro de salud', '42.87471259587008, -8.549083668770782', 'Óptica que proporciona exámenes de vista y venta de gafas y lentes de contacto.', 3, 5, 5),
('Costa Da Camelia', 'Jardín', '42.874639549512366, -8.549107766852313', 'Jardín botánico con una amplia colección de camelias y otras especies.', 5, 4, 4),
('Goiko', 'Restaurante', '42.874586800459426, -8.549090632743722', 'Hamburguesería gourmet conocida por sus innovadoras combinaciones de sabores.', 2, 3, 4),
('Banco Santander - Smart Red', 'Banco', '42.87453163680812, -8.548857907363718', 'Sucursal moderna del Banco Santander con servicios digitales avanzados.', 4, 3, 5),
('Continental Parking', 'Aparcamiento', '42.87441574750908, -8.548867139368541', 'Aparcamiento subterráneo con plazas amplias y seguridad 24 horas.', 3, 2, 5),
('Calzados Don Antonio', 'Tienda de calzado', '42.87440497838594, -8.548971329428964', 'Zapatería tradicional con una amplia gama de calzado clásico.', 2, 3, 4),
('Miniso', 'Comercio', '42.87454286577223, -8.548592236042769', 'Tienda de productos de diseño japonés a precios asequibles.', 3, 4, 4),
('Decathlon City Santiago', 'Tienda de deportes', '42.87443776744183, -8.548564626950455', 'Tienda de artículos deportivos para diversas disciplinas y niveles.', 4, 3, 5),
('Clínica Laudent S L', 'Centro de salud', '42.874555917785436, -8.54835454453748', 'Clínica dental que ofrece servicios de odontología general y especializada.', 3, 5, 5),
('PrimaPrix', 'Supermercado', '42.87443178423407, -8.54798802987961', 'Supermercado de descuentos con una amplia variedad de productos.', 2, 3, 4),
('Cafetería Milay', 'Bar', '42.874313588017905, -8.549097855203321', 'Cafetería acogedora que ofrece desayunos y meriendas tradicionales.', 3, 4, 4),
('Seco', 'Tienda', '42.874135037730326, -8.54903851871423', 'Tienda de moda urbana con las últimas tendencias en ropa y accesorios.', 2, 3, 4),
('Cruceiro de Agros de Ramírez', 'Atracción turística', '42.873990836616166, -8.549514534498826', 'Monumento histórico que representa la tradición gallega de los cruceiros.', 5, 4, 3),
('Área infantil de Agros de Ramírez', 'Parque', '42.873745038786815, -8.549397941465596', 'Parque infantil equipado con juegos y zonas verdes para el disfrute de los niños.', 4, 5, 5),
('Antía Fernández Estudio', 'Agencia', '42.87368989778338, -8.549129270221325', 'Estudio de interiorismo que ofrece servicios de diseño de espacios personalizados.', 3, 4, 4),
('Conchi Penedo Fogar', 'Tienda', '42.87365017983244, -8.549027759242998', 'Tienda especializada en artículos para el hogar y decoración.', 3, 4, 4),
('Joyería M. Suárez', 'Joyería', '42.87354841755738, -8.550259267879664', 'Joyería de alta gama con diseños exclusivos y personalizados.', 2, 3, 4),
('Todo Consolas', 'Tienda', '42.873548079684916, -8.55064306405813', 'Tienda especializada en la venta de consolas y videojuegos.', 2, 3, 4),
('Dahiana Svelti', 'Centro médico', '42.87325345965936, -8.549563781360407', 'Centro médico especializado en tratamientos estéticos y de bienestar.', 3, 5, 5),
('Restaurante La Planta', 'Restaurante', '42.87451400217048, -8.55063339792438', 'Restaurante que ofrece cocina de autor con ingredientes locales.', 4, 4, 4),
('Gazteka Santiago', 'Restaurante', '42.874421137468595, -8.551123407682692', 'Restaurante de cocina vasca con un toque moderno.', 3, 4, 4),
('Reis Coffee Co.', 'Cafetería', '42.87440021459077, -8.551610895289404', 'Cafetería especializada en cafés de origen y repostería artesanal.', 3, 4, 4),
('TELEKEBAB', 'Restaurante', '42.87422577409019, -8.551939707597672', 'Restaurante de comida rápida especializado en kebabs y platos turcos.', 2, 3, 4),
('KFC', 'Restaurante', '42.87676950129313, -8.545639626393617', 'Restaurante de comida rápida especializado en pollo frito.', 5, 5, 2),
('Café Bar El Muelle', 'Bar', '42.87691009275831, -8.544494264439315', 'Bar acogedor con una gran variedad de bebidas y tapas.', 3, 1, 1),
('Café Tertulia', 'Cafetería', '42.880302344632746, -8.549666552585803', 'Cafetería con ambiente relajado y opciones de café gourmet.', 1, 2, 5),
('Parador de Santiago de Compostela', 'Hostal', '42.88154639656426, -8.545891418476685', 'Hotel histórico de lujo en un edificio emblemático.', 4, 3, 5),
('Restaurante Barrigola', 'Restaurante', '42.866559467985375, -8.555894355532308', 'Restaurante de cocina tradicional gallega con productos de proximidad.', 3, 1, 1),
('Eurostars Gran Hotel Santiago', 'Hotel', '42.87250749983653, -8.557436317258434', 'Hotel moderno con excelentes comodidades y servicio.', 3, 2, 5),
('Hotel Palacio del Carmen, Autograph Collection', 'Hotel', '42.88076390831791, -8.553586006217559', 'Hotel boutique ubicado en un antiguo convento restaurado.', 2, 2, 2),
('Museo do Pobo Galego', 'Museo', '42.882770596100386, -8.5391329229403', 'Museo dedicado a la cultura y tradiciones gallegas.', 1, 5, 1),
('Outlet Área Central', 'Centro Comercial', '42.88250644408807, -8.527624531639068', 'Centro comercial con tiendas de outlet y descuentos.', 4, 4, 1),
('Hotel Eurostars San Lázaro', 'Hotel', '42.88313473007257, -8.512727131498542', 'Hotel de negocios con instalaciones modernas y confortables.', 3, 2, 4),
('Aparcadoiro da Catedral', 'Aparcadoiro', '42.88432934736598, -8.548400914191657', 'Aparcamiento público cerca de la Catedral de Santiago.', 5, 2, 3),
('Sala Malatesta', 'Sala de conciertos', '42.8785361458283, -8.554486031919296', 'Sala de conciertos con programación variada de música en vivo.', 3, 4, 2),
('Cafetería Comedor Fonseca', 'Restaurante', '42.87699876766757, -8.5548521275028', 'Comedor universitario con menús asequibles y saludables.', 1, 2, 3),
('Facultad de Relaciones Laborales ~ USC', 'Escuela universitaria', '42.87394736492044, -8.554282038256488', 'Facultad de la Universidad de Santiago de Compostela.', 3, 2, 3),
('CiTIUS ~ Centro Singular de Investigación en Tecnoloxías Intelixentes', 'Instituto de investigación', '42.87333014358967, -8.557681404067422', 'Centro de investigación en tecnologías avanzadas.', 5, 3, 2),
('Edificio Emprendia', 'Centro de negocios', '42.87236563348628, -8.562964188050296', 'Edificio para el fomento del emprendimiento e innovación.', 1, 4, 2),
('Museo da Forja Artística', 'Museo de escultura', '42.86611566594007, -8.571564853243615', 'Museo dedicado al arte de la forja y escultura en metal.', 1, 4, 4),
('Mercadona', 'Supermercado', '42.84824744113372, -8.580920252528815', 'Supermercado con una gran variedad de productos de alimentación y hogar.', 5, 4, 5),
('La Tienda de Julia', 'Tienda de ropa', '42.87852570381576, -8.5437634347576', 'Boutique de moda con ropa y accesorios exclusivos.', 3, 2, 4),
('Museo da Catedral de Santiago', 'Museo', '42.88023636432958, -8.545181497595454', 'Museo patrimonial con exhibiciones sobre la historia de la catedral.', 5, 4, 5),
('USC ~ Museo de Historia Natural', 'Museo', '42.88673046446591, -8.545692704904601', 'Museo con colecciones de ciencias naturales y biodiversidad.', 4, 3, 4),
('ADMERA Pensión Boutique', 'Pensión', '42.869644056140245, -8.563341511798857', 'Pensión boutique con ambiente acogedor y habitaciones elegantes.', 4, 3, 4),
('Parrilla Casa Miguel', 'Restaurante', '42.862173393806685, -8.54137462048517', 'Restaurante especializado en carnes a la parrilla y cocina tradicional.', 4, 3, 4),
('Bar Biosbardos', 'Bar', '42.85796248800064, -8.540279567268037', 'Bar con ambiente relajado y amplia variedad de bebidas.', 3, 2, 3),
('IES Lamas de Abade', 'Instituto', '42.86258773495622, -8.536077591839094', 'Instituto de educación secundaria con diversos programas académicos.', 3, 2, 4),
('Tapicería Barona', 'Tapicería', '42.86763628061277, -8.534371706904995', 'Tienda especializada en tapicería y restauración de muebles.', 3, 2, 3),
('Albergue Seminario Menor', 'Albergue', '42.87678866561453, -8.536538931784484', 'Albergue con instalaciones cómodas para peregrinos y viajeros.', 4, 3, 4),
('Restaurante A Maceta', 'Restaurante', '42.8816114563791, -8.53551016494038', 'Restaurante de cocina moderna con ingredientes locales.', 5, 4, 5),
('Palacio del Carmen', 'Hotel', '42.880676445907106, -8.552555735013865', 'Hotel elegante con instalaciones de lujo y servicio exclusivo.', 5, 4, 5),
('Hospital HM La Esperanza', 'Hospital', '42.878587138420905, -8.55180144527763', 'Hospital con atención médica especializada y urgencias.', 4, 3, 5),
('Café Tertulia', 'Cafetería', '42.88028532034696, -8.549682500148773', 'Cafetería acogedora con café de especialidad y repostería.', 4, 3, 4),
('A Fonte das Hortas Residencial', 'Hotel', '42.8806902040545, -8.54737580039882', 'Residencial con habitaciones elegantes y ambiente tranquilo.', 4, 3, 4),
('Complexo Deportivo Santa Isabel', 'Gimnasio', '42.88607824554708, -8.548874349286853', 'Gimnasio con equipamiento moderno y actividades deportivas.', 4, 3, 4),
('Casa Lois', 'Hotel', '42.88896320435242, -8.540726305238685', 'Hotel con encanto y atención personalizada.', 4, 3, 4),
('Pabellón Municipal de Vite', 'Centro deportivo', '42.890895687719286, -8.539715632809536', 'Centro deportivo con múltiples canchas y actividades.', 3, 2, 4),
('Agrupación Folclórica Colexiata do Sar', 'Escuela', '42.87152267175259, -8.537298291974375', 'Escuela de danza y música tradicional gallega.', 3, 2, 4),
('Santiago de Compostela', 'Estación de tren', '42.87084645334735, -8.544776151496736', 'Estación ferroviaria con conexiones nacionales e internacionales.', 4, 3, 5),
('Hotel Exe Peregrino', 'Hotel', '42.87169565666591, -8.555569498994032', 'Hotel con instalaciones modernas y vistas panorámicas.', 4, 3, 4),
('Facultad de Ciencias Económicas y Empresariales ~ USC', 'Universidad', '42.887837035551605, -8.54411525006062', 'Facultad de la USC con programas en economía y negocios.', 4, 3, 4),
('El Mesón Do Pulpo', 'Restaurante', '42.88906391999335, -8.547052156094528', 'Restaurante especializado en pulpo y mariscos frescos.', 5, 4, 5),
('Supermercados Dia', 'Supermercado', '42.89353828861913, -8.547360320636248', 'Supermercado con variedad de productos y precios accesibles.', 2, 1, 5),
('ABANCA', 'Banco', '42.892669803263615, -8.54744849412096', 'Sucursal bancaria con servicios financieros y cajeros automáticos.', 3, 2, 4),
('Lavandería Lavamas', 'Lavandería', '42.888320585562916, -8.578248918109491', 'Servicio de lavandería autoservicio y atención personalizada.', 3, 2, 3),
('Gráficas Garabal, S.L.', 'Imprenta', '42.889956597289675, -8.580788970046349', 'Empresa de impresión digital y diseño gráfico.', 3, 2, 4),
('Casa do Cebro', 'Hotel', '42.89291899457712, -8.577339649253458', 'Hotel rural con entorno natural y tranquilidad.', 4, 3, 4),
('Cabañas Compostela', 'Hotel', '42.89738934132037, -8.550427954197856', 'Cabañas de turismo rural con todas las comodidades.', 4, 3, 4),
('NC APARTMENT', 'Apartamento turístico', '42.88633373099383, -8.54482054720939', 'Apartamento turístico con ubicación céntrica y modernas instalaciones.', 4, 3, 4),
('Parking Municipal Belvís', 'Aparcamiento', '42.878775090543826, -8.538913375794387', 'Aparcamiento público con amplio espacio y fácil acceso.', 3, 2, 5),
('Autoservicio Luis', 'Supermercado', '42.87858881697857, -8.534867998309998', 'Tienda de autoservicio con productos básicos y frescos.', 2, 1, 4),
('Frutasita Covirán', 'Supermercado', '42.879331777301054, -8.534041877928944', 'Supermercado con frutas y verduras frescas.', 2, 1, 4),
('Pavillón Fontiñas', 'Polideportivo', '42.88019008048881, -8.530027479377788', 'Instalaciones deportivas con múltiples disciplinas.', 3, 2, 4),
('Hotel Windsor', 'Hotel', '42.87458571073048, -8.54694081130562', 'Hotel céntrico con cómodas habitaciones.', 3, 2, 3),
('LÁPICES 4', 'Imprenta', '42.875980809971566, -8.550206422819103', 'Empresa de impresión digital con servicios personalizados.', 3, 2, 4),
('Bar Princesa', 'Bar', '42.238667723771414, -8.7258472579954', 'Bar tradicional con ambiente acogedor, conocido por sus tapas y amplia selección de bebidas.', 3, 4, 3),
('CASA GALLETTA', 'Cafetería', '42.23840078470129, -8.725791056718439', 'Cafetería especializada en galletas artesanales y repostería, con opciones para dietas especiales.', 4, 5, 4),
('Kilometro Zero Vigo', 'Tienda de ropa', '42.237997768908265, -8.726291097702257', 'Boutique de moda sostenible que ofrece prendas de diseñadores locales y materiales ecológicos.', 5, 4, 3),
('Farmacia', 'Farmacia', '42.23788920761642, -8.725624335182767', 'Farmacia de barrio que proporciona atención personalizada y una amplia gama de productos farmacéuticos.', 3, 4, 5),
('ALE-HOP', 'Tienda de regalos', '42.23795656359701, -8.725890574498512', 'Tienda de regalos y accesorios divertidos y originales, ideal para encontrar detalles únicos.', 2, 3, 4),
('La Centralita', 'Bar', '42.23831425458637, -8.7260309809203', 'Bar moderno con una amplia selección de cervezas artesanales y ambiente animado.', 3, 4, 3),
('Bar Alta Fidelidad', 'Bar', '42.23844333064257, -8.726391680542013', 'Bar temático dedicado a la música, con una cuidada selección de vinilos y conciertos en vivo.', 3, 4, 3),
('Empanadillas PAYMA', 'Panadería', '42.23829439670803, -8.72668605298134', 'Panadería artesanal famosa por sus empanadillas y productos de bollería recién horneados.', 4, 3, 4),
('Pintxoteca Mar', 'Bar', '42.23845425244965, -8.726639114321538', 'Bar especializado en pintxos y tapas de mariscos frescos, con ambiente marinero.', 4, 4, 3),
('Tapería Casco Vello', 'Restaurante', '42.23882385524868, -8.72640945017675', 'Restaurante tradicional que ofrece tapas y platos típicos de la cocina gallega en un entorno rústico.', 3, 4, 3),
('Oliveira da Colexiata', 'Arboreto', '42.239351820030855, -8.726270310583978', 'Pequeño jardín botánico que alberga una colección de olivos centenarios y otras especies autóctonas.', 5, 3, 2),
('Alimentación Rivera', 'Tienda de alimentación', '42.23943522167975, -8.726518414916821', 'Tienda de barrio que ofrece productos frescos y de proximidad, con atención cercana al cliente.', 4, 4, 3),
('Hostal A Pedra', 'Hotel', '42.239555856012544, -8.726796694103202', 'Alojamiento familiar situado en el casco antiguo, con habitaciones cómodas y trato amable.', 3, 4, 3),
('Centro de Día', 'Centro de día', '42.23978347201681, -8.727257028225488', 'Centro que ofrece atención diurna a personas mayores, con actividades recreativas y servicios de cuidado.', 4, 5, 5),
('7Pecados', 'Cervecería', '42.23933270713776, -8.727782741191502', 'Cervecería que ofrece una amplia variedad de cervezas internacionales y locales, en un ambiente distendido.', 3, 4, 3),
('Frutería Maty', 'Frutería', '42.23896136977458, -8.728402331473655', 'Frutería que ofrece productos frescos y de temporada, con énfasis en la calidad y el origen local.', 4, 4, 3),
('Clases de Tambor Tradicional Galego', 'Escuela', '42.23870470884774, -8.729031980040912', 'Escuela dedicada a la enseñanza del tambor tradicional gallego, promoviendo la cultura y música local.', 3, 5, 2),
('Fortaleza de San Sebastián', 'Castillo', '42.236895145228914, -8.726599215308807', 'Antigua fortaleza que ofrece vistas panorámicas de la ciudad y el puerto, con exposiciones históricas.', 2, 3, 2),
('Concello de Vigo', 'Ayuntamiento', '42.23626761915608, -8.726668952742372', 'Sede del gobierno municipal de Vigo, ubicada en un edificio histórico en el centro de la ciudad.', 3, 4, 4),
('NAKEZ COFFEE', 'Cafetería', '42.23658436172993, -8.72793361545953', 'Cafetería de estilo moderno que ofrece cafés de especialidad y repostería artesanal en un ambiente acogedor.', 4, 4, 4),
('Parking Praza do Rei', 'Aparcamiento', '42.235468308697314, -8.72634038330295', 'Aparcamiento subterráneo con acceso al centro histórico de la ciudad.', 3, 3, 5),
('Restaurante Cañaveral', 'Restaurante', '42.238667723771414, -8.7258472579954', 'Restaurante que ofrece una mezcla de cocina gallega y moderna en un entorno elegante.', 4, 4, 3),
('Casco Vello Alto', 'Asociación sociocultural', '42.237618728677845, -8.726576081832048', 'Asociación que promueve la cultura y el arte en el casco histórico de Vigo.', 4, 5, 3),
('CaixaBank Store', 'Banco', '42.23739433182123, -8.72620593699246', 'Sucursal bancaria moderna con asesoramiento financiero y servicios digitales.', 3, 3, 5),
('Concatedral - Basílica de Santa María de Vigo', 'Catedral', '42.239309622726054, -8.726179247243671', 'Iglesia histórica de estilo gótico con un gran valor arquitectónico y cultural.', 2, 3, 3),
('SB5inco', 'Oficinas de empresa', '42.239702801218634, -8.725787644732211', 'Centro de oficinas con espacios coworking y salas de reuniones para emprendedores.', 3, 3, 4),
('Mercado da Pedra', 'Restaurante', '42.239698829732156, -8.726637904982576', 'Mercado gastronómico con variedad de puestos de comida tradicional gallega.', 4, 4, 3),
('Instituto Camões', 'Centro cultural', '42.239059416944244, -8.726640587192856', 'Institución dedicada a la promoción de la lengua y cultura portuguesa en Vigo.', 3, 5, 3),
('Aproinppa', 'Centro de formación', '42.23712900483265, -8.725562805585549', 'Centro especializado en la formación profesional en diversas áreas laborales.', 3, 4, 4),
('Grupo Externa', 'Consultoría', '42.23698602528722, -8.725133652148351', 'Empresa de consultoría que ofrece servicios de recursos humanos y gestión empresarial.', 3, 3, 4),
('Dra. Rosa María Olivares', 'Centro médico', '42.23682914457572, -8.724956626350906', 'Clínica médica privada con especialidades en medicina general y estética.', 3, 3, 4),
('Eurofirms', 'Empresa de trabajo temporal', '42.237295813903316, -8.724465782099626', 'Agencia de empleo temporal con ofertas en diversos sectores laborales.', 3, 3, 4),
('Oficina Municipal Xestora da Rehabilitación da Vivienda', 'Oficina', '42.2375130774427, -8.726980236623184', 'Oficina del ayuntamiento que asesora sobre rehabilitación de viviendas.', 4, 4, 4),
('Bar Burla Negra', 'Bar', '42.23850687568099, -8.727608062333642', 'Bar con temática pirata y ambiente alternativo, popular entre jóvenes y universitarios.', 3, 4, 3),
('Estudios Ross Peluquería y Estética', 'Peluquería', '42.23880449740137, -8.726920619614834', 'Salón de peluquería y estética con tratamientos de belleza personalizados.', 3, 3, 4),
('Visionlab', 'Óptica', '42.42950680525152, -8.638044770804767', 'Óptica especializada en revisión de la vista y venta de gafas graduadas y de sol.', 3, 4, 4),
('Angel Daniel Javier Martín Valdés', 'Médico', '42.42974304203943, -8.637915998700636', 'Consulta médica con atención en diversas especialidades y trato cercano al paciente.', 4, 5, 5),
('Naty C.b.', 'Tienda', '42.429516607446814, -8.638553023341599', 'Pequeña tienda de barrio con productos variados y atención personalizada.', 3, 3, 4),
('Cash Converters', 'Tienda', '42.42946785428825, -8.638778805430826', 'Tienda de compra y venta de artículos de segunda mano, con precios asequibles.', 3, 4, 3),
('Supermercados Gadis', 'Supermercado', '42.42969622543036, -8.63872777019873', 'Supermercado con una amplia selección de productos frescos y de alimentación general.', 4, 4, 4),
('LA BUENA VIDA PONTEVEDRA', 'Restaurante', '42.429410295599496, -8.639341576356209', 'Restaurante con cocina casera y ambiente acogedor, especializado en comida mediterránea.', 4, 4, 4),
('Oficina de emprego', 'Oficina', '42.42978926273627, -8.639096659058545', 'Oficina pública de empleo que ofrece asesoramiento y gestión de ofertas laborales.', 3, 4, 5),
('Edificio administrativo Benito Corbal', 'Oficina', '42.42991794641441, -8.639080565804651', 'Edificio gubernamental con distintos servicios administrativos para la ciudadanía.', 3, 4, 5),
('Essence salones belleza lowcost', 'Peluquería', '42.429987237516606, -8.639395725362037', 'Salón de belleza con servicios de peluquería y estética a precios económicos.', 3, 4, 3),
('Farmacia Martín Mariño - Benito Corbal 50', 'Farmacia', '42.42966156867049, -8.63950033151307', 'Farmacia con atención personalizada y amplia gama de medicamentos y productos de salud.', 4, 4, 5),
('José Ramón Vázquez Cueto', 'Abogado', '42.42982569664854, -8.639692962173141', 'Despacho de abogados especializado en derecho civil y laboral.', 3, 4, 4),
('Alfonso Reino Fraga', 'Abogado', '42.429893008108245, -8.63995715976144', 'Abogado con experiencia en derecho penal y administrativo.', 3, 4, 4),
('CENTRO PODOLÓGICO PODOSPONT', 'Podólogo', '42.42987123087965, -8.640193194152484', 'Centro especializado en podología y tratamientos para el cuidado de los pies.', 4, 4, 5),
('Stradivarius', 'Tienda', '42.429967125783485, -8.640239922955129', 'Tienda de moda juvenil con las últimas tendencias en ropa y complementos.', 3, 3, 4),
('Copistería Barga2', 'Copistería', '42.42998110681629, -8.640512041750837', 'Copistería con servicios de impresión, encuadernación y material de oficina.', 3, 4, 4),
('PullBear', 'Tienda', '42.43009197243311, -8.640592508019491', 'Tienda de moda urbana con una amplia selección de ropa y accesorios.', 3, 3, 4),
('Academia Susa Suárez', 'Escuela', '42.43007885664481, -8.640930131081133', 'Academia de formación con cursos de refuerzo escolar e idiomas.', 4, 4, 4),
('Muface', 'Oficina', '42.430118204001225, -8.641289882365149', 'Oficina de asistencia sanitaria y prestaciones para funcionarios del Estado.', 3, 4, 5),
('Druni Perfumerías', 'Perfumería', '42.4303879430743, -8.640862405303446', 'Perfumería con una amplia gama de fragancias y productos de cosmética.', 3, 4, 4),
('Croquetería El Crack', 'Restaurante', '42.43070172981968, -8.639728166166295', 'Restaurante especializado en croquetas gourmet de diferentes sabores.', 4, 4, 3),
('Vidal Alonso Vidal Antonio', 'Otorrinolaringólogo', '42.430457976056566, -8.639082089069777', 'Clínica especializada en tratamientos de oído, nariz y garganta.', 4, 5, 5),
('Fundacion amigos de galicia', 'Fundación', '42.4300353023093, -8.63887119980623', 'Organización sin ánimo de lucro que ofrece apoyo a personas en situación de vulnerabilidad.', 4, 5, 5),
('Centro Atlántico - Podología y cirugía del pie', 'Podólogo', '42.42977793516558, -8.638018257338866', 'Centro especializado en podología y cirugía podológica avanzada.', 4, 4, 5),
('LUVA Boxing Club', 'Gimnasio', '42.430090735095206, -8.637758083065037', 'Club de boxeo con entrenamientos para todos los niveles y clases dirigidas.', 3, 4, 3),
('Bar Disc Burgers', 'Restaurante', '42.42958193947713, -8.636642284112867', 'Hamburguesería con un ambiente informal y una carta variada de burgers gourmet.', 4, 4, 3),
('Banco Santander', 'Banco', '42.429267157242464, -8.637111670693258', 'Sucursal bancaria con servicios de atención al cliente y cajeros automáticos.', 3, 3, 5),
('Hospital Provincial de Pontevedra', 'Hospital', '42.4286209059181, -8.637754781764917', 'Hospital público con múltiples especialidades médicas y urgencias 24h.', 4, 5, 5),
('Parking CLUBÖ Véteris Centro Cidade. ¡Höla!', 'Estacionamiento', '42.42826365458234, -8.636536002172441', 'Aparcamiento en el centro de la ciudad con acceso a zonas comerciales.', 3, 3, 5),
('Centro Veterinario Pontevedra', 'Veterinario', '42.43056346156102, -8.638751881682888', 'Clínica veterinaria con atención médica para mascotas y tienda de productos especializados.', 4, 5, 4),
('Hospital Quirónsalud Miguel Domínguez', 'Hospital', '42.429534425280714, -8.64214919508817', 'Hospital privado con servicios médicos avanzados y atención especializada.', 4, 5, 5),
('Lavandería Autoservicio Oso Blanco', 'Lavandería', '42.43015538605398, -8.638802832760321', 'Lavandería autoservicio con máquinas modernas y precios económicos.', 3, 4, 4),
('CLIKRS', 'Tienda', '42.429507945998196, -8.640505786489559', 'Tienda de electrónica y accesorios con productos innovadores y de calidad.', 3, 3, 4),
('Infortronic', 'Tienda', '42.42936342336235, -8.640040308243561', 'Tienda de informática con reparación de dispositivos y venta de accesorios.', 3, 4, 4),
('Seven - Tienda de Ropa Urbana', 'Tienda', '42.42904270070664, -8.63941803575221', 'Tienda de moda urbana con ropa exclusiva y marcas independientes.', 3, 3, 4),
('Supera 24h Fitness Pontevedra', 'Gimnasio', '42.42888233876896, -8.63944754005375', 'Gimnasio abierto 24h con máquinas de última generación y clases dirigidas.', 4, 4, 4),
('Samantha Nails Pontevedra', 'Centro de estética', '42.42905581671139, -8.639939725405442', 'Salón de belleza especializado en manicura, pedicura y tratamientos estéticos.', 3, 4, 4),
('Zemsania Global Group', 'Consultora informática', '43.36976301175798, -8.400845398647952', 'Empresa de consultoría especializada en soluciones tecnológicas y transformación digital.', 4, 4, 5),
('Bonilla a la Vista', 'Churrería', '43.36972255344786, -8.400724567184698', 'Famosa churrería con tradición en la elaboración de churros y patatas fritas.', 4, 5, 5),
('Joyerías Aresso', 'Joyería', '43.3696577226054, -8.400980047884865', 'Joyería con una amplia colección de piezas exclusivas en oro y plata.', 3, 4, 4),
('Clínica Médico Dental Pardiñas', 'Clínica dental', '43.36954853366358, -8.401000164452212', 'Clínica odontológica especializada en tratamientos dentales avanzados.', 4, 5, 5),
('Cuchillería Las Burgas', 'Cuchillería', '43.369569981504974, -8.401307277382552', 'Tienda especializada en cuchillos y herramientas de corte de alta calidad.', 3, 4, 4),
('AXPE Consulting', 'Consultora informática', '43.369461106769855, -8.401356975071403', 'Consultora de tecnología e innovación para empresas y negocios.', 4, 4, 5),
('Hostal Linar', 'Hotel', '43.36965008252004, -8.401428743366536', 'Alojamiento céntrico con habitaciones confortables y buen servicio.', 3, 4, 4),
('Farmacia Obelisco', 'Farmacia', '43.36930846352876, -8.40196421508322', 'Farmacia con atención especializada y amplia gama de productos de salud.', 4, 4, 5),
('El Filon de Oro', 'Administración de loterías', '43.36919927395722, -8.402283397955218', 'Administración de loterías con gran variedad de juegos y sorteos.', 3, 4, 4),
('Sporting Club Casino', 'Club', '43.36902086557041, -8.401853777474757', 'Club social exclusivo con actividades deportivas y culturales.', 4, 4, 4),
('La Cúpula', 'Club nocturno', '43.36913785473287, -8.401067890234179', 'Discoteca con ambiente vibrante y música en vivo.', 3, 3, 4),
('Subdelegacion del Gobierno', 'Delegación regional del gobierno', '43.36946542319236, -8.400515355172027', 'Oficina gubernamental que gestiona trámites y servicios administrativos.', 3, 4, 5),
('Tatiana Villanueva', 'Salón de manicura y pedicura', '43.36975984333498, -8.400209583343903', 'Centro de estética especializado en uñas y tratamientos de belleza.', 3, 4, 4),
('Heladería Colón', 'Heladería', '43.369964571732446, -8.399410285060641', 'Heladería tradicional con una amplia variedad de sabores artesanales.', 4, 4, 4),
('Sheraton', 'Cafetería', '43.36996067214997, -8.39894089848222', 'Cafetería con un ambiente acogedor y una gran selección de cafés y dulces.', 3, 4, 4),
('Teatro Rosalía de Castro', 'Teatro', '43.37043641930155, -8.398600257935447', 'Teatro emblemático con una programación variada de obras y espectáculos.', 4, 5, 5),
('Mesón El Serrano', 'Mesón', '43.37016588731378, -8.400993123657152', 'Restaurante tradicional con platos típicos y ambiente rústico.', 4, 4, 4),
('Caixabank', 'Banco', '43.37040497916459, -8.402110598987864', 'Sucursal bancaria con servicios financieros y atención personalizada.', 3, 3, 5),
('Academia de Oposiciones Tecad', 'Academia de exámenes civiles', '43.36968672588551, -8.403577096766876', 'Centro de formación para opositores con material actualizado y tutorías.', 4, 4, 4),
('Old Glories', 'Barbería', '43.369737420661416, -8.404321074492401', 'Barbería con estilo clásico y servicios de corte y afeitado.', 3, 4, 4),
('Eurostars Atlántico', 'Hotel', '43.36824132307173, -8.40096932961552', 'Hotel moderno con vistas espectaculares y servicios de lujo.', 4, 4, 5),
('Cantones Centro de Negocios', 'Centro de negocios', '43.36785924841863, -8.400266508548068', 'Espacio empresarial con oficinas y salas de reuniones equipadas.', 4, 4, 5),
('Dux', 'Pub', '43.367900439164366, -8.401538953198143', 'Pub con cócteles exclusivos y música en vivo.', 3, 4, 4),
('Fundación Barrié', 'Fundación', '43.36801058604104, -8.403479981978503', 'Organización sin ánimo de lucro dedicada a proyectos culturales y educativos.', 4, 5, 5),
('Filmoteca de Galicia', 'Cine', '43.367817109980514, -8.404743039538282', 'Cine dedicado a la proyección de películas clásicas e independientes.', 4, 5, 5),
('Viceconsulado de Italia en A Coruña', 'Consulado extranjero', '43.36758498473022, -8.405214736686457', 'Oficina consular que ofrece servicios a ciudadanos italianos en la región.', 3, 4, 5),
('Chífán l Restaurante Peruano', 'Restaurante peruano', '43.37029755046705, -8.40090782076663', 'Restaurante con auténtica gastronomía peruana y sabores tradicionales.', 4, 5, 5),
('Bonilla a la Vista', 'Churrería', '43.37009447641548, -8.401402888571711', 'Famosa churrería con tradición en la elaboración de churros y patatas fritas.', 4, 5, 5),
('Ultramarinos Galera', 'Restaurante', '43.370289453602915, -8.400242722460977', 'Restaurante con platos tradicionales y productos gourmet de calidad.', 4, 4, 4),
('Bernardo Regos Concha', 'Tienda de deportes', '43.370228767830945, -8.400561958554633', 'Tienda especializada en artículos deportivos y equipamiento.', 3, 4, 4),
('Semicentro', 'Zapatería', '43.37019513407421, -8.400930427018112', 'Zapatería con calzado de moda y opciones cómodas para el día a día.', 3, 4, 4),
('Quai', 'Cafetería', '43.369640418124064, -8.399840109054118', 'Cafetería con ambiente moderno y una gran selección de cafés y tés.', 3, 4, 4),
('Cantante', 'Cafetería', '43.36971864133606, -8.39961305628122', 'Cafetería con repostería casera y ambiente acogedor.', 3, 4, 4),
('Los Hippies', 'Mercadillo', '43.370264582556345, -8.398785594799083', 'Mercadillo con una variedad de productos artesanales y ropa vintage.', 3, 3, 4),
('General Optica - Visión y Audición', 'Óptica', '43.37042301459721, -8.399470970037909', 'Óptica con revisiones visuales y audífonos de última tecnología.', 4, 4, 5),
('Coimbra Business School', 'Universidad', '40.2096384221346, -8.452569866954976', 'Institución de educación superior con enfoque en negocios y administración.', 4, 5, 5),
('Supermercado Quaresma-Amanhecer', 'Supermercado', '40.20964475208557, -8.455992185375562', 'Supermercado local con productos de proximidad y atención cercana.', 4, 4, 5),
('Parque Infantil Piscinas São Martinho do Bispo', 'Parque infantil', '40.20965781043842, -8.453785702609794', 'Espacio recreativo para niños con juegos seguros y entorno familiar.', 4, 4, 4),
('Loja Agrária', 'Tienda de alimentación', '40.21279486325248, -8.452532118468865', 'Tienda con productos frescos, locales y de origen agrícola.', 4, 4, 4),
('Claires', 'Piercing de orejas', '40.21260852732691, -8.446829741703434', 'Tienda especializada en accesorios y servicios de piercing con enfoque juvenil.', 4, 4, 4),
('Palhaços dOpital', 'Artista', '40.20970847868682, -8.448916586438262', 'Colectivo artístico dedicado a la animación hospitalaria y apoyo emocional.', 5, 5, 4),
('Polytechnic Institute of Coimbra', 'Universidad', '40.20480000433043, -8.453829504382684', 'Centro universitario con diversas facultades y enfoque en innovación.', 4, 5, 5),
('Juliana Sá Rico - Terapia da fala', 'Logopeda', '40.20584876173212, -8.46310010481257', 'Especialista en terapia del lenguaje con atención personalizada.', 4, 5, 5),
('Quinta da Palmeira - Country House Retreat & Spa', 'Hotel', '40.258969697266146, -7.939674630765688', 'Alojamiento rural con spa, rodeado de naturaleza y tranquilidad.', 5, 4, 4),
('Luís Ismael Xavier Lourenço', 'Taller de reparación de automóviles', '40.81828766615519, -7.258591458933494', 'Taller mecánico con servicio eficiente y atención personalizada.', 4, 4, 4),
('Estadio do Dragão- Portugal', 'Estadio', '41.1617004682546, -8.583724312239333', 'Estadio emblemático y moderno, sede del FC Porto.', 4, 4, 5),
('Tasca da Badalhoca', 'Restaurante', '41.16642955016132, -8.65550793712052', 'Restaurante tradicional con platos típicos y ambiente animado.', 4, 4, 4),
('Vale Pisão - Nature Resort - Golfe', 'Campo de golf', '41.27575336707433, -8.501733444095429', 'Campo de golf integrado en un resort ecológico en plena naturaleza.', 5, 4, 4),
('Junta de Freguesia de Vilares de Vilariça', 'Oficina de gobierno local', '41.391103057282635, -7.036558625353761', 'Institución pública que gestiona los servicios y eventos comunitarios.', 4, 5, 4),
('SHS - Unidade de Braga', 'Endoscopista', '41.54727174398203, -8.423802637763453', 'Centro médico especializado con instalaciones modernas y atención inclusiva.', 4, 5, 5),
('Sonho Da Seara - Turismo Rural E Natureza, Lda.', 'Hotel', '41.88066934130262, -8.526459789777922', 'Hotel rural con enfoque ecológico y entorno natural privilegiado.', 5, 4, 4),
('Café Sol Nascente', 'Cafetería', '41.798281635435714, -7.666867026152312', 'Cafetería acogedora con productos locales y ambiente relajado.', 4, 4, 4);

-- Insertar LocalesFotos (Ejemplo sin datos binarios reales)
INSERT INTO LocalesFotos (LocalID) VALUES
(1), (2), (3);

-- Insertar Favoritos
INSERT INTO Favoritos (UsuarioNickname, LocalID) VALUES
('juan23', 1),
('maria89', 2),
('carlos_m', 3),
('juan23', 3);

-- Insertar Opiniones
INSERT INTO Opiniones (UsuarioNickname, LocalID, ResenaTexto, Ecosostenible, InclusionSocial, Accesibilidad) VALUES
('juan23', 1, 'Excelente lugar con opciones saludables.', 5, 4, 5),
('maria89', 2, 'Un ambiente perfecto para leer y tomar algo.', 3, 5, 4),
('carlos_m', 3, 'Muy buen sitio para pasar el día.', 5, 5, 5);

-- Insertar OpinionesFotos (Ejemplo sin datos binarios reales)
INSERT INTO OpinionesFotos (OpinionID) VALUES
(1), (2), (3);

