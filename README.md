# 🌐 Ambiente 3D Interativo em Processing

Este projeto implementa um ambiente 3D texturizado, desenvolvido em Processing (P3D).
A cena renderiza múltiplas formas geométricas com texturas individuais e permite a exploração do espaço em tempo real usando teclado e mouse.

# ✨ O que foi implementado

* Formas 3D com texturas:

  * ✅ Torus (toro)
  * ✅ Esfera
  * ✅ Pirâmide
  * ✅ Cubo
  * ✅ Tetraedro
  * ✅ Octaedro
  * ✅ Prisma hexagonal
  * ✅ Cone
  * ✅ Cilindro
  * ✅ Prisma triangular

* Câmera interativa:

  * Rotação com o mouse
  * Movimentação com W, A, S, D
  * Navegação espacial fluida

* Iluminação dinâmica com lights()

* Cenário estruturado contendo:

  * Parede ao fundo com textura + nome renderizado em 3D
  * Piso texturizado (chão)

* Render 3D contínuo via draw()

# 🧩 Conceitos usados

* Coordenadas 3D (translate, rotate, scale)

* Mapeamento e aplicação de texturas com beginShape() + texture()

* Vetores (PVector) para construção de faces 3D

* Transformações de câmera via camera()

# 🚀 Objetivo

Criar uma cena 3D interativa que sirva como base para aplicações visuais e simulações mais complexas, explorando a flexibilidade do Processing para gráficos 3D e interatividade em tempo real.
