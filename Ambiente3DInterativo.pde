float camX = 0, camY = 0, camZ = 2000;
float camAngleX = 0, camAngleY = 0;
float camSpeed = 10;
PImage parede, chao, esfera, cubo, piramide, tetraedro, octaedro, prismaHex, cilindro, cone, torus, prismaTriangular;

void setup() { // Janela 3D e texturas
  size(800, 600, P3D);
  parede = loadImage("Texturas/parede.jpg");
  chao = loadImage("Texturas/chao.jpg");
  esfera = loadImage("Texturas/esfera.jpg");
  cubo = loadImage("Texturas/cubo.jpg");
  piramide = loadImage("Texturas/piramide.jpg");
  tetraedro = loadImage("Texturas/tetraedro.jpg");
  octaedro = loadImage("Texturas/octaedro.jpg");
  prismaHex = loadImage("Texturas/prismaHex.jpg");
  cilindro = loadImage("Texturas/cilindro.jpg");
  cone = loadImage("Texturas/cone.jpg");
  torus = loadImage("Texturas/torus.jpg");
  prismaTriangular = loadImage("Texturas/prismaTriangular.jpg");
  noStroke();
}

void movimentoCamera() {
  // Movimento usando mouse e teclado
  camAngleY = map(mouseX, 0, width, -PI, PI);
  camAngleX = map(mouseY, 0, height, -HALF_PI, HALF_PI);

  if (keyPressed) {
    if (key == 'a' || key == 'A') {
      camX += sin(camAngleY) * camSpeed;
      camZ -= cos(camAngleY) * camSpeed;
    }
    if (key == 'd' || key == 'D') {
      camX -= sin(camAngleY) * camSpeed;
      camZ += cos(camAngleY) * camSpeed;
    }
    if (key == 's' || key == 'S') {
      camX -= cos(camAngleY) * camSpeed;
      camZ -= sin(camAngleY) * camSpeed;
    }
    if (key == 'w' || key == 'W') {
      camX += cos(camAngleY) * camSpeed;
      camZ += sin(camAngleY) * camSpeed;
    }
  }

  // Define a posição da câmera
  float eyeX = camX + cos(camAngleX) * cos(camAngleY) * camZ;
  float eyeY = camY + sin(camAngleX) * camZ;
  float eyeZ = camZ + sin(camAngleY) * cos(camAngleX) * camZ;

  camera(camX, camY, camZ, eyeX, eyeY, eyeZ, 0, 1, 0);
}

void draw() {

  movimentoCamera();

  background(0);
  lights();

  // Criando e texturizando a parede
  pushMatrix();
  translate(0, 0, -200);
  fill(255);
  box(2500, 400, 10);
  popMatrix();

  beginShape();
  texture(parede);
  vertex(-1250, -200, -194, 0, 0);
  vertex(1250, -200, -194, parede.width, 0);
  vertex(1250, 200, -194, parede.width, parede.height);
  vertex(-1250, 200, -194, 0, parede.height);
  endShape();

  // Colocando nome na parede
  pushMatrix();
  translate(-1100, 100, -193);
  fill(255);
  textSize(32);
  textAlign(CENTER, CENTER);
  text("NOME:", 0, -16);
  text("Gabriel Couto Correa", 0, 16);
  popMatrix();


  // Criando e texturizando o chão
  pushMatrix();
  translate(0, 200, 0);
  fill(255);
  rotateX(HALF_PI);
  box(2500, 400, 10);
  popMatrix();

  beginShape();
  texture(chao);
  vertex(-1250, 194, -200, 0, 0);
  vertex(1250, 194, -200, chao.width, 0);
  vertex(1250, 194, 200, chao.width, chao.height);
  vertex(-1250, 194, 200, 0, chao.height);
  endShape();

  //////////////////////////////////////////////////////////////////////////////////

  // Definindo as Variáveis do Torus
  float torusX = 900;
  float torusY = 0;
  float torusZ = 0;
  float torusScale = 0.5;
  float radius1 = 100;
  float radius2 = 50;
  int detail1 = 60;
  int detail2 = 30;
  float textureScale = 1.0;

  // Posição do objeto, animação e tamanho
  pushMatrix();
  translate(torusX, torusY, torusZ);
  rotateX(frameCount * 0.01);
  rotateY(frameCount * 0.01);
  rotateZ(frameCount * 0.01);
  scale(torusScale);

  // Criando Torus e aplicando a Textura
  for (int i = 0; i < detail1; i++) {
    beginShape(TRIANGLE_STRIP);
    texture(torus);
    for (int j = 0; j <= detail2; j++) {
      for (int k = 1; k >= 0; k--) {
        float theta = map(j % detail2, 0, detail2, 0, TWO_PI);
        float phi = map(i + k, 0, detail1, 0, TWO_PI);
        float x = (radius1 + radius2 * cos(phi)) * cos(theta);
        float y = (radius1 + radius2 * cos(phi)) * sin(theta);
        float z = radius2 * sin(phi);

        // Coordenadas da textura
        float u = (float)j / detail2;
        float v = (float)(i + k) / detail1;

        // Ajuste da escala da textura nos vértices
        float textureU = u * textureScale * torus.width;
        float textureV = v * textureScale * torus.height;

        vertex(x, y, z, textureU, textureV);
      }
    }
    endShape();
  }
  popMatrix();

  // Nome do Torus
  pushMatrix();
  translate(torusX, torusY - 110, 0 +torusZ);
  fill(255);
  textSize(32);
  textAlign(CENTER, CENTER);
  text("TORUS", 0, 0);
  popMatrix();

  //////////////////////////////////////////////////////////////////////////////////

  // Definindo as Variáveis da esfera
  float esferaX = 700;
  float esferaY = 0;
  float esferaZ = 0;
  float scalaEsfera = 1.0;
  int detail = 40;

  // Posição do objeto, animação e tamanho
  pushMatrix();
  translate(esferaX, esferaY, esferaZ);
  noStroke();
  rotateX(frameCount * 0.01);
  rotateY(frameCount * 0.02);
  beginShape(TRIANGLE_STRIP);
  scale(scalaEsfera);
  texture(esfera);

  // Criando a esfera e aplicando a textura
  float r = 60;
  for (int i = 0; i <= detail; i++) {
    float lat0 = PI * (-0.5 + (float) (i - 1) / detail);
    float z0  = sin(lat0);
    float zr0 =  cos(lat0);

    float lat1 = PI * (-0.5 + (float) i / detail);
    float z1 = sin(lat1);
    float zr1 = cos(lat1);

    for (int j = 0; j <= detail; j++) {
      float lng = 2 * PI * (float) (j - 1) / detail;
      float x = cos(lng);
      float y = sin(lng);

      float u = (float) (j - 1) / detail;
      float v = (float) (i - 1) / detail;
      vertex(x * zr0 * r, y * zr0 * r, z0 * r, u * esfera.width, v * esfera.height);

      u = (float) (j - 1) / detail;
      v = (float) i / detail;
      vertex(x * zr1 * r, y * zr1 * r, z1 * r, u * esfera.width, v * esfera.height);
    }
  }
  endShape();
  popMatrix();

  // Nome da esfera
  pushMatrix();
  translate(esferaX, esferaY - 95, esferaZ);
  fill(255);
  textSize(32);
  textAlign(CENTER);
  text("ESFERA", 0, 0);
  popMatrix();

  //////////////////////////////////////////////////////////////////////////////////

  // Definindo as Variáveis da pirâmide
  float piramideX = 500;
  float piramideY = 0;
  float piramideZ = 0;
  float scalePiramide = 0.5;
  float escalaTextura = 0.5;

  // Posição do objeto, animação e tamanho
  pushMatrix();
  translate(piramideX, piramideY, -50 + piramideZ);
  noStroke();
  rotateX(PI/2);
  rotateZ(-PI/6);
  rotateZ(frameCount * 0.02);
  scale(scalePiramide);
  texture(piramide);

  // Criando a pirâmide e aplicando a textura

  // Lado 1
  beginShape();
  texture(piramide);
  vertex(-100, -100, -100, 0, piramide.height * escalaTextura);
  vertex( 100, -100, -100, piramide.width * escalaTextura, piramide.height * escalaTextura);
  vertex(   0, 0, 100, piramide.width / 2 * escalaTextura, 0);
  endShape();

  // Lado 2
  beginShape();
  texture(piramide);
  vertex( 100, -100, -100, 0, piramide.height * escalaTextura); // Alterando a coordenada de textura (0, 1)
  vertex( 100, 100, -100, piramide.width * escalaTextura, piramide.height * escalaTextura);
  vertex(   0, 0, 100, piramide.width / 2 * escalaTextura, 0);
  endShape();

  // Lado 3
  beginShape();
  texture(piramide);
  vertex( 100, 100, -100, 0, piramide.height * escalaTextura); // Alterando a coordenada de textura (0, 1)
  vertex(-100, 100, -100, piramide.width * escalaTextura, piramide.height * escalaTextura);
  vertex(   0, 0, 100, piramide.width / 2 * escalaTextura, 0);
  endShape();

  // Lado 4
  beginShape();
  texture(piramide);
  vertex(-100, 100, -100, 0, piramide.height * escalaTextura); // Alterando a coordenada de textura (0, 1)
  vertex(-100, -100, -100, piramide.width * escalaTextura, piramide.height * escalaTextura);
  vertex(   0, 0, 100, piramide.width / 2 * escalaTextura, 0);
  endShape();

  // Base
  beginShape();
  texture(piramide);
  vertex(-100, -100, -100, 0, piramide.height * escalaTextura);
  vertex( 100, -100, -100, piramide.width * escalaTextura, piramide.height * escalaTextura);
  vertex( 100, 100, -100, piramide.width * escalaTextura, piramide.height * escalaTextura);
  vertex(-100, 100, -100, piramide.width / 2 * escalaTextura, 0);
  endShape();
  popMatrix();

  // Nome da pirâmide
  pushMatrix();
  translate(piramideX, piramideY - 110, 0 + piramideZ);
  fill(255);
  textSize(32);
  textAlign(CENTER, CENTER);
  text("PIRÂMIDE", 0, 0);
  popMatrix();

  //////////////////////////////////////////////////////////////////////////////////

  // Definindo as Variáveis do cubo
  float cuboX = 300;
  float cuboY = 0;
  float cuboZ = 0;
  float escalaCubo = 0.8;

  // Posição do objeto, animação e tamanho
  pushMatrix();
  translate(cuboX, cuboY, -50 + cuboZ);
  rotateX(frameCount * 0.01);
  rotateY(frameCount * 0.02);
  scale(escalaCubo);
  noStroke();

  // Criando a cubo e aplicando a textura

  // Frente
  beginShape();
  texture(cubo);
  vertex(-50, -50, 50, 0, 0);
  vertex(50, -50, 50, cubo.width, 0);
  vertex(50, 50, 50, cubo.width, cubo.height);
  vertex(-50, 50, 50, 0, cubo.height);
  endShape();

  // Trás
  beginShape();
  texture(cubo);
  vertex(50, -50, -50, 0, 0);
  vertex(-50, -50, -50, cubo.width, 0);
  vertex(-50, 50, -50, cubo.width, cubo.height);
  vertex(50, 50, -50, 0, cubo.height);
  endShape();

  // Direita
  beginShape();
  texture(cubo);
  vertex(50, -50, 50, 0, 0);
  vertex(50, -50, -50, cubo.width, 0);
  vertex(50, 50, -50, cubo.width, cubo.height);
  vertex(50, 50, 50, 0, cubo.height);
  endShape();

  // Esquerda
  beginShape();
  texture(cubo);
  vertex(-50, -50, -50, 0, 0);
  vertex(-50, -50, 50, cubo.width, 0);
  vertex(-50, 50, 50, cubo.width, cubo.height);
  vertex(-50, 50, -50, 0, cubo.height);
  endShape();

  // Topo
  beginShape();
  texture(cubo);
  vertex(-50, -50, -50, 0, 0);
  vertex(50, -50, -50, cubo.width, 0);
  vertex(50, -50, 50, cubo.width, cubo.height);
  vertex(-50, -50, 50, 0, cubo.height);
  endShape();

  // Base
  beginShape();
  texture(cubo);
  vertex(-50, 50, 50, 0, 0);
  vertex(50, 50, 50, cubo.width, 0);
  vertex(50, 50, -50, cubo.width, cubo.height);
  vertex(-50, 50, -50, 0, cubo.height);
  endShape(); // Finaliza a definição da forma personalizada
  popMatrix();

  // Nome do cubo
  pushMatrix();
  translate(cuboX, cuboY - 110, 0 + cuboZ);
  fill(255);
  textSize(32);
  textAlign(CENTER, CENTER);
  text("CUBO", 0, 0);
  popMatrix();

  //////////////////////////////////////////////////////////////////////////////////

  // Definindo as Variáveis do tetraedro
  int[][] faces = {
    {0, 1, 2},
    {0, 1, 3},
    {0, 2, 3},
    {1, 2, 3}
  };
  float[][] vertices = {
    { 1, 1, 1},
    {-1, -1, 1},
    {-1, 1, -1},
    { 1, -1, -1}
  };
  float tetraedroX = 100;
  float tetraedroY = 0;
  float tetraedroZ = 0;
  float escalaTetraedro = 0.5;

  // Posição do objeto, animação e tamanho
  pushMatrix();
  translate(tetraedroX, tetraedroY, tetraedroZ);
  rotateX(frameCount * 0.01);
  rotateY(frameCount * 0.01);
  rotateZ(frameCount * 0.01);
  scale(escalaTetraedro);

  // Criando o tetraedro e aplicando a textura
  for (int i = 0; i < faces.length; i++) {
    beginShape();
    texture(tetraedro);
    for (int j = 0; j < faces[i].length; j++) {
      int vertexIndex = faces[i][j];
      // Calcula as coordenadas de textura
      float u = (vertices[vertexIndex][0] + 1) / 2;
      float v = (vertices[vertexIndex][1] + 1) / 2;
      vertex(vertices[vertexIndex][0] * 100, vertices[vertexIndex][1] * 100, vertices[vertexIndex][2] * 100, u * tetraedro.width, v * tetraedro.height);
    }
    endShape();
  }
  popMatrix();

  // Nome do tetraedro
  pushMatrix();
  translate(tetraedroX, tetraedroY - 110, 0 + tetraedroZ);
  fill(255);
  textSize(32);
  textAlign(CENTER, CENTER);
  text("TETRAEDRO", 0, 0);
  popMatrix();

  //////////////////////////////////////////////////////////////////////////////////

  // Definindo as Variáveis do octaedro
  int[][] octaedroLados = {
    {0, 1, 2}, {0, 2, 3}, {0, 3, 4}, {0, 4, 1},
    {5, 1, 2}, {5, 2, 3}, {5, 3, 4}, {5, 4, 1}
  };
  float[][] octaedroVertices = {
    { 0, 0, 1},
    { 1, 0, 0},
    { 0, 1, 0},
    {-1, 0, 0},
    { 0, -1, 0},
    { 0, 0, -1}
  };
  float octaedroX = -100;
  float octaedroY = 0;
  float octaedroZ = 0;
  float escalaOctaedro = 0.7;

  // Posição do objeto, animação e tamanho
  pushMatrix();
  translate(octaedroX, octaedroY, octaedroZ);
  rotateX(frameCount * 0.01);
  rotateY(frameCount * 0.01);
  rotateZ(frameCount * 0.01);
  scale(escalaOctaedro);

  // Criando o octaedro e aplicando a textura
  for (int i = 0; i < octaedroLados.length; i++) {
    beginShape();
    texture(octaedro);
    for (int j = 0; j < octaedroLados[i].length; j++) {
      int vertexIndex = octaedroLados[i][j];
      float u = (octaedroVertices[vertexIndex][0] + 1) / 2;
      float v = (octaedroVertices[vertexIndex][1] + 1) / 2;
      vertex(octaedroVertices[vertexIndex][0] * 100,
        octaedroVertices[vertexIndex][1] * 100,
        octaedroVertices[vertexIndex][2] * 100,
        u * octaedro.width, v * octaedro.height);
    }
    endShape();
  }
  popMatrix();

  // Nome do octaedro
  pushMatrix();
  translate(octaedroX, octaedroY - 110, octaedroZ);
  fill(255);
  textSize(32);
  textAlign(CENTER, CENTER);
  text("OCTAEDRO", 0, 0);
  popMatrix();

  //////////////////////////////////////////////////////////////////////////////////

  // Definindo as Variáveis do Prisma Hexagonal
  float[][] prismaHexVertices = {
    // Vértices da base hexagonal
    { 0, -100, 0 },
    { 50 * sqrt(3), -50, 0 },
    { 50 * sqrt(3), 50, 0 },
    { 0, 100, 0 },
    { -50 * sqrt(3), 50, 0 },
    { -50 * sqrt(3), -50, 0 },
    // Vértices do topo hexagonal
    { 0, -100, 200 },
    { 50 * sqrt(3), -50, 200 },
    { 50 * sqrt(3), 50, 200 },
    { 0, 100, 200 },
    { -50 * sqrt(3), 50, 200 },
    { -50 * sqrt(3), -50, 200 }
  };
  int[][] prismaLados = {
    { 0, 1, 7, 6 },
    { 1, 2, 8, 7 },
    { 2, 3, 9, 8 },
    { 3, 4, 10, 9 },
    { 4, 5, 11, 10 },
    { 0, 5, 11, 6 },
    { 0, 1, 2, 3, 4, 5 },
    { 6, 7, 8, 9, 10, 11 }
  };
  float prismaHexX = -300;
  float prismaHexY = 0;
  float prismaHexZ = -50;
  float escalaPrismaHex = 0.5;

  // Posição do objeto, animação e tamanho
  pushMatrix();
  translate(prismaHexX, prismaHexY, prismaHexZ);
  rotateZ(frameCount * 0.01);
  scale(escalaPrismaHex);

  // Criando o Prisma Hexagonal e aplicando a textura
  for (int i = 0; i < prismaLados.length; i++) {
    beginShape();
    texture(prismaHex);
    for (int j = 0; j < prismaLados[i].length; j++) {
      int vertexIndex = prismaLados[i][j];
      float u = map(prismaHexVertices[vertexIndex][0], -50 * sqrt(3), 50 * sqrt(3), 0, prismaHex.width);
      float v = map(prismaHexVertices[vertexIndex][1], -100, 100, 0, prismaHex.height);
      vertex(prismaHexVertices[vertexIndex][0], prismaHexVertices[vertexIndex][1], prismaHexVertices[vertexIndex][2], u, v);
    }
    endShape();
  }
  popMatrix();

  // Nome do prisma
  pushMatrix();
  translate(prismaHexX, prismaHexY - 110, 50 + prismaHexZ);
  fill(255);
  textSize(32);
  textAlign(CENTER, CENTER);
  text("PRISMA", 0, -16);
  text("HEXAGONAL", 0, 16);
  popMatrix();

  //////////////////////////////////////////////////////////////////////////////////

  // Definindo as Variáveis do cilindro
  float cilindroX = -500;
  float cilindroY = 0;
  float cilindroZ = 0;
  float escalaCilindro = 0.9;
  int numSegmentos = 36;
  float radius = 50;
  float height = 100;
  float angleIncrement = TWO_PI / numSegmentos;
  float halfHeight = height / 2;

  // Posição do objeto, animação e tamanho
  pushMatrix();
  translate(cilindroX, cilindroY, cilindroZ);
  rotateX(frameCount * 0.01);
  rotateY(frameCount * 0.01);
  rotateZ(frameCount * 0.01);
  scale(escalaCilindro);

  // Criando o cilindro e aplicando a textura

  // Desenha a face superior
  beginShape(TRIANGLE_FAN);
  texture(cilindro);
  vertex(0, -halfHeight, 0, cilindro.width / 2, cilindro.height / 2);
  for (int i = 0; i <= numSegmentos; i++) {
    float angle = i * angleIncrement;
    float x = radius * cos(angle);
    float z = radius * sin(angle);
    float u = (cilindro.width / 2) + (cilindro.width / 2) * cos(angle);
    float v = (cilindro.height / 2) + (cilindro.height / 2) * sin(angle);
    vertex(x, -halfHeight, z, u, v);
  }
  endShape();

  // Desenha a face inferior
  beginShape(TRIANGLE_FAN);
  texture(cilindro);
  vertex(0, halfHeight, 0, cilindro.width / 2, cilindro.height / 2);
  for (int i = 0; i <= numSegmentos; i++) {
    float angle = i * angleIncrement;
    float x = radius * cos(angle);
    float z = radius * sin(angle);
    float u = (cilindro.width / 2) + (cilindro.width / 2) * cos(angle);
    float v = (cilindro.height / 2) + (cilindro.height / 2) * sin(angle);
    vertex(x, halfHeight, z, u, v);
  }
  endShape();

  // Desenha a superfície lateral
  beginShape(QUAD_STRIP);
  texture(cilindro);
  for (int i = 0; i <= numSegmentos; i++) {
    float angle = i * angleIncrement;
    float x = radius * cos(angle);
    float z = radius * sin(angle);
    float u = (cilindro.width * i) / numSegmentos;
    vertex(x, -halfHeight, z, u, 0);
    vertex(x, halfHeight, z, u, cilindro.height);
  }
  endShape();
  popMatrix();

  // Nome do cilindro
  pushMatrix();
  translate(cilindroX, cilindroY - 110, 0 + cilindroZ);
  fill(255);
  textSize(32);
  textAlign(CENTER, CENTER);
  text("CILINDRO", 0, 0);
  popMatrix();

  //////////////////////////////////////////////////////////////////////////////////

  // Definindo as Variáveis do cone
  float coneX = -700;
  float coneY = 0;
  float coneZ = 0;
  float coneScale = 0.5;
  float coneRadius = 100;
  float coneHeight = 400;
  int sides = 30;
  float angleCone = TWO_PI / sides;
  float textureScaleX = 1.0;
  float textureScaleY = 1.0;

  // Posição do objeto, animação e tamanho
  pushMatrix();
  translate(coneX, coneY, coneZ);
  rotateX(frameCount * 0.01);
  rotateY(frameCount * 0.01);
  rotateZ(frameCount * 0.01);
  scale(coneScale);

  // Criando o cone e aplicando a textura
  beginShape(TRIANGLE_FAN);
  texture(cone);
  vertex(0, 0, coneHeight/2, 0.5, 1);
  for (int i = 0; i <= sides; i++) {
    float angle = i * angleCone;
    float x = coneRadius * cos(angle);
    float y = coneRadius * sin(angle);
    float u = map(x, -coneRadius, coneRadius, 0, textureScaleX) * cone.width;
    float v = map(y, -coneRadius, coneRadius, 0, textureScaleY) * cone.height;
    vertex(x, y, 0, u, v);
  }
  endShape();

  // Desenhando a base do cone
  beginShape();
  texture(cone);
  for (int i = 0; i < sides; i++) {
    float angle = i * angleCone;
    float x = coneRadius * cos(angle);
    float y = coneRadius * sin(angle);
    float u = map(x, -coneRadius, coneRadius, 0, textureScaleX) * cone.width;
    float v = map(y, -coneRadius, coneRadius, 0, textureScaleY) * cone.height;
    vertex(x, y, 0, u, v);
  }
  endShape();
  popMatrix();

  // Nome do cone
  pushMatrix();
  translate(coneX, coneY - 110, 0 +coneZ);
  fill(255);
  textSize(32);
  textAlign(CENTER, CENTER);
  text("CONE", 0, 0);
  popMatrix();

  //////////////////////////////////////////////////////////////////////////////////

  // Definindo as Variáveis do Prisma Triangular
  float prismaTrianX = -900;
  float prismaTrianY = 0;
  float prismaTrianZ = 0;
  float prismaScale = 0.7;

  // Posição do objeto, animação e tamanho
  pushMatrix();
  translate(prismaTrianX, prismaTrianY, prismaTrianZ);
  rotateX(frameCount * 0.01);
  rotateY(frameCount * 0.01);
  rotateZ(frameCount * 0.01);
  scale(prismaScale);

  // Criando o Prisma Triangular e aplicando a textura
  
  float h = 200;
  float a = 100;

  // Coordenadas dos vértices da base inferior
  PVector v0 = new PVector(-a / 2, -a / (2 * sqrt(3)), -h / 2);
  PVector v1 = new PVector(a / 2, -a / (2 * sqrt(3)), -h / 2);
  PVector v2 = new PVector(0, a / sqrt(3), -h / 2);

  // Coordenadas dos vértices da base superior
  PVector v3 = new PVector(-a / 2, -a / (2 * sqrt(3)), h / 2);
  PVector v4 = new PVector(a / 2, -a / (2 * sqrt(3)), h / 2);
  PVector v5 = new PVector(0, a / sqrt(3), h / 2);

  beginShape();
  texture(prismaTriangular);
  vertex(v0.x, v0.y, v0.z, 0, 0);
  vertex(v1.x, v1.y, v1.z, prismaTriangular.width, 0);
  vertex(v2.x, v2.y, v2.z, prismaTriangular.width / 2, prismaTriangular.height);
  endShape();

  beginShape();
  texture(prismaTriangular);
  vertex(v3.x, v3.y, v3.z, 0, 0);
  vertex(v4.x, v4.y, v4.z, prismaTriangular.width, 0);
  vertex(v5.x, v5.y, v5.z, prismaTriangular.width / 2, prismaTriangular.height);
  endShape();

  beginShape(QUADS);
  texture(prismaTriangular);
  vertex(v0.x, v0.y, v0.z, 0, 0);
  vertex(v1.x, v1.y, v1.z, prismaTriangular.width / 2, 0);
  vertex(v4.x, v4.y, v4.z, prismaTriangular.width / 2, prismaTriangular.height);
  vertex(v3.x, v3.y, v3.z, 0, prismaTriangular.height);

  vertex(v1.x, v1.y, v1.z, 0, 0);
  vertex(v2.x, v2.y, v2.z, prismaTriangular.width / 2, 0);
  vertex(v5.x, v5.y, v5.z, prismaTriangular.width / 2, prismaTriangular.height);
  vertex(v4.x, v4.y, v4.z, 0, prismaTriangular.height);

  vertex(v2.x, v2.y, v2.z, 0, 0);
  vertex(v0.x, v0.y, v0.z, prismaTriangular.width / 2, 0);
  vertex(v3.x, v3.y, v3.z, prismaTriangular.width / 2, prismaTriangular.height);
  vertex(v5.x, v5.y, v5.z, 0, prismaTriangular.height);
  endShape();

  popMatrix();

  // Nome do prismaTriangular
  pushMatrix();
  translate(prismaTrianX, prismaTrianY - 110, 0 + prismaTrianZ);
  fill(255);
  textSize(32);
  textAlign(CENTER, CENTER);
  text("PRISMA", 0, -16);
  text("TRIANGULAR", 0, 16);
  popMatrix();
}
